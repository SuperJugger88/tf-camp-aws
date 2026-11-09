output "routing_peer_instance_id" {
  value = module.netbird.routing_peer_instance_id
}

output "routing_peer_private_ip" {
  value = module.netbird.routing_peer_private_ip
}

output "routing_peer_public_ip" {
  value = module.netbird.routing_peer_public_ip
}

output "routing_peer_sg_id" {
  value = module.netbird.routing_peer_sg_id
}

output "netbird_clients_group" {
  description = "Laptop peers should be in this group for VPC routes"
  value       = module.netbird.clients_group_name
}

output "netbird_network_name" {
  value = module.netbird.network_name
}

output "vpc_cidr" {
  value = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
}
