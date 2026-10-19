variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket for Terraform state"
  type        = string
  default     = "tf-state-andrei-ivanov-2026"
}

variable "s3_policy_principal_arn" {
  type    = string
  default = "arn:aws:iam::060077938123:user/terraform-admin"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}
