variable "filename" {
  description = "Name of file for the output"
  type        = string #указываем тип
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
#добавляем переменную для создания нескольких машин
variable "instances" {
  type    = list
  default = ["instance-1", "instance-2"]
}