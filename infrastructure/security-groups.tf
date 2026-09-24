resource "aws_security_group" "alb" {
  name        = "securitygroup-${local.name_suffix}-alb"
  description = "Allow inbound HTTP from the internet"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "securitygroup-${local.name_suffix}-alb"
  }, local.tags)
}

resource "aws_security_group" "instance" {
  name        = "securitygroup-${local.name_suffix}-instance"
  description = "Allow HTTP only from the ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "securitygroup-${local.name_suffix}-instance"
  }, local.tags)
}
