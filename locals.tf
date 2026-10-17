locals {
  # Unified naming: <project>-<service>-<role>
  name_vpc        = coalesce(var.vpc_name, "${var.project_name}-vpc")
  name_sg_app     = "${var.project_name}-sg-app"
  name_ec2_app    = coalesce(var.instance_name, "${var.project_name}-ec2-app")
  name_rds_pg     = "${var.project_name}-rds-postgres"
  name_s3_tfstate = var.s3_bucket_name

  vpc_cidr = var.vpc_cidr

  public_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 0), # 10.42.0.0/20
    cidrsubnet(local.vpc_cidr, 4, 1), # 10.42.16.0/20
  ]
  private_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 2), # 10.42.32.0/20
    cidrsubnet(local.vpc_cidr, 4, 3), # 10.42.48.0/20
  ]
  database_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 4), # 10.42.64.0/20
    cidrsubnet(local.vpc_cidr, 4, 5), # 10.42.80.0/20
  ]

  public_subnet_names = [
    "${var.project_name}-subnet-public-a",
    "${var.project_name}-subnet-public-b",
  ]
  private_subnet_names = [
    "${var.project_name}-subnet-private-a",
    "${var.project_name}-subnet-private-b",
  ]
  database_subnet_names = [
    "${var.project_name}-subnet-db-a",
    "${var.project_name}-subnet-db-b",
  ]

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
  })
}
