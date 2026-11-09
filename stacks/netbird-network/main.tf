module "vpc_access" {
  source  = "drtinkerer/network/netbird"
  version = "1.1.0"

  network_name        = "${var.project_name}-aws-vpc"
  network_description = "AWS VPC ${local.vpc_cidr} for ${var.project_name}"

  network_resources = {
    vpc-cidr = {
      description = "Full VPC CIDR"
      address     = local.vpc_cidr
      enabled     = true
    }
  }

  router_config = {
    metric     = 100
    masquerade = true
    enabled    = true
  }

  create_default_policy = true
  allowed_source_groups = [data.netbird_group.clients.id]

  policy_config = {
    name          = "${var.project_name}-clients-to-vpc"
    description   = "Allow NetBird clients to reach VPC via routing peer"
    protocol      = "all"
    bidirectional = true
    enabled       = true
  }

  create_setup_key = true
  setup_key_config = {
    name           = "${var.project_name}-routing-peer"
    type           = "reusable"
    expiry_seconds = 0
    usage_limit    = 5
    ephemeral      = false
  }
}
