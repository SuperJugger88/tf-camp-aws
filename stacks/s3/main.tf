module "tf_state" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.0"

  bucket        = var.s3_bucket_name
  force_destroy = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    enabled = true
  }

  attach_policy = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3StateUserObjects"
        Effect = "Allow"
        Principal = {
          AWS = data.terraform_remote_state.iam.outputs.s3_state_user_arn
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Resource = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
      },
      {
        Sid    = "AllowS3StateUserList"
        Effect = "Allow"
        Principal = {
          AWS = data.terraform_remote_state.iam.outputs.s3_state_user_arn
        }
        Action   = ["s3:ListBucket"]
        Resource = ["arn:aws:s3:::${var.s3_bucket_name}"]
      },
    ]
  })

  tags = merge(local.common_tags, { Name = var.s3_bucket_name })
}
