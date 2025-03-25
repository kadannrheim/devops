variable "filename" {
  description = "Name of file for the output"
  type        = string
}

variable "state_bucket" {
  description = "Bucket for terraform state"
  type        = string
}

variable "second_bucket" {
  description = "Bucket to test import"
  type        = string
}

variable "subnet_params" {
  description = "VPC subnet params"
  type = object({
    zone    = string
    cidr = string
  })
}

variable "instances" {
  type    = list(string)
  default = ["instance-1", "instance-2"]  # Список имен инстансов
}

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.small"]  # Список типов инстансов
}