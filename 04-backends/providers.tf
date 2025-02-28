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
  backend "s3" {
    bucket = "terraform-backend-bucket-1423"
    key = "state.tfstate"
    region = "ap-southeast-1"
  }
}

# Set region for Terraform Infrastructure
provider "aws" {
  region = "ap-southeast-1"
}

