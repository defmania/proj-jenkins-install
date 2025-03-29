variable "lb_name" {}
variable "lb_sg" {}
variable "lb_subnet" {}
variable "is_external" { default = "false" }
variable "target_group_arn" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}
variable "lb_listner_default_action" {}
variable "lb_ssl_listener_port" {}
variable "lb_ssl_listener_protocol" {}
variable "certificate_arn" {}
