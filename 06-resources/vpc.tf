# Create a vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "10.140.0.0/16"
  tags = merge(local.common_Tags, {
    Name = "myvpc"
  })
}

# Create a subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.140.0.0/24"
  tags = merge(local.common_Tags, {
    Name = "myvpc-public_subnet"
  })
}

# Create a internet gateway
resource "aws_internet_gateway" "myvpc-igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = merge(local.common_Tags, {
    Name = "myvpc-igw"
  })
}

# Create a public route table
resource "aws_route_table" "myvpc_public-rtb" {
  vpc_id = aws_vpc.myvpc.id
  tags = merge(local.common_Tags, {
    Name = "myvpc_public-rtb"
  })
}

# Create route for public route table
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.myvpc_public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myvpc-igw.id
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.myvpc_public-rtb.id
}