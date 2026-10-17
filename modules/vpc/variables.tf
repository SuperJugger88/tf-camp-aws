variable "name" {
  description = "VPC name"
  type        = string
  default     = "tf-learn-vpc"
}

variable "cidr" {
  description = "VPC CIDR (prefer uncommon RFC1918, e.g. 10.42.0.0/16)"
  type        = string
  default     = "10.42.0.0/16"
}

variable "azs" {
  description = "Availability zones (>= 2 for RDS)"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "Database subnet CIDRs (need >= 2 AZs for DB subnet group)"
  type        = list(string)
  default     = []
}

variable "public_subnet_names" {
  description = "Explicit public subnet names"
  type        = list(string)
  default     = []
}

variable "private_subnet_names" {
  description = "Explicit private subnet names"
  type        = list(string)
  default     = []
}

variable "database_subnet_names" {
  description = "Explicit database subnet names"
  type        = list(string)
  default     = []
}

variable "create_database_subnet_group" {
  description = "Create RDS DB subnet group"
  type        = bool
  default     = true
}

variable "create_database_subnet_route_table" {
  description = "Separate route table for database subnets"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
