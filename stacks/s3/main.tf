module "s3" {
  source = "../../modules/s3"

  bucket                = var.s3_bucket_name
  attach_policy         = true
  policy_principal_arns = [var.s3_policy_principal_arn]
  tags                  = merge(local.common_tags, { Name = var.s3_bucket_name })
}
