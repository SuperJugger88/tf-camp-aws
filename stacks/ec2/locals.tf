locals {
  name_ec2_app = coalesce(var.instance_name, "${var.project_name}-ec2-app")

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "ec2"
  })
}
