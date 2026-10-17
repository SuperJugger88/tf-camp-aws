module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name = var.name

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  monitoring                  = var.monitoring
  associate_public_ip_address = var.associate_public_ip_address

  user_data                   = var.user_data
  user_data_base64            = var.user_data_base64
  user_data_replace_on_change = var.user_data_replace_on_change

  create_iam_instance_profile = var.create_iam_instance_profile
  iam_instance_profile        = var.iam_instance_profile
  iam_role_name               = var.iam_role_name
  iam_role_description        = var.iam_role_description
  iam_role_policies           = var.iam_role_policies

  root_block_device = var.root_block_device
  ebs_volumes       = var.ebs_volumes
  ebs_optimized     = var.ebs_optimized

  disable_api_termination = var.disable_api_termination
  disable_api_stop        = var.disable_api_stop

  enable_volume_tags = var.enable_volume_tags
  volume_tags        = var.volume_tags
  metadata_options   = var.metadata_options
  tags               = var.tags
}
