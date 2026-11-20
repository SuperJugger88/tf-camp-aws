locals {
  name_vpc = coalesce(var.vpc_name, "${var.project_name}-vpc")
  vpc_cidr = var.vpc_cidr

  public_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 0),
    cidrsubnet(local.vpc_cidr, 4, 1),
  ]
  private_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 2),
    cidrsubnet(local.vpc_cidr, 4, 3),
  ]
  database_subnets = [
    cidrsubnet(local.vpc_cidr, 4, 4),
    cidrsubnet(local.vpc_cidr, 4, 5),
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

  name_sg_ec2 = "${var.project_name}-sg-ec2"
  name_sg_mystique_server = "${var.project_name}-sg-mystique-server"
  name_sg_rds = "${var.project_name}-sg-rds"

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "network"
  })
}
