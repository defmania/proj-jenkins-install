output "jenkins_ec2_instance_id" {
  value = aws_instance.jenkins.id
}

output "jenkins_ec2_instance_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "jenkins_ec2_instance_connection_string" {
  value = format("%s%s", "ssh -i /Users/rahulwagh/.ssh/aws_ec2_terraform ubuntu@", aws_instance.jenkins.public_ip)
}
