variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "app_admin"
}

variable "snapshot_identifier" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}

variable "state_bucket" {
  type    = string
  default = "tf-state-andrei-ivanov-2026"
}

variable "vpc_state_key" {
  type    = string
  default = "learning/vpc/terraform.tfstate"
}

variable "sg_state_key" {
  type    = string
  default = "learning/security-group/terraform.tfstate"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "aws_profile" {
  type    = string
  default = "terraform-aws"
}
