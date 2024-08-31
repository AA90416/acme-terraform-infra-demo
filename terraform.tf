terraform {

  cloud {
    organization = "hashicorp-sa"

    workspaces {
      name = "dev-terraform"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
      region = var.region
    }
  }

  required_version = ">= 1.1.0"
}