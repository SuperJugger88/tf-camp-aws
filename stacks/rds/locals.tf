locals {
  name_rds_pg = "${var.project_name}-rds-postgres"

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "rds"
  })
}
