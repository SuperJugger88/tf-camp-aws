# tf-camp-aws

Learning Terraform project for AWS infrastructure: a VPC with segmented
security groups, EC2 workloads, a NetBird-based mesh VPN for private access,
RDS PostgreSQL, and a shared S3 backend for remote state.

## Architecture

```
                 ┌────────────────────────── AWS (ap-southeast-2) ──────────────────────────┐
                 │                                                                            │
  NetBird client ├── WireGuard ──▶ NetBird routing peer (EC2, private subnet, no public IP)   │
  (your laptop)  │                    │ masquerade                                             │
                 │                    ▼                                                        │
                 │            VPC 10.42.0.0/16                                                 │
                 │   ┌────────────────┬──────────────────┬────────────────┐                  │
                 │   │ public subnets │ private subnets  │ database subnets│                  │
                 │   │  (IGW)         │  (NAT Gateway)   │  (no egress)    │                  │
                 │   └────────────────┴──────────────────┴────────────────┘                  │
                 │        EC2 app         NetBird router          RDS PostgreSQL               │
                 └────────────────────────────────────────────────────────────────────────────┘
```

- **`stacks/network`** — VPC (public/private/database subnets), one NAT Gateway,
  and three security groups: `ec2_sg` (SSH+ICMP for all EC2), `app_sg`
  (HTTPS for the app instance), `rds_sg` (PostgreSQL for RDS).
- **`stacks/netbird-network`** — NetBird network `tf-learn-aws-vpc` with two
  routed resources (`ec2-cidr` `10.42.0.0/18`, `rds-cidr` `10.42.64.0/19`),
  separate access policies per client group, and a reusable setup key.
- **`stacks/ec2`** — app EC2 instance (public subnet) and the NetBird routing
  peer (private subnet, outbound internet via NAT Gateway).
- **`stacks/rds`** — RDS PostgreSQL in database subnets, master password managed
  by AWS Secrets Manager.
- **`stacks/s3`** — the S3 bucket that stores all Terraform state.

Each stack has its own remote state under `learning/<stack>/terraform.tfstate`
in the shared bucket. Cross-stack dependencies go through
`data.terraform_remote_state`.

## Prerequisites

- Terraform >= 1.5
- AWS CLI profile `terraform-aws` with credentials for the project
- Selected Region: `ap-southeast-2`
- A NetBird account and a Management PAT for `stacks/netbird-network`
  (set `TF_VAR_netbird_token` or use `netbird_token` in tfvars)

## Deploy order

Stacks are independent Terraform roots — apply them in dependency order:

```bash
# 0. Bootstrap (first time only): the state bucket must exist before any
#    other stack can use the S3 backend.
cd stacks/s3
terraform init -backend=false
terraform apply          # creates tf-state-andrei-ivanov-2026
terraform init           # now configure the real S3 backend and re-apply

# 1. Network foundation
cd ../network && terraform init && terraform apply

# 2. NetBird overlay (needs the VPC CIDR from network outputs)
cd ../netbird-network && terraform init && terraform apply

# 3. Workloads
cd ../ec2 && terraform init && terraform apply    # app + NetBird router
cd ../rds && terraform init && terraform apply    # PostgreSQL
```

After `netbird-network` is applied, add your laptop peer to the
`tf-learn-clients` group in the NetBird dashboard (and to
`tf-learn-rds-clients` if you need database access).

See [examples/README.md](examples/README.md) for per-stack variable
reference, tfvars examples, and common commands.

## Access

- SSH to the app instance goes through NetBird:
  `ssh ubuntu@<app-private-ip>` using `files/ssh_default` as the key pair.
- The routing peer has no public IP; it reaches NetBird relay/signal servers
  outbound through the NAT Gateway.
