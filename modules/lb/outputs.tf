output "lb_dns_name" {
  value       = aws_lb.jenkins_lb.dns_name
  description = "DNS name of the Load Balancer"
}

output "lb_zone_id" {
  value       = aws_lb.jenkins_lb.zone_id
  description = "value of the zone id"
}
