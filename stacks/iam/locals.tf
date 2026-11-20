locals {
  name_user   = "${var.project_name}-s3-state"
  name_policy = "${var.project_name}-s3-state"

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "iam"
  })
}
