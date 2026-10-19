module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = var.identifier

  engine                = var.engine
  engine_version        = var.engine_version
  family                = var.family
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = var.storage_encrypted
  storage_type          = var.storage_type

  db_name  = var.db_name
  username = var.db_username
  port     = var.port

  manage_master_user_password = var.manage_master_user_password

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  publicly_accessible    = var.publicly_accessible
  multi_az               = var.multi_az

  snapshot_identifier     = var.snapshot_identifier
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  tags = var.tags
}
