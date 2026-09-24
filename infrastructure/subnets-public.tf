# public subnets
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets)

  vpc_id                                      = aws_vpc.vpc.id
  cidr_block                                  = values(var.public_subnets)[count.index]
  availability_zone                           = keys(var.public_subnets)[count.index]
  enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch                     = true

  tags = merge({
    Name         = "sbnt-${lower(local.name_suffix)}-pblc-${count.index + 1}",
  }, local.tags)
}

# public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name         = "rt-${lower(local.name_suffix)}-pblc"
  }, local.tags)
}

# public route table association
resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

# public default route
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}