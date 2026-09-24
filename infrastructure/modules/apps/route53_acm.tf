data "aws_route53_zone" "main" {
  count = var.enable_https ? 1 : 0
  name         = var.domain_name
  private_zone = false
}

resource "aws_acm_certificate" "web" {
  count = var.enable_https ? 1 : 0
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.domain_name}"
  }
}

# One DNS validation record per domain validation option ACM asks for.
resource "aws_route53_record" "cert_validation" {
  for_each = var.enable_https ? {
    for dvo in aws_acm_certificate.web[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  zone_id         = data.aws_route53_zone.main[0].zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "web" {
  count = var.enable_https ? 1 : 0
  certificate_arn         = aws_acm_certificate.web[0].arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}

# Public DNS record pointing your domain at the ALB.
resource "aws_route53_record" "app" {
  count = var.enable_https ? 1 : 0
  zone_id = data.aws_route53_zone.main[0].zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.nginx.dns_name
    zone_id                = aws_lb.nginx.zone_id
    evaluate_target_health = true
  }
}
