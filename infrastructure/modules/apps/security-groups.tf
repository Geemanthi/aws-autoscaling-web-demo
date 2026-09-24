resource "aws_security_group" "alb" {
  name        = "securitygroup-${var.name_suffix}-alb"
  description = "Allow inbound HTTP from the internet"
  vpc_id      = var.vpc_id

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
    Name = "securitygroup-${var.name_suffix}-alb"
  }, var.tags)
}

resource "aws_security_group" "instance" {
  name        = "securitygroup-${var.name_suffix}-instance"
  description = "Allow HTTP only from the ALB"
  vpc_id      = var.vpc_id

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
    Name = "securitygroup-${var.name_suffix}-instance"
  }, var.tags)
}
