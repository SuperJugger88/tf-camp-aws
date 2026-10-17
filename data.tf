data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "AllowSpecificActions"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::060077938123:user/terraform-admin"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      module.s3.s3_bucket_arn,
      "${module.s3.s3_bucket_arn}/*"
    ]
  }
}
