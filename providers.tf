terraform {
  required_version = "~> 1.2" 
}

provider "aws" {
  region = var.aws_region
}
