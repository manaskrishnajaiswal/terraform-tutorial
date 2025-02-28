# 1: terraform init
# 2: terraform validate
# 3: terraform apply
# 4: terraform destroy

# Set provider for Terraform Infrastructure
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Set region for Terraform Infrastructure
provider "aws" {
  region = "ap-southeast-1"
}

# Resource block for s3 bucket -> managed by us and by our terraform project
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Resource block for s3 bucket -> not managed by us and we just use in our terraform project
data "aws_s3_bucket" "name" {
  bucket = "not-managed-by-us"
}

# Varaible block -> used to set variables and can be used in other code blocks
variable "bucket_name" {
    type = string
    description = "It is used to set bucket name"
    default = "my-default-bucket-name"
}

# Output block -> used to set variable to output of any code block
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

# Local variable block -> used to set local varaibles which is used inside code block only
locals {
  local_example = "this is a local variable"
}

# Module block -> used to import other terraform module in curret file
module "my_module" {
  source = "./module-example"
}