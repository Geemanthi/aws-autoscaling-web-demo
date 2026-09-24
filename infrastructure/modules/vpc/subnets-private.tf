# private subnets
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = values(var.private_subnets)[count.index]
  availability_zone = keys(var.private_subnets)[count.index]

  tags = merge({
    Name = "sbnt-${lower(var.name_suffix)}-prvt-${count.index + 1}",
  }, var.tags)
}

# private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "rt-${lower(var.name_suffix)}-prvt"
  }, var.tags)
}

# private route table association
resource "aws_route_table_association" "private_route_table_association" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_route_table.private_route_table.id
}

# private default route
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}