variable "machine_type" {}
variable "source_image" {}
variable "disk_size_gb" { default = 50 }
variable "network" {}
variable "subnet" {}
variable "service_account_email" {}
variable "network_tags" { type = list(string)  }
variable "metadata"    { type = map(string) }
variable "name_prefix" { type = string }
