data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.enable_associate_public_ip_address
  vpc_security_group_ids      = var.sg_for_jenkins
  key_name                    = var.key_name

  user_data = var.user_data_install_jenkins

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

resource "aws_key_pair" "jenkins_ec2_instance_public_key" {
  key_name   = var.key_name
  public_key = var.public_key
}
