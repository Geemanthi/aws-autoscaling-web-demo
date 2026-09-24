resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = merge({
    Name         = "vpc-${lower(local.name_suffix)}"
  }, local.tags)
}