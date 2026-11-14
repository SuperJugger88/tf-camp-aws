locals {
  vpc_cidr = data.terraform_remote_state.network.outputs.vpc_cidr_block

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "netbird-network"
  })
}
