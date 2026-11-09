data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  owners = [var.ami_owner]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = var.vpc_state_key
    region  = var.aws_region
    profile = var.aws_profile
  }
}

data "terraform_remote_state" "security_group" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = var.sg_state_key
    region  = var.aws_region
    profile = var.aws_profile
  }
}

data "terraform_remote_state" "netbird_network" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket
    key     = var.netbird_state_key
    region  = var.aws_region
    profile = var.aws_profile
  }
}
