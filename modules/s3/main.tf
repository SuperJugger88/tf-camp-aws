module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.0"

  bucket        = var.bucket
  force_destroy = var.force_destroy

  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  server_side_encryption_configuration = var.server_side_encryption_configuration

  versioning = var.versioning

  tags = var.tags
}
