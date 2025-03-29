output "jenkins_lb_target_group_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.jenkins_lb_target_group.arn
}
