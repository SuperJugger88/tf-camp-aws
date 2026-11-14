output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
}

output "ec2_sg_id" {
  value = module.ec2_sg.security_group_id
}

output "ec2_sg_name" {
  value = module.ec2_sg.security_group_name
}

output "ec2_sg_arn" {
  value = module.ec2_sg.security_group_arn
}

output "app_sg_id" {
  value = module.app_sg.security_group_id
}

output "app_sg_name" {
  value = module.app_sg.security_group_name
}

output "app_sg_arn" {
  value = module.app_sg.security_group_arn
}

output "rds_sg_id" {
  value = module.rds_sg.security_group_id
}

output "rds_sg_name" {
  value = module.rds_sg.security_group_name
}

output "rds_sg_arn" {
  value = module.rds_sg.security_group_arn
}
