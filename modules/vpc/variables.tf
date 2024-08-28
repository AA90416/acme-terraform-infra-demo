# modules/vpc/variables.tf

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "pub_sub1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.1.0.0/24"
}

variable "pub_sub2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.1.1.0/24"
}

variable "prv_sub1_cidr_block" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.1.2.0/24"
}

variable "prv_sub2_cidr_block" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.1.3.0/24"
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

variable "sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "alb_sg"
}

variable "sg_description" {
  description = "Security Group Description"
  type        = string
  default     = "SG for application load balancer"
}

variable "sg_tagname" {
  description = "Security Group Tag Name"
  type        = string
  default     = "SG for ALB"
}

variable "sg_ws_name" {
  description = "Security Group Name for Web Server"
  type        = string
  default     = "webserver_sg"
}

variable "sg_ws_description" {
  description = "Security Group Description for Web Server"
  type        = string
  default     = "SG for web server"
}

variable "sg_ws_tagname" {
  description = "Security Group Tag Name for Web Server"
  type        = string
  default     = "SG for Web"
}
