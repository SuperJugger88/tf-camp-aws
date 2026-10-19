variable "identifier" {
  description = "RDS instance identifier (e.g. tf-learn-rds-postgres)"
  type        = string
  default     = "tf-learn-rds-postgres"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Database engine version (must exist in selected Region)"
  type        = string
  default     = "15.19"
}

variable "family" {
  description = "DB parameter group family (must match major engine version)"
  type        = string
  default     = "postgres15"
}

variable "instance_class" {
  description = "RDS instance class (free tier: db.t3.micro)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Storage autoscaling ceiling in GB"
  type        = number
  default     = 100
}

variable "storage_encrypted" {
  description = "Encrypt storage at rest (recommended)"
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp3"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username (avoid reserved: admin, root, etc.)"
  type        = string
  default     = "app_admin"
  validation {
    condition     = length(var.db_username) >= 1 && length(var.db_username) <= 32
    error_message = "Username must be between 1 and 32 characters."
  }
}

variable "manage_master_user_password" {
  description = "Let RDS manage password in Secrets Manager"
  type        = bool
  default     = true
}

variable "port" {
  description = "Database port"
  type        = string
  default     = "5432"
}

variable "vpc_security_group_ids" {
  description = "Security groups for the DB"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "DB subnet group (must span >= 2 AZs)"
  type        = string
}

variable "publicly_accessible" {
  description = "Publicly accessible (keep false)"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Multi-AZ (costs more; false for free-tier lab)"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Restore from snapshot"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Deletion protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy (ok for lab; set false in real envs)"
  type        = bool
  default     = true
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

variable "tags" {
  type    = map(string)
  default = {}
}
