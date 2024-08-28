variable "ami" {
  description = "The AMI ID for the Bastion host"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Bastion host"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet in which the Bastion host will be launched"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS Key Pair to be used for the bastion host"
  type        = string
}

variable "user_data" {
  description = "User data to provision the instance"
  type        = string
  default     = null
}
