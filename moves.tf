# One-time state moves after wrapping upstream AWS modules
moved {
  from = module.vpc
  to   = module.vpc.module.vpc
}

moved {
  from = module.s3_bucket
  to   = module.s3.module.s3_bucket
}

moved {
  from = aws_instance.app_server
  to   = module.ec2.module.ec2_instance.aws_instance.this
}

moved {
  from = module.ec2.aws_instance.this
  to   = module.ec2.module.ec2_instance.aws_instance.this
}

moved {
  from = aws_s3_bucket_policy.attach_policy
  to   = aws_s3_bucket_policy.tf_learn_state_policy
}
