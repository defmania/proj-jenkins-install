resource "aws_lb" "jenkins_lb" {
  name               = var.lb_name
  internal           = var.is_external
  load_balancer_type = "application"
  security_groups    = [var.lb_sg]
  subnets            = var.lb_subnet

  enable_deletion_protection = false

  tags = {
    Name = "jenkins_lb"
  }
}

resource "aws_lb_listener" "jenkins_listener" {
  load_balancer_arn = aws_lb.jenkins_lb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.target_group_arn
  }
}

resource "aws_lb_listener" "jenkins_ssl_listener" {
  load_balancer_arn = aws_lb.jenkins_lb.arn
  port              = var.lb_ssl_listener_port
  protocol          = var.lb_ssl_listener_protocol
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.lb_listner_default_action
    target_group_arn = var.target_group_arn
  }

}
