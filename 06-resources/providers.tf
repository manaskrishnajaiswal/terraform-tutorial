# Set provider for Terraform Infrastructure
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Set region for Terraform Infrastructure - ap-southeast-1
provider "aws" {
  region = "ap-southeast-1"
}

locals {
  common_Tags = {
    Project   = "06-resources"
    ManagedBy = "Terraform"
  }
}
