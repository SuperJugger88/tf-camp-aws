variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket for Terraform state"
  type        = string
  default     = "tf-state-andrei-ivanov-2026"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}

variable "state_bucket" {
  type    = string
  default = "tf-state-andrei-ivanov-2026"
}

variable "iam_state_key" {
  type    = string
  default = "learning/iam/terraform.tfstate"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "aws_profile" {
  type    = string
  default = "terraform-aws"
}
