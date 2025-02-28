resource "aws_instance" "instance" {
  ami                         = "ami-0145ae7e021995a92"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.security_group_mywebserver.id ]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
  tags = merge(local.common_Tags, {
    Name = "mywebserver"
  })
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "security_group_mywebserver" {
  description = "Allow 80 and 443 ports"
  name        = "mywebserver-sg"
  vpc_id      = aws_vpc.myvpc.id
}

resource "aws_vpc_security_group_ingress_rule" "vpc_security_group_ingress_rule_http" {
  security_group_id = aws_security_group.security_group_mywebserver.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "vpc_security_group_ingress_rule_https" {
  security_group_id = aws_security_group.security_group_mywebserver.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
}