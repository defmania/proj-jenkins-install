module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  availability_zone   = var.availability_zone
  cidr_private_subnet = var.cidr_private_subnet
  cidr_public_subnet  = var.cidr_public_subnet
}

module "security_groups" {
  source          = "./modules/security_groups"
  ec2_sg_name     = "sg_ec2_http_https_ssh"
  jenkins_sg_name = "sg_ec2_jenkins"
  vpc_id          = module.networking.vpc_id
  lb_sg_name      = "sg_lb_http_https"
}

module "jenkins_ec2_instance" {
  source                             = "./modules/jenkins"
  instance_name                      = var.instance_name
  instance_type                      = var.instance_type
  public_key                         = var.public_key
  key_name                           = var.key_name
  subnet_id                          = tolist(module.networking.public_subnets)[0]
  enable_associate_public_ip_address = var.enable_associate_public_ip_address
  user_data_install_jenkins          = templatefile("./jenkins-install/runner.sh", {})
  sg_for_jenkins                     = [module.security_groups.sg_ec2_ssh_http_https, module.security_groups.sg_ec2_jenkins]
}

module "jenkins_lb_target_group" {
  source                   = "./modules/lb-target-group"
  lb_target_group_name     = var.lb_target_group_name
  lb_target_group_port     = var.lb_target_group_port
  lb_target_group_protocol = var.lb_target_group_protocol
  vpc_id                   = module.networking.vpc_id
  ec2_instance_id          = module.jenkins_ec2_instance.jenkins_ec2_instance_id
}

module "jenkins_lb" {
  source                    = "./modules/lb"
  lb_name                   = "jenkins-lb"
  lb_listener_port          = 80
  lb_listener_protocol      = "HTTP"
  lb_listner_default_action = "forward"
  lb_sg                     = module.security_groups.lb_sg_http_https
  lb_subnet                 = tolist(module.networking.public_subnets)
  target_group_arn          = module.jenkins_lb_target_group.jenkins_lb_target_group_arn
  certificate_arn           = module.aws_certificate_manager.certificate_arn
  lb_ssl_listener_port      = 443
  lb_ssl_listener_protocol  = "HTTPS"
}

module "hosted_zone" {
  source          = "./modules/hosted-zone"
  hostname        = var.hostname
  aws_lb_dns_name = module.jenkins_lb.lb_dns_name
  aws_lb_zone_id  = module.jenkins_lb.lb_zone_id
  hosted_zone     = var.hosted_zone
}

module "aws_certificate_manager" {
  source         = "./modules/certificate-manager"
  hosted_zone_id = module.hosted_zone.hosted_zone_id
  hostname       = var.hostname
}
