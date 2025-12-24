variable "project_id" {
    type= string
    description = "gcp project id"
}

variable "vpc_name" {
    type = string
    description ="name of vpc"
}

variable "region" {
  type        = string
  description = "Region for subnets"
}

variable "subnets" {
  type = list(object({
    name       = string
    cidr_range = string
  }))
  description = "List of subnets with name and CIDR"
}