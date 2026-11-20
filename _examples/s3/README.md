# stacks/s3 — Terraform state bucket

Creates `tf-state-andrei-ivanov-2026` via
`terraform-aws-modules/s3-bucket/aws ~> 5.0` — the bucket that stores the
remote state of ALL other stacks.

Configuration highlights:

- `force_destroy = true` — bucket can be emptied on destroy (careful!)
- `BucketOwnerEnforced` — ACLs disabled, IAM-only access
- All public access blocked, AES256 encryption, versioning enabled
- Bucket policy grants the dedicated `stacks/iam` user (`s3_state_user_arn`
  from remote state) Get/Put/Delete objects + ListBucket

**Bootstrap problem:** this stack's own backend points at the bucket it
creates. First-time setup:

```bash
cd stacks/s3
terraform init -backend=false   # no backend yet — bucket doesn't exist
# temporarily drop remote_state.iam / use a bootstrap policy if needed
terraform apply                 # create the bucket (local state)
terraform init                  # now configure the real S3 backend
terraform apply                 # adopt bucket settings into remote state

cd ../iam
terraform init && terraform apply

cd ../s3
terraform apply                 # wire bucket policy to iam user ARN
```

Depends on `stacks/iam` for the bucket policy Principal (after bootstrap).
