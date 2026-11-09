output "rds_endpoint" {
  value = module.postgres.db_instance_endpoint
}

output "rds_arn" {
  value = module.postgres.db_instance_arn
}

output "rds_master_user_secret_arn" {
  value = module.postgres.db_instance_master_user_secret_arn
}

output "rds_username" {
  value = var.db_username
}
