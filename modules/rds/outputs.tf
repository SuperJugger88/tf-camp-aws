output "rds_arn" {
  description = "ARN of the RDS instance"
  value       = module.rds.db_instance_arn
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_port" {
  description = "Port of the RDS instance"
  value       = module.rds.db_instance_port
}

output "rds_name" {
  description = "Name of the database"
  value       = module.rds.db_instance_name
}

output "rds_id" {
  description = "ID of the RDS instance"
  value       = module.rds.db_instance_identifier
}

output "rds_master_user_secret_arn" {
  description = "Secrets Manager ARN for RDS-managed master password"
  value       = local.master_user_secret_arn
}

output "rds_username" {
  description = "Master username (password is in Secrets Manager)"
  value       = var.db_username
}
