module "netbird" {
  source = "../../modules/netbird"

  name_prefix       = var.project_name
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr          = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
  subnet_id         = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  key_name = coalesce(
    var.key_name,
    try(data.terraform_remote_state.ec2.outputs.key_name, null),
    "${var.project_name}-default",
  )
  instance_type     = var.instance_type
  client_peer_names = var.client_peer_names
  tags              = local.common_tags
}
