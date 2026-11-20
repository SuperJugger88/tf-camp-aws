# stacks/iam — dedicated IAM user for Terraform state

Creates a least-privilege IAM user for the S3 state bucket via
`terraform-aws-modules/iam/aws ~> 6.0`:

| Resource | Module | Purpose |
|---|---|---|
| `tf-learn-s3-state` policy | `iam-policy` | ListBucket + Get/Put/DeleteObject on the state bucket only |
| `tf-learn-s3-state` user | `iam-user` | Programmatic user, no console login, with access key |

Outputs (`s3_state_user_arn`, access key id/secret) are consumed by
`stacks/s3` bucket policy via `data.terraform_remote_state.iam`.

**Apply after the state bucket exists** (backend already points at it),
**before** (re)applying `stacks/s3` so the bucket policy Principal is
the new user ARN — not a hardcoded admin.

```bash
cd stacks/iam
terraform init
terraform apply
terraform output -raw s3_state_access_key_secret   # sensitive, lives in state
```

This is for **programmatic** access (CLI/Terraform profile). Human console
access in the new AWS experience stays in AWS Settings (team members),
not classic IAM users.
