variable "name" {}
variable "machine_type" {}
variable "zone" {}
variable "image" {}
variable "network" {}
variable "subnet" {}
variable "tags" {
   type = list(string)
}
