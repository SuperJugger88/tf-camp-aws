output "setup_key" {
  description = "Routing peer setup key (sensitive)"
  value       = netbird_setup_key.routing.key
  sensitive   = true
}

output "clients_group_name" {
  value = netbird_group.clients.name
}

output "clients_group_id" {
  value = netbird_group.clients.id
}

output "routing_peers_group_name" {
  value = netbird_group.routing_peers.name
}

output "network_name" {
  value = netbird_network.vpc.name
}

output "network_id" {
  value = netbird_network.vpc.id
}

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
