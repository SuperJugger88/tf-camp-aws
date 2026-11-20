variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "s3_bucket_name" {
  description = "State bucket the dedicated IAM user may access"
  type        = string
  default     = "tf-state-andrei-ivanov-2026"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}
