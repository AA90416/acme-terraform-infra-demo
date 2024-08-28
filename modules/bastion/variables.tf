
variable "vpc_id" {
  description = "ID of the VPC"
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

variable "bastion_ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
}
