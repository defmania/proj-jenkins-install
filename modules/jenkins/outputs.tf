output "jenkins_ec2_instance_id" {
  value = aws_instance.jenkins.id
}

output "jenkins_ec2_instance_public_ip" {
  value = aws_instance.jenkins.public_ip
}
