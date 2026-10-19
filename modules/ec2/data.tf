data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  owners = [var.ami_owner]
}
