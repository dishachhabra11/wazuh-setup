variable "env" {
  type = string
}

variable "lb_port" {
  type    = string
  default = "1514"  # or whatever TCP port you want
}

variable "mig_instance_group" {
  description = "Self_link of the instance group or managed instance group"
  type        = string
}

variable "lb_port2" {
  type = string
}
