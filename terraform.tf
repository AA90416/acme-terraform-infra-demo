terraform {

  cloud {
    organization = "AcmeCloudInfra-Demo"

    workspaces {
      name = "dev-terraform"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
      region = "us-east-1"
    }
  }

  required_version = ">= 1.1.0"
}