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

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "15.19"
}

variable "family" {
  type    = string
  default = "postgres15"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "port" {
  type    = string
  default = "5432"
}

variable "manage_master_user_password" {
  type    = bool
  default = true
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "backup_retention_period" {
  description = "Backup retention days (Free Tier max is 1)"
  type        = number
  default     = 1
}

variable "backup_window" {
  type    = string
  default = "03:00-04:00"
}

variable "maintenance_window" {
  type    = string
  default = "sun:04:00-sun:05:00"
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
