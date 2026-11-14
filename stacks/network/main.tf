module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  name = local.name_vpc
  cidr = local.vpc_cidr
  azs  = var.azs

  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  public_subnet_names   = local.public_subnet_names
  private_subnet_names  = local.private_subnet_names
  database_subnet_names = local.database_subnet_names

  enable_nat_gateway     = true
  single_nat_gateway     = true
  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  enable_dns_hostnames               = true
  enable_dns_support                 = true

  tags = local.common_tags
}

module "ec2_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name_sg_ec2
  description = "Common EC2 SG for ${var.project_name}: SSH + ICMP from VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
      description = "SSH from within VPC (incl. NetBird routing peer)"
    },
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = module.vpc.vpc_cidr_block
      description = "All ICMP from within VPC"
    }
  ]

  tags = merge(local.common_tags, { Name = local.name_sg_ec2 })
}

module "app_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name_sg_app
  description = "App SG for ${var.project_name}: SSH + Postgres from private subnets"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
      description = "HTTPS from within VPC"
    }
  ]

  tags = merge(local.common_tags, { Name = local.name_sg_app })
}

module "rds_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name_sg_rds
  description = "RDS SG for ${var.project_name}: PostgreSQL from VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
      description = "PostgreSQL from VPC (incl. NetBird routing peer)"
    }
  ]

  tags = merge(local.common_tags, { Name = local.name_sg_rds })
}
