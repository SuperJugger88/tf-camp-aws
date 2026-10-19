data "netbird_peer" "clients" {
  for_each = toset(var.client_peer_names)
  name     = each.value
}

resource "netbird_group" "routing_peers" {
  name = "${var.project_name}-routing-peers"
}

resource "netbird_group" "clients" {
  name  = "${var.project_name}-clients"
  peers = [for p in data.netbird_peer.clients : p.id]
}

resource "netbird_group" "vpc_resource" {
  name = "${var.project_name}-vpc-resource"
}

resource "netbird_setup_key" "routing" {
  name           = "${var.project_name}-routing-peer"
  type           = "reusable"
  expiry_seconds = 0
  usage_limit    = 5
  ephemeral      = false
  auto_groups    = [netbird_group.routing_peers.id]
}

resource "netbird_network" "vpc" {
  name        = "${var.project_name}-aws-vpc"
  description = "AWS VPC ${local.vpc_cidr} for ${var.project_name}"
}

resource "netbird_network_resource" "vpc_cidr" {
  network_id  = netbird_network.vpc.id
  name        = "${var.project_name}-vpc-cidr"
  description = "Full VPC CIDR"
  address     = local.vpc_cidr
  groups      = [netbird_group.vpc_resource.id]
  enabled     = true
}

resource "netbird_network_router" "vpc" {
  network_id  = netbird_network.vpc.id
  peer_groups = [netbird_group.routing_peers.id]
  metric      = 100
  enabled     = true
  masquerade  = true
}

resource "netbird_policy" "clients_to_vpc" {
  name        = "${var.project_name}-clients-to-vpc"
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

# SSH/ping to the routing peer itself over NetBird overlay IP (100.x)
resource "netbird_policy" "clients_to_router" {
  name        = "${var.project_name}-clients-to-router"
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

# Explicit Network Route so clients get 10.42.0.0/16 installed locally
resource "netbird_route" "vpc" {
  network_id            = "${var.project_name}-vpc"
  description           = "AWS VPC CIDR via routing peer"
  network               = local.vpc_cidr
  peer_groups           = [netbird_group.routing_peers.id]
  groups                = [netbird_group.clients.id]
  access_control_groups = [netbird_group.vpc_resource.id]
  masquerade            = true
  enabled               = true
}
