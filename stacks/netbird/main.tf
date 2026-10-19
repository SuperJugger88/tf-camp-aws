module "security_group" {
  source = "../../modules/security-group"

  name        = local.name_sg
  description = "NetBird routing peer SG"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # NetBird overlay is outbound; SSH only from inside VPC (via NetBird masquerade / jump).
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
      description = "SSH from VPC"
    }
  ]

  tags = merge(local.common_tags, { Name = local.name_sg })
}

module "routing_peer" {
  source = "../../modules/ec2"

  name                        = local.name_peer
  instance_type               = var.instance_type
  key_name                    = coalesce(var.key_name, data.terraform_remote_state.security_group.outputs.key_name)
  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids      = [module.security_group.sg_id]
  associate_public_ip_address = true
  source_dest_check           = false
  monitoring                  = false

  user_data                   = local.user_data
  user_data_replace_on_change = true

  tags = merge(local.common_tags, { Name = local.name_peer })

  depends_on = [netbird_setup_key.routing]
}
