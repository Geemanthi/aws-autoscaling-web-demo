# ensure the default security group of every vpc restricts all traffic
resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name         = "securitygroup-${lower(var.name_suffix)}-default"
  }, var.tags)
}

resource "aws_security_group" "aws_internet_egress" {
  name        = "securitygroup-${lower(var.name_suffix)}-egress"
  description = "Security group to support egress traffic"
  vpc_id      = aws_vpc.vpc.id

  lifecycle {
    create_before_destroy = true
  }

  egress {
    description      = "Internet Egress rule"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({
    Name         = "securitygroup-${lower(var.name_suffix)}-egress"
  }, var.tags)
}