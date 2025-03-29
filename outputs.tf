output "jenkins_public_ip" {
  value = module.jenkins_ec2_instance.jenkins_ec2_instance_public_ip
}
