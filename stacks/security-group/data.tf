data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = var.vpc_state_key
    region  = var.aws_region
    profile = var.aws_profile
  }
}
