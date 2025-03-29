resource "aws_acm_certificate" "certificate" {
  domain_name       = var.hostname
  validation_method = "DNS"

  tags = {
    environment = "jenkins-prod"
  }

  lifecycle {
    create_before_destroy = false
  }
}


resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}
