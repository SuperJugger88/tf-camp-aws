output "routing_peer_instance_id" {
  value = module.routing_peer.instance_id
}

output "routing_peer_private_ip" {
  value = module.routing_peer.private_ip
}

output "routing_peer_public_ip" {
  value = module.routing_peer.public_ip
}

output "routing_peer_sg_id" {
  value = module.security_group.sg_id
}

output "netbird_clients_group" {
  description = "Add your laptop peer to this group in NetBird UI"
  value       = netbird_group.clients.name
}

output "netbird_network_name" {
  value = netbird_network.vpc.name
}

output "vpc_cidr" {
  value = local.vpc_cidr
}
