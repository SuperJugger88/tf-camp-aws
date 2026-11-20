locals {
  name_mystique_server = coalesce(var.instance_name, "${var.project_name}-mystique-server")
  name_netbird_router  = "${var.project_name}-netbird-router"
  key_name             = coalesce(var.key_name, "${var.project_name}-default")

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "ec2"
  })

  netbird_user_data = <<-EOT
    #!/bin/bash
    set -euo pipefail
    curl -fsSL https://pkgs.netbird.io/install.sh | sh
    netbird up --setup-key '${data.terraform_remote_state.netbird_network.outputs.setup_key}' --hostname '${local.name_netbird_router}'
  EOT
}
