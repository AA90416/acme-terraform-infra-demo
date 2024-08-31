
variable "ami"{
 type = string
  default = "ami-010aff33ed5991201"
}
variable "key_name"{
  type = string
  default = "MY-TEMP-PVT-INSTANCE"
}

variable "instance_type" {
  description = "The EC2 instance type to be used in the launch configuration."
  type        = string
  default     = "t2.micro"  # You can set a default value or leave it unset if you want to require explicit input.
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "default region"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.1.0.0/16"
  description = "default vpc_cidr_block"
}

variable "pub_sub1_cidr_block"{
   type        = string
   default     = "10.1.0.0/24"
}

variable "pub_sub2_cidr_block"{
   type        = string
   default     = "10.1.1.0/24"
}
variable "prv_sub1_cidr_block"{
   type        = string
   default     = "10.1.2.0/24"
}
variable "prv_sub2_cidr_block"{
   type        = string
   default     = "10.1.3.0/24"
}


variable "sg_name"{
 type = string
 default = "alb_sg"
}

variable "sg_description"{
 type = string
 default = "SG for application load balancer"
}

variable "sg_tagname"{
 type = string
 default = "SG for ALB"
}

variable "sg_ws_name"{
 type = string
 default = "webserver_sg"
}

variable "sg_ws_description"{
 type = string
 default = "SG for web server"
}

variable "sg_ws_tagname"{
 type = string
 default = "SG for web"
}

variable "vault_ami" {
  description = "AMI ID for the vault host"
  type        = string
}

variable "vault_instance_type" {
  description = "Instance type for the vault host"
  type        = string
}

variable "vault_storage_size" {
  description = "Storage size in GB for the vault host"
  type        = number
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability Zone for Subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "Availability Zone for Subnet 2"
  type        = string
  default     = "us-east-1b"
}

variable "bastion_ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
}


variable "web_ami" {
  description = "AMI ID for the Web Application host"
  type        = string
}

variable "web_instance_type" {
  description = "Instance type for Web Application host"
  type        = string
}

variable "service_linked_role_arn" {
  description = "The ARN of the service-linked role for Auto Scaling"
  type        = string
}

variable "deploy_bastion" {
  type    = bool
  default = true
}

variable "deploy_vault" {
  type    = bool
  default = true
}
