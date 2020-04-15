variable "name" {
  type        = string
  description = "Service account names"

}

variable "namespace" {
  type        = string
  default     = "default"
  description = "Service account namespace"
}

variable "role_name" {
  type        = string
  default     = null
  description = "IAM Role name"
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_issuer_url" {
  type = string
}

variable "create_service_account" {
  type    = bool
  default = true
}