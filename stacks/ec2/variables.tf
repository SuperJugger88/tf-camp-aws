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
  description = "Override key pair name (default: <project>-default)"
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

variable "network_state_key" {
  type    = string
  default = "learning/network/terraform.tfstate"
}

variable "netbird_state_key" {
  type    = string
  default = "learning/netbird-network/terraform.tfstate"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "aws_profile" {
  type    = string
  default = "terraform-aws"
}

variable "ami" {
  description = "AMI ID override (null = latest Ubuntu from data.aws_ami)"
  type        = string
  default     = null
}

variable "ami_name_filter" {
  description = "AMI name filter when ami is not set"
  type        = string
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "ami_owner" {
  description = "AMI owner account (Canonical)"
  type        = string
  default     = "099720109477"
}
