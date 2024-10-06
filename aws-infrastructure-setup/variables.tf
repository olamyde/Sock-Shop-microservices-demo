variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to be applied to resources"
  default = {
    "id"             = "2560"
    "owner"          = "Rayca Precision"
    "environment"    = "dev"
    "project"        = "sock-shop-app"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "node_min" {
  type    = string
  default = 1
  }

variable "desired_node" {
  type    = string
  default = 2 
}

variable "node_max" {
  type    = string
  default = 2 
 }

variable "blue_node_color" {
  description = "Color of the blue node"
  type        = string
  default     = "blue"
}

variable "green_node_color" {
  description = "Color of the green node"
  type        = string
  default     = "green"
}

variable "blue" {
  type    = bool
  default = false
}

variable "green" {
  type    = bool
  default = true
}

variable "ec2_ssh_key" {
  description = "SSH key for EC2 instances"
  type        = string
  default     = "terraform"
}

variable "deployment_nodegroup" {
  description = "Node group for deployment"
  type        = string
  default     = "blue_green"
}

variable "capacity_type" {
  description = "Capacity type for instances"
  type        = string
  default     = "ON_DEMAND"
}

variable "ami_type" {
  description = "AMI type for instances"
  type        = string
  default     = "AL2_x86_64"
}

variable "instance_types" {
  description = "Instance types"
  type        = string
  default     = "t3.medium"
}

variable "disk_size" {
  type    = string
  default = 10
}

variable "shared_owned" {
  description = "Ownership type"
  type        = string
  default     = "shared"
}

variable "enable_cluster_autoscaler" {
  type        = string
  description = "Valid values are true or false"
}

variable "control_plane_name" {
  type    = string
  default     = "eks_control_plane"
}

variable "public_subnets" {
  type = map(string)
  default = {
    us-east-1a = "subnet-08e7bd110c23f3323"
    us-east-1b = "subnet-012822c1f4ecadc22"
    us-east-1a = "subnet-0c2f3df47741b1ca2"
    us-east-1b = "subnet-0d94b09509b8c865b"
  }
}

variable "private_subnets" {
  type = map(string)
  default = {
    us-east-1a = "subnet-096d45c28d9fb4c14"
    us-east-1b = "subnet-05f285a35173783b0"
    us-east-1c = "subnet-0fe3255479ad7c3a4"
  }
}