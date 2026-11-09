module "ec2" {
  source = "../../modules/ec2"

  name                   = local.name_ec2_app
  instance_type          = var.instance_type
  create_key_pair        = true
  key_name               = coalesce(var.key_name, "${var.project_name}-default")
  public_key             = file("${path.module}/../../files/ssh_default.pub")
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.sg_id]

  # Learning: public IP for SSH. Prod would sit in private + bastion/SSM.
  associate_public_ip_address = true
  monitoring                  = false

  tags = merge(local.common_tags, { Name = local.name_ec2_app })
}
