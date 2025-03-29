variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zone"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR Block"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR Block"
}

variable "instance_name" {
  type        = string
  description = "Name of the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type of Jenkins node"
}

variable "public_key" {
  type        = string
  description = "Public key for connecting to instance"
}

variable "enable_associate_public_ip_address" {
  type        = bool
  description = "Enable public IP address association"
}

variable "lb_target_group_name" {
  type        = string
  description = "Name of the target group"
  default     = "jenkins-lb-target-group"
}

variable "lb_target_group_port" {
  type    = number
  default = 8080
}

variable "lb_target_group_protocol" {
  type    = string
  default = "HTTP"
}

variable "hostname" {
  type = string
  default = "jenkins.mydomain.com"
}

variable "key_name" {
  type = string
  default = "jenkins-key"
}

variable "hosted_zone" {
  type = string
  default = "mydomain.com"
}
