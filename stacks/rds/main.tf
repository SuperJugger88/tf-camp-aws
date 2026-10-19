module "rds" {
  source = "../../modules/rds"

  identifier             = local.name_rds_pg
  db_name                = var.db_name
  db_username            = var.db_username
  snapshot_identifier    = var.snapshot_identifier
  vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.sg_id]
  db_subnet_group_name   = data.terraform_remote_state.vpc.outputs.database_subnet_group

  tags = merge(local.common_tags, { Name = local.name_rds_pg })
}
