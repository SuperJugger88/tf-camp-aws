output "sg_id" {
  description = "ID of the security group"
  value       = module.security_group.security_group_id
}

output "sg_name" {
  description = "Name of the security group"
  value       = module.security_group.security_group_name
}

output "sg_arn" {
  description = "ARN of the security group"
  value       = module.security_group.security_group_arn
}
