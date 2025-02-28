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

# So we can have different providers for different regions
# Set region for Terraform Infrastructure - ap-southeast-1
provider "aws" {
  region = "ap-southeast-1"
}

# Set region for Terraform Infrastructure - us-east-1
provider "aws" {
  region = "us-east-1"
  alias = "us-east"
}

# Generate a random id of 6 length
resource "random_id" "bucket_suffix" {
  byte_length = "6"
}

# Create a s3 resource in us-east-1 region
resource "aws_s3_bucket" "my_test_bucket" {
  bucket = "my-test-bucket-${random_id.bucket_suffix.hex}"
  provider = aws.us-east
}
