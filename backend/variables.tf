variable "backend_bucket" {
  description = "The name of the S3 bucket for storing Terraform state"
  type        = string
}

variable "backend_key" {
  description = "The path to the Terraform state file within the S3 bucket"
  type        = string
}

variable "backend_dynamodb_table" {
  description = "The DynamoDB table for Terraform state locking"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the S3 bucket and DynamoDB table are located"
  type        = string
}
