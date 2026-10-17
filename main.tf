module "vpc" {
  source = "./modules/vpc"

  name = local.name_vpc
  cidr = local.vpc_cidr
  azs  = var.azs

  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  public_subnet_names   = local.public_subnet_names
  private_subnet_names  = local.private_subnet_names
  database_subnet_names = local.database_subnet_names

  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  enable_dns_hostnames               = true
  enable_dns_support                 = true

  tags = local.common_tags
}

module "security_group" {
  source = "./modules/security-group"

  name        = local.name_sg_app
  description = "App SG for ${var.project_name}: SSH + Postgres from private subnets"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = join(",", module.vpc.private_subnets_cidr_blocks)
      description = "PostgreSQL from private app subnets"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
      description = "SSH from within VPC only"
    }
  ]

  tags = merge(local.common_tags, { Name = local.name_sg_app })
}

module "rds" {
  source = "./modules/rds"

  identifier             = local.name_rds_pg
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  snapshot_identifier    = var.snapshot_identifier
  vpc_security_group_ids = [module.security_group.sg_id]
  db_subnet_group_name   = module.vpc.database_subnet_group

  tags = merge(local.common_tags, { Name = local.name_rds_pg })
}

module "ec2" {
  source = "./modules/ec2"

  name                   = local.name_ec2_app
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.security_group.sg_id]

  # Learning: public IP for SSH. Prod would sit in private + bastion/SSM.
  associate_public_ip_address = true
  monitoring                  = false

  tags = merge(local.common_tags, { Name = local.name_ec2_app })
}

module "s3" {
  source = "./modules/s3"

  bucket = local.name_s3_tfstate
  tags   = merge(local.common_tags, { Name = local.name_s3_tfstate })
}

resource "aws_s3_bucket_policy" "tf_learn_state_policy" {
  bucket = module.s3.s3_bucket_id
  policy = data.aws_iam_policy_document.bucket_policy.json
}
