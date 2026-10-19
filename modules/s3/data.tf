data "aws_iam_policy_document" "this" {
  count = var.attach_policy ? 1 : 0

  statement {
    sid    = "AllowSpecificActions"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.policy_principal_arns
    }

    actions = var.policy_actions

    resources = [
      "arn:aws:s3:::${var.bucket}",
      "arn:aws:s3:::${var.bucket}/*",
    ]
  }
}