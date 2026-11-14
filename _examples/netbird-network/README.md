# stacks/netbird-network — NetBird overlay for the VPC

Creates the NetBird side of the VPN mesh:

- Network `tf-learn-aws-vpc` with two routed address resources:
  - `ec2-cidr` = `10.42.0.0/18` (public + private subnets)
  - `rds-cidr` = `10.42.64.0/19` (database subnets)
- **Separate access policies** per client group:
  - `tf-learn-clients` → `ec2-cidr` only
  - `tf-learn-rds-clients` → `rds-cidr` only
- Routing peer group `resources-tf-learn-aws-vpc` (the EC2 router joins it)
- Reusable setup key consumed by `stacks/ec2` via remote state

The heavy lifting (network, router, setup key, ec2 resource) is done by
`drtinkerer/network/netbird` v1.1.0. Because that module puts ALL resources
into ONE group and supports only ONE policy, the RDS resource and both
policies are raw `netbird_*` resources in `main.tf`.

Requires `netbird_token` — a Management PAT from the NetBird dashboard
(Settings → Access Tokens). Pass via `TF_VAR_netbird_token` or tfvars.
