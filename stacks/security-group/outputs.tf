output "sg_id" {
  value = module.security_group.sg_id
}

output "sg_name" {
  value = module.security_group.sg_name
}

output "sg_arn" {
  value = module.security_group.sg_arn
}

output "key_name" {
  description = "Default EC2 key pair (files/ssh_default.pub)"
  value       = aws_key_pair.default.key_name
}
