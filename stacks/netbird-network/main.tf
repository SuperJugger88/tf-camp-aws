module "vpc_access" {
  source  = "drtinkerer/network/netbird"
  version = "1.1.0"

  network_name        = "${var.project_name}-aws-vpc"
  network_description = "AWS VPC ${local.vpc_cidr} for ${var.project_name}"

  network_resources = {
    ec2-cidr = {
      description = "EC2 subnets (public + private)"
      address     = cidrsubnet(local.vpc_cidr, 2, 0)
      enabled     = true
    }
  }

  router_config = {
    metric     = 100
    masquerade = true
    enabled    = true
  }

  create_default_policy = false

  create_setup_key = true
  setup_key_config = {
    name           = "${var.project_name}-routing-peer"
    type           = "reusable"
    expiry_seconds = 0
    usage_limit    = 5
    ephemeral      = false
  }
}

resource "netbird_group" "rds_resources" {
  name = "resources-${var.project_name}-rds"
}

resource "netbird_group" "rds_clients" {
  name = "${var.project_name}-rds-clients"
}

resource "netbird_network_resource" "rds_cidr" {
  network_id  = module.vpc_access.network_id
  name        = "rds-cidr"
  description = "RDS database subnets"
  address     = cidrsubnet(local.vpc_cidr, 3, 2)
  groups      = [netbird_group.rds_resources.id]
  enabled     = true
}

resource "netbird_policy" "ec2_access" {
  name        = "${var.project_name}-clients-to-ec2"
  description = "Allow NetBird clients to reach EC2 subnets via routing peer"
  enabled     = true

  rule {
    name          = "clients-to-ec2"
    action        = "accept"
    bidirectional = true
    protocol      = "all"
    sources       = [data.netbird_group.clients.id]
    destinations  = [module.vpc_access.default_resource_group_id]
  }
}

resource "netbird_policy" "rds_access" {
  name        = "${var.project_name}-rds-clients-to-rds"
  description = "Allow RDS clients to reach RDS subnets via routing peer"
  enabled     = true

  rule {
    name          = "rds-clients-to-rds"
    action        = "accept"
    bidirectional = true
    protocol      = "all"
    sources       = [netbird_group.rds_clients.id]
    destinations  = [netbird_group.rds_resources.id]
  }
}
