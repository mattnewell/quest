resource "aws_acm_certificate" "quest" {
  domain_name       = "${var.base_name}.${var.domain_name}"
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
