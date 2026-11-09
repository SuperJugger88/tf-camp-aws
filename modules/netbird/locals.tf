locals {
  name_peer = "${var.name_prefix}-netbird-router"
  name_sg   = "${var.name_prefix}-sg-netbird"

  user_data = <<-EOT
    #!/bin/bash
    set -euo pipefail
    curl -fsSL https://pkgs.netbird.io/install.sh | sh
    netbird up --setup-key '${netbird_setup_key.routing.key}' --hostname '${local.name_peer}'
  EOT
}
