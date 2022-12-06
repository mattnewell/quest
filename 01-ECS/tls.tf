resource "aws_acm_certificate" "quest" {
  domain_name       = "${var.base_name}.newell.cloud"
  validation_method = "DNS"
}

resource "aws_route53_record" "validate" {
  for_each = {
    for dvo in aws_acm_certificate.quest.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_route53_record" "quest" {
  name    = var.base_name
  type    = "A"
  zone_id = var.zone_id

  alias {
    name                   = aws_lb.quest.dns_name
    zone_id                = aws_lb.quest.zone_id
    evaluate_target_health = true
  }
}

