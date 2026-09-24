output "vpc_id" {
	description = "The ID of the VPC"
	value       = aws_vpc.vpc.id
}

output "private_subnet_ids" {
	description = "The IDs of the private subnets"
	value       = aws_subnet.private_subnet[*].id
}

output "public_subnet_ids" {
	description = "The IDs of the public subnets"
	value       = aws_subnet.public_subnet[*].id
}

output "internet_gateway_id" {
	description = "The ID of the internet gateway"
	value       = aws_internet_gateway.internet_gateway.id
}

output "nat_gateway_id" {
	description = "The ID of the NAT gateway"
	value       = aws_nat_gateway.nat_gateway.id
}