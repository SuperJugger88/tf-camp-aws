module "security_group" {
  source = "../../modules/security-group"

  name        = local.name_sg_app
  description = "App SG for ${var.project_name}: SSH + Postgres from private subnets"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = join(",", data.terraform_remote_state.vpc.outputs.private_subnets_cidr_blocks)
      description = "PostgreSQL from private app subnets"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
      description = "SSH from within VPC only"
    }
  ]

  tags = merge(local.common_tags, { Name = local.name_sg_app })
}
