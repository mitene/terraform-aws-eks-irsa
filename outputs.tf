output "name" {
  value       = var.name
  description = "Service Account Name"
}

output "namespace" {
  value       = var.namespace
  description = "Service Account Namespace"
}

output "role_arn" {
  value = aws_iam_role.this.arn
}

output "role_id" {
  value = aws_iam_role.this.id
}
