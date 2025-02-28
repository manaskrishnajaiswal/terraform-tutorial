# aws_caller_identity
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

# aws_vpc
data "aws_vpc" "vpc" {
  tags = {
    Name = "default"
  }
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

# aws_availability_zones
data "aws_availability_zones" "available" {
  state = "available"
}

output "azs_id" {
  value = data.aws_availability_zones.available.names
}


