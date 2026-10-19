variable "bucket" {
  description = "S3 bucket name (globally unique)"
  type        = string
}

variable "force_destroy" {
  description = "Allow destroying bucket with objects"
  type        = bool
  default     = false
}

variable "control_object_ownership" {
  description = "Whether to manage S3 Bucket Ownership Controls"
  type        = bool
  default     = true
}

variable "object_ownership" {
  description = "Object ownership setting"
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "server_side_encryption_configuration" {
  description = "Server-side encryption configuration"
  type        = any
  default = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}

variable "versioning" {
  description = "Versioning configuration"
  type        = map(string)
  default = {
    status = "Enabled"
  }
}

variable "attach_policy" {
  description = "Attach a bucket policy"
  type        = bool
  default     = false
}

variable "policy_principal_arns" {
  description = "IAM principal ARNs allowed by the bucket policy"
  type        = list(string)
  default     = []
}

variable "policy_actions" {
  description = "S3 actions allowed for policy principals"
  type        = list(string)
  default = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:ListBucket",
  ]
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
