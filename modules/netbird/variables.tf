variable "name_prefix" {
  description = "Prefix for resource names (e.g. tf-learn)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the routing peer"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR advertised to NetBird clients and allowed for SSH to peer"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet for the routing peer (needs egress to NetBird Cloud)"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair for the routing peer"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "client_peer_names" {
  description = "NetBird peer names to put in the clients group"
  type        = list(string)
  default     = []
}

variable "setup_key_usage_limit" {
  description = "Max uses for routing peer setup key (0 = unlimited)"
  type        = number
  default     = 5
}

variable "route_metric" {
  type    = number
  default = 100
}

variable "tags" {
  type    = map(string)
  default = {}
}
