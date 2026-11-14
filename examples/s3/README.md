# stacks/s3 — Terraform state bucket

Creates `tf-state-andrei-ivanov-2026` via
`terraform-aws-modules/s3-bucket/aws ~> 5.0` — the bucket that stores the
remote state of ALL other stacks.

Configuration highlights:

- `force_destroy = true` — bucket can be emptied on destroy (careful!)
- `BucketOwnerEnforced` — ACLs disabled, IAM-only access
- All public access blocked, AES256 encryption, versioning enabled
- Bucket policy grants the Terraform admin principal Get/Put/Delete
  objects + ListBucket

**Bootstrap problem:** this stack's own backend points at the bucket it
creates. First-time setup:

```bash
cd stacks/s3
terraform init -backend=false   # no backend yet — bucket doesn't exist
terraform apply                 # create the bucket (local state)
terraform init                  # now configure the real S3 backend
terraform apply                 # adopt bucket settings into remote state
```

This stack has no dependencies — it can be applied first, before
`network`.
