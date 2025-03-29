resource "aws_security_group" "ec2_sg_http_https_ssh" {
  name        = var.ec2_sg_name
  description = "Enable HTTP, HTTPS and SSH access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security group to allow SSH, HTTP and HTTPS to EC2"
  }
}

resource "aws_security_group_rule" "ec2_sg_http_https_ssh_http_ingress" {
  security_group_id        = aws_security_group.ec2_sg_http_https_ssh.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.lb_sg_http_https.id
}

resource "aws_security_group_rule" "ec2_sg_http_https_ssh_https_ingress" {
  security_group_id        = aws_security_group.ec2_sg_http_https_ssh.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.lb_sg_http_https.id
}

resource "aws_security_group_rule" "ec2_sg_http_https_ssh_ssh_ingress" {
  security_group_id = aws_security_group.ec2_sg_http_https_ssh.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["82.77.117.138/32"]
}

resource "aws_security_group_rule" "ec2_sg_vault_ingress" {
  security_group_id = aws_security_group.ec2_sg_http_https_ssh.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8200
  to_port           = 8201
  cidr_blocks       = ["82.77.117.138/32"]
}

resource "aws_security_group_rule" "all_outbound" {
  security_group_id = aws_security_group.ec2_sg_http_https_ssh.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "ec2_jenkins" {
  name        = var.jenkins_sg_name
  description = "Enable Jenkins access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security group to allow connection to Jenkins"
  }
}

resource "aws_security_group_rule" "jenkins_http_ingress" {
  security_group_id        = aws_security_group.ec2_jenkins.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 8080
  to_port                  = 8080
  source_security_group_id = aws_security_group.lb_sg_http_https.id
}

resource "aws_security_group_rule" "jenkins_outbound" {
  security_group_id = aws_security_group.ec2_jenkins.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "lb_sg_http_https" {
  name        = var.lb_sg_name
  description = "Enable HTTP and HTTPS access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Security group to allow HTTP and HTTPS to LB"
  }
}

resource "aws_security_group_rule" "lb_sg_http_ingress" {
  security_group_id = aws_security_group.lb_sg_http_https.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["82.77.117.138/32"]
}

resource "aws_security_group_rule" "lb_sg_https_ingress" {
  security_group_id = aws_security_group.lb_sg_http_https.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["82.77.117.138/32"]
}

resource "aws_security_group_rule" "lb_outbound" {
  security_group_id = aws_security_group.lb_sg_http_https.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
