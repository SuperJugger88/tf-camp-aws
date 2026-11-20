output "s3_state_user_name" {
  value = module.s3_state_user.name
}

output "s3_state_user_arn" {
  description = "Use as Principal in stacks/s3 bucket policy"
  value       = module.s3_state_user.arn
}

output "s3_state_access_key_id" {
  value = module.s3_state_user.access_key_id
}

output "s3_state_access_key_secret" {
  value     = module.s3_state_user.access_key_secret
  sensitive = true
}

output "s3_state_policy_arn" {
  value = module.s3_state_policy.arn
}
