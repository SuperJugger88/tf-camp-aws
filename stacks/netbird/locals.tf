locals {
  name_peer = "${var.project_name}-netbird-router"
  name_sg   = "${var.project_name}-sg-netbird"

  vpc_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr_block

  common_tags = merge(var.tags, {
    Project   = var.project_name
    ManagedBy = "terraform"
    Stack     = "netbird"
  })

  user_data = <<-EOT
    #!/bin/bash
    set -euo pipefail
    curl -fsSL https://pkgs.netbird.io/install.sh | sh
    netbird up --setup-key '${netbird_setup_key.routing.key}' --hostname '${local.name_peer}'
  EOT
}
