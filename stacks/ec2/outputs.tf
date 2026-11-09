output "instance_id" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "private_ip" {
  value = module.ec2.private_ip
}

output "key_name" {
  description = "EC2 key pair (owned by this stack; reusable by netbird etc.)"
  value       = module.ec2.key_name
}
