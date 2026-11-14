# stacks/rds — PostgreSQL

RDS PostgreSQL via `terraform-aws-modules/rds/aws ~> 6.0`:

- Lives in the **database subnets** + `rds_sg` (5432 from VPC CIDR only)
- `publicly_accessible = false` — reachable only inside the VPC /
  through NetBird
- Master password managed by **AWS Secrets Manager**
  (`manage_master_user_password = true`) — never in tfvars or state
- gp3 storage 20 GB with autoscaling up to 100 GB, encrypted at rest
- Single-AZ by default (`multi_az = false`); backups 1 day (Free Tier max)

Apply AFTER `stacks/network` — it reads `database_subnet_group` and
`rds_sg_id` from remote state.
