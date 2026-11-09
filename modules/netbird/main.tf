resource "netbird_group" "routing_peers" {
  name = "${var.name_prefix}-routing-peers"
}

resource "netbird_group" "clients" {
  name  = "${var.name_prefix}-clients"
  peers = [for p in data.netbird_peer.clients : p.id]
}

resource "netbird_group" "vpc_resource" {
  name = "${var.name_prefix}-vpc-resource"
}

resource "netbird_setup_key" "routing" {
  name           = "${var.name_prefix}-routing-peer"
  type           = "reusable"
  expiry_seconds = 0
  usage_limit    = var.setup_key_usage_limit
  ephemeral      = false
  auto_groups    = [netbird_group.routing_peers.id]
}

resource "netbird_network" "vpc" {
  name        = "${var.name_prefix}-aws-vpc"
  description = "AWS VPC ${var.vpc_cidr} for ${var.name_prefix}"
}

resource "netbird_network_resource" "vpc_cidr" {
  network_id  = netbird_network.vpc.id
  name        = "${var.name_prefix}-vpc-cidr"
  description = "Full VPC CIDR"
  address     = var.vpc_cidr
  groups      = [netbird_group.vpc_resource.id]
  enabled     = true
}

resource "netbird_network_router" "vpc" {
  network_id  = netbird_network.vpc.id
  peer_groups = [netbird_group.routing_peers.id]
  metric      = var.route_metric
  enabled     = true
  masquerade  = true
}

resource "netbird_route" "vpc" {
  network_id            = "${var.name_prefix}-vpc"
  description           = "AWS VPC CIDR via routing peer"
  network               = var.vpc_cidr
  peer_groups           = [netbird_group.routing_peers.id]
  groups                = [netbird_group.clients.id]
  access_control_groups = [netbird_group.vpc_resource.id]
  masquerade            = true
  enabled               = true
}

resource "netbird_policy" "clients_to_vpc" {
  name        = "${var.name_prefix}-clients-to-vpc"
  description = "Allow NetBird clients to reach VPC via routing peer"
  enabled     = true

  rule {
    name          = "all-to-vpc"
    action        = "accept"
    bidirectional = true
    enabled       = true
    protocol      = "all"
    sources       = [netbird_group.clients.id]
    destinations  = [netbird_group.vpc_resource.id]
  }
}

resource "netbird_policy" "clients_to_router" {
  name        = "${var.name_prefix}-clients-to-router"
  description = "Allow clients to reach routing peer overlay"
  enabled     = true

  rule {
    name          = "all-to-router"
    action        = "accept"
    bidirectional = true
    enabled       = true
    protocol      = "all"
    sources       = [netbird_group.clients.id]
    destinations  = [netbird_group.routing_peers.id]
  }
}
