# Creates the public Application Load Balancer for the NGINX application.
resource "aws_lb" "nginx" {
  name               = "alb-${var.name_suffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  tags = merge({
    Name = "alb-${var.name_suffix}"
  }, var.tags)
}

# Registers the NGINX instances as HTTP targets for the load balancer.
resource "aws_lb_target_group" "nginx" {
  name     = "tg-${var.name_suffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 15
    timeout             = 5
    matcher             = "200"
  }

  tags = merge({
    Name = "tg-${var.name_suffix}"
  }, var.tags)
}

# Handles HTTP traffic and forwards it or redirects it based on HTTPS configuration.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = var.enable_https ? "redirect" : "forward"
    target_group_arn = var.enable_https ? null : aws_lb_target_group.nginx.arn

    dynamic "redirect" {
      for_each = var.enable_https ? [1] : []

      content {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }
}

# Creates the HTTPS listener when HTTPS is enabled.
resource "aws_lb_listener" "https" {
  count = var.enable_https ? 1 : 0

  load_balancer_arn = aws_lb.nginx.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.web[0].certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}
