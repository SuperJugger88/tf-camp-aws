output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = local.vpc_cidr
}

output "names" {
  description = "Canonical resource names"
  value = {
    vpc     = local.name_vpc
    sg_app  = local.name_sg_app
    ec2_app = local.name_ec2_app
    rds     = local.name_rds_pg
    s3      = local.name_s3_tfstate
  }
}

output "instance_id" {
  description = "EC2 app instance ID"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "EC2 public IP (SSH)"
  value       = module.ec2.public_ip
}

output "instance_private_ip" {
  description = "EC2 private IP"
  value       = module.ec2.private_ip
}

output "security_group_id" {
  description = "App security group ID"
  value       = module.security_group.sg_id
}

output "rds_endpoint" {
  description = "Postgres endpoint"
  value       = module.rds.rds_endpoint
}

output "s3_bucket_id" {
  description = "S3 state bucket name"
  value       = module.s3.s3_bucket_id
}
