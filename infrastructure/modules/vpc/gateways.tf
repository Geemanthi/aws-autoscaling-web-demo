# Elastic IP
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = merge({
    Name = "eip-${lower(var.name_suffix)}"
  }, var.tags)
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.nat_eip.id

  depends_on = [aws_internet_gateway.internet_gateway]

  tags = merge({
    Name = "ngw-${lower(var.name_suffix)}"
  }, var.tags)
}

# Internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "igw-${lower(var.name_suffix)}"
  }, var.tags)
}