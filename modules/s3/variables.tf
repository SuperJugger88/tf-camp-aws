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

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
