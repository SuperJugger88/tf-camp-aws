module "s3_state_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 6.0"

  name        = local.name_policy
  description = "Least-privilege access to Terraform state bucket for ${local.name_user}"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ListStateBucket"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketVersioning",
          "s3:GetBucketLocation",
        ]
        Resource = ["arn:aws:s3:::${var.s3_bucket_name}"]
      },
      {
        Sid    = "StateObjects"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Resource = ["arn:aws:s3:::${var.s3_bucket_name}/*"]
      },
    ]
  })

  tags = local.common_tags
}

module "s3_state_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 6.0"

  name                 = local.name_user
  force_destroy        = true
  create_login_profile = false
  create_access_key    = true

  policies = {
    s3_state = module.s3_state_policy.arn
  }

  tags = merge(local.common_tags, { Name = local.name_user })
}
