# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"]
# }

# output "ubuntu_ami_data" {
#   value = data.aws_ami.ubuntu
# }

# resource "aws_instance" "instance" {
#   ami                         = data.aws_ami.ubuntu.id
#   associate_public_ip_address = true
#   instance_type               = "t2.micro"
#   root_block_device {
#     delete_on_termination = true
#     volume_size           = 10
#     volume_type           = "gp3"
#   }
# }