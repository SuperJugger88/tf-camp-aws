output "setup_key" {
  description = "Setup key for NetBird routing peer (used by stacks/ec2)"
  value       = module.vpc_access.setup_key
  sensitive   = true
}

output "netbird_clients_group" {
  description = "Laptop peers should be in this group for VPC routes"
  value       = data.netbird_group.clients.name
}

output "netbird_routing_group" {
  description = "Routing peers group created by drtinkerer module"
  value       = module.vpc_access.default_resource_group_name
}

output "netbird_network_name" {
  value = module.vpc_access.network_name
}

output "netbird_network_id" {
  value = module.vpc_access.network_id
}

output "vpc_cidr" {
  value = local.vpc_cidr
}
