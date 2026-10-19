variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Override EC2 key pair (default: from security-group stack)"
  type        = string
  default     = null
}

variable "sg_state_key" {
  type    = string
  default = "learning/security-group/terraform.tfstate"
}

variable "netbird_token" {
  description = "NetBird Management PAT (NB_PAT or TF_VAR_netbird_token)"
  type        = string
  sensitive   = true
}

variable "client_peer_names" {
  description = "NetBird peer names (dashboard) to put in tf-learn-clients for VPC access"
  type        = list(string)
  default     = ["Andrejs-MacBook-Pro.local"]
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

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "aws_profile" {
  type    = string
  default = "terraform-aws"
}
