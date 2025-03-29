output "hosted_zone_id" {
  value = data.aws_route53_zone.dev_zone.zone_id
}
