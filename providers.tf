terraform {
  required_version = "~> 1.2" #">= 0.14, < 0.15"
}

provider "aws" {
  region = var.aws_region
}
