module "security_group" {
  source = "../security-group"

  name        = local.name_sg
  description = "NetBird routing peer SG"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr
      description = "SSH from VPC"
    }
  ]

  tags = merge(var.tags, { Name = local.name_sg })
}

module "routing_peer" {
  source = "../ec2"

  name                        = local.name_peer
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [module.security_group.sg_id]
  associate_public_ip_address = true
  source_dest_check           = false
  monitoring                  = false

  user_data                   = local.user_data
  user_data_replace_on_change = true

  tags = merge(var.tags, { Name = local.name_peer })

  depends_on = [netbird_setup_key.routing]
}
