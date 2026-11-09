data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = var.vpc_state_key
    region  = var.aws_region
    profile = var.aws_profile
  }
}

# Clients group must exist in NetBird (create once in UI). Add laptop peers there.
data "netbird_group" "clients" {
  name = var.client_group_name
}
