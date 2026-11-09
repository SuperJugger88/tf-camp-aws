variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "instance_name" {
  type    = string
  default = null
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Override key pair name (default: <project>-default via modules/key-pair)"
  type        = string
  default     = null
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
