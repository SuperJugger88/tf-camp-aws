locals {
  key_name = var.create_key_pair ? aws_key_pair.this[0].key_name : var.key_name
}