resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = merge({
    Name = "vpc-${lower(var.name_suffix)}"
  }, var.tags)
}

# default route table
resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = merge({
    Name = "rt-${lower(var.name_suffix)}-default"
  }, var.tags)
}

# default route table association
resource "aws_main_route_table_association" "default_route_table_association" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_default_route_table.default_route_table.id
}

# default route table route
resource "aws_route" "default_route" {
  route_table_id         = aws_default_route_table.default_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

