terraform {
  backend "s3" {
    bucket  = "tf-state-andrei-ivanov-2026"
    key     = "learning/ec2/terraform.tfstate"
    region  = "ap-southeast-2"
    profile = "terraform-aws"
  }
}
