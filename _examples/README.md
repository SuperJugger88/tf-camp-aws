# Examples

Annotated examples for each stack in `stacks/` — commented Terraform code,
variable references, and `terraform.tfvars` examples. Copy a tfvars example
next to the real stack as `terraform.tfvars` (git-ignored) or pass values
with `-var` / `TF_VAR_*` environment variables.

## Deploy order and commands

```bash
# 0. Bootstrap the state bucket (first run only)
cd stacks/s3
terraform init -backend=false   # backend bucket doesn't exist yet
terraform apply                 # creates the bucket + its config
terraform init                  # switch to the real S3 backend
terraform apply                 # adopt bucket settings into state

# 1. Dedicated IAM user + access key for the state bucket
cd ../iam
terraform init && terraform apply

# 2. Point bucket policy Principal at the iam user ARN
cd ../s3
terraform apply

# 3. Foundation: VPC + security groups + NAT
cd ../network
terraform init
terraform plan
terraform apply

# 4. NetBird overlay network, routes, policies, setup key
cd ../netbird-network
export TF_VAR_netbird_token=nbp_xxx   # Management PAT from NetBird dashboard
terraform init
terraform apply

# 5. Workloads (app EC2 + NetBird routing peer)
cd ../ec2
terraform init && terraform plan && terraform apply

# 6. Database
cd ../rds
terraform init && terraform plan && terraform apply
```

Every stack reads remote state from earlier stacks via
`data.terraform_remote_state`, so apply in this order. Re-running `plan`
afterwards should report `No changes` for all stacks.

## Common commands

| Command | Purpose |
|---|---|
| `terraform init` | Install providers/modules, configure the S3 backend |
| `terraform plan` | Preview changes (use `-out=tfplan` to save) |
| `terraform apply` | Apply (`-auto-approve` skips the prompt) |
| `terraform output` | Show stack outputs (IPs, endpoints, ARNs) |
| `terraform destroy` | Tear down the stack's resources |
| `terraform fmt -recursive` | Format all `.tf` files |
| `terraform validate` | Check configuration syntax |

## Stack variables

### `stacks/iam` — state bucket IAM user

| Variable | Default | Description |
|---|---|---|
| `s3_bucket_name` | `tf-state-andrei-ivanov-2026` | Bucket the user policy is scoped to |
| `project_name`, `tags` | `tf-learn`, `{Environment=dev}` | Tagging |

Creates user `tf-learn-s3-state` + access key + managed policy. Outputs
`s3_state_user_arn` for `stacks/s3` bucket policy.

### `stacks/s3` — state bucket

| Variable | Default | Description |
|---|---|---|
| `s3_bucket_name` | `tf-state-andrei-ivanov-2026` | Globally unique bucket name for state |
| `state_bucket`, `iam_state_key`, `aws_region`, `aws_profile` | see `variables.tf` | Remote state for `stacks/iam` Principal |
| `project_name`, `tags` | `tf-learn`, `{Environment=dev}` | Tagging |

> The backend block in `backends.tf` hardcodes the same bucket/key — the
> stack manages the very bucket its own state lives in. Bucket policy
> Principal comes from `stacks/iam` remote state.

### `stacks/network` — VPC + security groups

| Variable | Default | Options / notes |
|---|---|---|
| `project_name` | `tf-learn` | Prefix for names/tags |
| `vpc_name` | `null` → `<project>-vpc` | VPC name |
| `vpc_cidr` | `10.42.0.0/16` | Must not overlap other networks you route to |
| `azs` | `["ap-southeast-2a","ap-southeast-2b"]` | Availability Zones (selected Region only) |
| `tags` | `{Environment=dev}` | Extra tags merged into `common_tags` |

Fixed behavior: public/private/database subnets, **one** NAT Gateway
(`single_nat_gateway`), and three SGs — `ec2_sg` (22+ICMP), `app_sg` (443),
`rds_sg` (5432), all scoped to the VPC CIDR.

### `stacks/netbird-network` — NetBird overlay

