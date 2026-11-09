provider "aws" {
  region  = "ap-southeast-2"
  profile = "terraform-aws"
}

provider "netbird" {
  token = var.netbird_token
}
