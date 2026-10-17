variable "project_name" {
  description = "Prefix for all resource names: <project>-<service>-<role>"
  type        = string
  default     = "tf-learn"
}

variable "instance_name" {
  description = "Override EC2 name (default: <project>-ec2-app)"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type (free tier eligible: t3.micro)"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair for SSH (create in console first)"
  type        = string
  default     = null
}

variable "db_name" {
  description = "Initial Postgres database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Postgres master username (not 'admin'/'root' — reserved by RDS)"
  type        = string
  default     = "app_admin"
}

variable "db_password" {
  description = "Postgres master password (set via TF_VAR_db_password or -var)"
  type        = string
  sensitive   = true
}

variable "snapshot_identifier" {
  description = "Optional snapshot to restore from"
  type        = string
  default     = null
}

variable "s3_bucket_name" {
  description = "Globally unique S3 bucket for Terraform state"
  type        = string
  # Existing bucket — do not rename without migrating backend
  default = "tf-state-andrei-ivanov-2026"
}

variable "vpc_name" {
  description = "Override VPC name (default: <project>-vpc)"
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "VPC CIDR (avoid 10.0.0.0/16, 192.168.0.0/16, Docker 172.17.0.0/16)"
  type        = string
  default     = "10.42.0.0/16"
}

variable "azs" {
  description = "AZs (need >= 2 for RDS subnet group)"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "tags" {
  description = "Extra tags merged into common tags"
  type        = map(string)
  default = {
    Environment = "dev"
  }
}
