terraform {
  required_version = ">= 1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    netbird = {
      source  = "netbirdio/netbird"
      version = "~> 0.0"
    }
  }
}
