output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_arn" {
  value = module.rds.rds_arn
}

output "rds_master_user_secret_arn" {
  value = module.rds.rds_master_user_secret_arn
}

output "rds_username" {
  value = module.rds.rds_username
}
