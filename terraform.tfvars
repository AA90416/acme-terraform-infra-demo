# AWS Region
aws_region = "us-east-1"

# VPC Configuration
vpc_cidr             = "10.1.0.0/17"
pub_sub1_cidr_block  = "10.1.0.0/24"
pub_sub2_cidr_block  = "10.1.1.0/24"
prv_sub1_cidr_block  = "10.1.2.0/24"
prv_sub2_cidr_block  = "10.1.3.0/24"
availability_zone_1  = "us-east-1a"
availability_zone_2  = "us-east-1b"

# Vault Configuration
vault_ami            = "ami-066784287e358dad1"
vault_instance_type  = "t2.micro"
vault_storage_size   = 20

# EC2 Instance Configuration
instance_type  = "t2.micro"
key_name       = "vault-poc"

# S3 Bucket Configuration
bucket_name = "aws-terraform-application-storage-12234558373"

bastion_ami = "ami-026ebd4cfe2c043b2"
bastion_instance_type = "t2.micro"

# Web Application Configuration
web_ami = "ami-026ebd4cfe2c043b2"
web_instance_type = "t2.micro"
service_linked_role_arn = "arn:aws:iam::640168451862:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
