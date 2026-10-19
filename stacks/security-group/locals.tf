locals {
  name_sg_app = "${var.project_name}-sg-app"

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "security-group"
  })
}