| Variable | Default | Description |
|---|---|---|
| `netbird_token` | — (required, sensitive) | Management PAT; use `TF_VAR_netbird_token` |
| `client_group_name` | `tf-learn-clients` | Existing NetBird group allowed to reach `ec2-cidr` |
| `project_name`, `tags`, `state_bucket`, `network_state_key`, `aws_region`, `aws_profile` | see `variables.tf` | Standard stack plumbing |

Fixed behavior: network `tf-learn-aws-vpc`, resources `ec2-cidr`
(`10.42.0.0/18`) and `rds-cidr` (`10.42.64.0/19`), client groups
`tf-learn-clients` / `tf-learn-rds-clients`, routing group
`resources-tf-learn-aws-vpc`, reusable setup key for the router.

### `stacks/ec2` — instances

| Variable | Default | Options / notes |
|---|---|---|
| `instance_name` | `null` → `<project>-ec2-app` | App instance name |
| `instance_type` | `t3.micro` | Any EC2 type; both instances share it |
| `key_name` | `null` → `<project>-default` | Key pair created from `files/ssh_default.pub` |
| `ami` | `null` | Explicit AMI ID; `null` = latest Ubuntu 24.04 via `data.aws_ami` |
| `ami_name_filter` | `ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*` | SSM/owner lookup filter |
| `ami_owner` | `099720109477` | Canonical's account ID |
| `state_bucket`, `network_state_key`, `netbird_state_key`, `aws_region`, `aws_profile` | see `variables.tf` | Remote-state plumbing |

Fixed behavior: app instance in a **public** subnet with public IP +
`ec2_sg`+`app_sg`; NetBird router in a **private** subnet, no public IP,
`ec2_sg` only, `source_dest_check=false`, installs NetBird via `user_data`
with the setup key from `netbird-network` state.

### `stacks/rds` — PostgreSQL

| Variable | Default | Options / notes |
|---|---|---|
| `db_name` | `appdb` | Initial database name |
| `db_username` | `app_admin` | Master username |
| `engine` | `postgres` | Engine type |
| `engine_version` | `15.19` | Pin a version |
| `family` | `postgres15` | Parameter group family (must match engine) |
| `instance_class` | `db.t3.micro` | e.g. `db.t3.small`, `db.t4g.micro` |
| `allocated_storage` / `max_allocated_storage` | `20` / `100` | gp3, autoscaling up to max |
| `storage_encrypted` | `true` | Always keep enabled |
| `storage_type` | `gp3` | `gp3` recommended |
| `port` | `5432` | Listener port |
| `manage_master_user_password` | `true` | Password in Secrets Manager (`rds_master_user_secret_arn` output) |
| `publicly_accessible` | `false` | Keep `false`; access via NetBird only |
| `multi_az` | `false` | Standby in second AZ (~2x cost) |
| `deletion_protection` | `false` | Set `true` for anything real |
| `skip_final_snapshot` | `true` | `false` + snapshot id for safe teardown |
| `backup_retention_period` | `1` | Free Tier max is 1 day |
| `backup_window` | `03:00-04:00` | UTC |
| `maintenance_window` | `sun:04:00-sun:05:00` | UTC |
| `snapshot_identifier` | `null` | Restore from snapshot |
| `state_bucket`, `network_state_key`, `aws_region`, `aws_profile` | see `variables.tf` | Remote-state plumbing |

## Stack examples

Each directory mirrors a real stack and contains:

- `README.md` — what the stack creates and why
- `main.tf.example` — annotated, commented version of the key Terraform
  code (modules/resources, important arguments, gotchas)
- `terraform.tfvars.example` — copy to `terraform.tfvars` next to the
  real stack to override defaults

| Directory | Stack | Contents |
|---|---|---|
| `iam/` | `stacks/iam` | IAM user + access key + policy for state bucket |
| `s3/` | `stacks/s3` | Terraform state bucket |
| `network/` | `stacks/network` | VPC, subnets, NAT Gateway, 3 security groups |
| `netbird-network/` | `stacks/netbird-network` | NetBird network, split resources/policies, setup key |
| `ec2/` | `stacks/ec2` | app instance + NetBird routing peer |
| `rds/` | `stacks/rds` | RDS PostgreSQL |

## Stack variables

Quick reference; see each `*/terraform.tfvars.example` for the full
annotated list.
