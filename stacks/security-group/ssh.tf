resource "aws_key_pair" "default" {
  key_name   = "${var.project_name}-default"
  public_key = trimspace(file("${path.module}/../../files/ssh_default.pub"))

  tags = local.common_tags
}
