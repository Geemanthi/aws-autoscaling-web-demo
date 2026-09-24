region_code = "nv"
organization = "global"
project = "webapp"
vpc_cidr_block = "10.0.8.0/22"

private_subnets = {
  "us-east-1a" = "10.0.8.0/24"
  "us-east-1b" = "10.0.9.0/24"
}

public_subnets = {
  "us-east-1a" = "10.0.10.0/24"
  "us-east-1b" = "10.0.11.0/24"
}