locals {
  project_owner = "terraform-tutorial"
  cost_center   = "terraform-121"
  managed_by    = "terraform"
}

locals {
  common_tags = {
    project_owner = local.project_owner
    cost_center   = local.cost_center
    managed_by    = local.managed_by
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# output "ubuntu_ami_data" {
#   value = data.aws_ami.ubuntu
# }

resource "aws_instance" "instance" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = var.aws_ec2_instance_type
  root_block_device {
    delete_on_termination = true
    volume_size           = var.aws_ec2_volume_config.size
    volume_type           = var.aws_ec2_volume_config.type
  }
  tags = merge(local.common_tags, var.additional_tags)
}

output "aws_ec2_instance_id" {
  value = aws_instance.instance.id
}