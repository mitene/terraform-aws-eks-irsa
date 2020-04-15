resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = var.role_name
}

# ref. https://docs.aws.amazon.com/eks/latest/userguide/specify-service-account-role.html
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = format("%s:sub", replace(var.oidc_issuer_url, "https://", ""))
      values = [
        format("system:serviceaccount:%s:%s", var.namespace, var.name)
      ]
    }
  }
}

resource "kubernetes_service_account" "this" {
  count = var.create_service_account ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
    }
  }
  automount_service_account_token = true
}
