variable "project_name" {
  type    = string
  default = "tf-learn"
}

variable "vpc_name" {
  type    = string
  default = null
}

variable "vpc_cidr" {
  type    = string
  default = "10.42.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
  }
}
