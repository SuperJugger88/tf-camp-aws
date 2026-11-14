# stacks/ec2 — app instance + NetBird routing peer

Two EC2 instances from `terraform-aws-modules/ec2-instance/aws ~> 6.0`:

| Instance | Subnet | Public IP | SGs | Purpose |
|---|---|---|---|---|
| `tf-learn-ec2-app` | public | yes | `ec2_sg` + `app_sg` | your app/web server |
| `tf-learn-netbird-router` | private | **no** (via NAT) | `ec2_sg` | NetBird routing peer |

Key details:

- Key pair `tf-learn-default` is created from `files/ssh_default.pub`
- Router gets `source_dest_check = false` — **required** for routing
- Router installs NetBird in `user_data` with the `setup_key` read from
  `netbird-network` remote state; `user_data_replace_on_change = true`
  recreates the instance when the key changes
- Everything VPC-related (subnets, SGs) comes from `network` remote state
