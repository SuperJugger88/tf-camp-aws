output "key_name" {
  description = "Key pair name attached to the instance"
  value       = local.key_name
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instance.id
}

output "arn" {
  description = "ARN of the EC2 instance"
  value       = module.ec2_instance.arn
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2_instance.private_ip
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "private_dns" {
  description = "Private DNS name of the EC2 instance"
  value       = module.ec2_instance.private_dns
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.ec2_instance.public_dns
}
