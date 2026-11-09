module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0"

  key_name   = local.key_name
  public_key = file("${path.module}/../../files/ssh_default.pub")

  tags = local.common_tags
}

module "app" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name          = local.name_ec2_app
  instance_type = var.instance_type
  key_name      = module.key_pair.key_pair_name

  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids      = [data.terraform_remote_state.security_group.outputs.sg_id]
  associate_public_ip_address = true
  monitoring                  = false

  ami = coalesce(var.ami, data.aws_ami.ubuntu.id)

  tags = merge(local.common_tags, { Name = local.name_ec2_app })
}

module "netbird_router" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name          = local.name_netbird_router
  instance_type = var.instance_type
  key_name      = module.key_pair.key_pair_name
  ami           = coalesce(var.ami, data.aws_ami.ubuntu.id)

  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  vpc_security_group_ids      = [data.terraform_remote_state.security_group.outputs.sg_id]
  associate_public_ip_address = true
  source_dest_check           = false
  monitoring                  = false

  user_data                   = local.netbird_user_data
  user_data_replace_on_change = true

  tags = merge(local.common_tags, { Name = local.name_netbird_router })
}
