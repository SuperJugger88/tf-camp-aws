variable "name" {
  description = "EC2 name (e.g. tf-learn-ec2-app)"
  type        = string
  default     = "tf-learn-ec2-app"
}

variable "ami" {
  description = "AMI ID override (null = latest Ubuntu from data.aws_ami)"
  type        = string
  default     = null
}

variable "ami_name_filter" {
  description = "AMI name filter when ami is not set"
  type        = string
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "ami_owner" {
  description = "AMI owner account (Canonical)"
  type        = string
  default     = "099720109477"
}

variable "instance_type" {
  description = "EC2 instance type (free tier: t2.micro / t3.micro)"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch in"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "key_name" {
  description = "Key pair name for SSH (existing or to create when create_key_pair = true)"
  type        = string
  default     = null
}

variable "create_key_pair" {
  description = "Create aws_key_pair from public_key (own the key in this module)"
  type        = bool
  default     = false
}

variable "public_key" {
  description = "OpenSSH public key material (required if create_key_pair = true)"
  type        = string
  default     = null
}

variable "monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = false
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP"
  type        = bool
  default     = false
}

variable "source_dest_check" {
  description = "Source/dest check (false for NetBird routing peer / NAT)"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script to provide when launching"
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Base64-encoded user data"
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "Recreate instance when user_data changes"
  type        = bool
  default     = false
}

variable "create_iam_instance_profile" {
  description = "Whether to create an IAM instance profile"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "Existing IAM instance profile name"
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "Name of IAM role to create (when create_iam_instance_profile = true)"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of IAM role"
  type        = string
  default     = null
}

variable "iam_role_policies" {
  description = "Map of IAM policy ARNs to attach to the role"
  type        = map(string)
  default     = {}
}

variable "root_block_device" {
  description = "Root block device configuration"
  type        = any
  default     = {}
}

variable "ebs_volumes" {
  description = "Additional EBS volumes map (module v6 API)"
  type        = any
  default     = {}
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = null
}

variable "disable_api_termination" {
  description = "Enable EC2 instance termination protection"
  type        = bool
  default     = null
}

variable "disable_api_stop" {
  description = "Enable EC2 instance stop protection"
  type        = bool
  default     = null
}

variable "enable_volume_tags" {
  description = "Whether to enable volume tags"
  type        = bool
  default     = true
}

variable "volume_tags" {
  description = "Additional tags for volumes"
  type        = map(string)
  default     = {}
}

variable "metadata_options" {
  description = "Instance metadata options (IMDSv2 required by default)"
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "required")
    http_put_response_hop_limit = optional(number, 1)
    instance_metadata_tags      = optional(string)
  })
  default = {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
