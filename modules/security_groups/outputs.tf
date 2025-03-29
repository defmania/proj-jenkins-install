output "sg_ec2_ssh_http_https" {
  value = aws_security_group.ec2_sg_http_https_ssh.id
}

output "sg_ec2_jenkins" {
  value = aws_security_group.ec2_jenkins.id
}

output "lb_sg_http_https" {
  value = aws_security_group.lb_sg_http_https.id
}
