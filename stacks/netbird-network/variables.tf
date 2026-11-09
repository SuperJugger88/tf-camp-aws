variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "netbird_token" {
  description = "NetBird Management PAT (NB_PAT or TF_VAR_netbird_token)"
  type        = string
  sensitive   = true
}

variable "client_group_name" {
  description = "Existing NetBird group for laptop clients (create in UI, add your peer there)"
  type        = string
  default     = "tf-learn-clients"
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
