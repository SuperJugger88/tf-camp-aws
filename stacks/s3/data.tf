data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = var.iam_state_key
    region  = var.aws_region
    profile = var.aws_profile
  }
}
