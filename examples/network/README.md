# stacks/network — VPC + security groups (shared state)

Creates the network foundation everything else depends on:

- VPC `10.42.0.0/16` across 2 AZs with public / private / database subnets
- **One** NAT Gateway (`single_nat_gateway = true`) so private subnets get
  outbound internet (~$32/mo + $0.045/GB)
- Three security groups, each with a single responsibility:

| SG | Ingress | Attached to |
|---|---|---|
| `ec2_sg` | TCP 22 (SSH) + all ICMP, from VPC CIDR | every EC2 instance |
| `app_sg` | TCP 443 (HTTPS), from VPC CIDR | app/web instance only |
| `rds_sg` | TCP 5432 (Postgres), from VPC CIDR | RDS instance |

See `main.tf.example` for the annotated module calls and
`terraform.tfvars.example` for the knobs you can change.
