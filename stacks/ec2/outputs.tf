output "instance_id" {
  value = module.app.id
}

output "public_ip" {
  value = module.app.public_ip
}

output "private_ip" {
  value = module.app.private_ip
}

output "key_name" {
  description = "EC2 key pair name"
  value       = module.key_pair.key_pair_name
}

output "netbird_router_instance_id" {
  value = module.netbird_router.id
}

output "netbird_router_private_ip" {
  value = module.netbird_router.private_ip
}

output "netbird_router_public_ip" {
  value = module.netbird_router.public_ip
}
