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

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.small"]  # Первый инстанс будет t2.micro, второй - t2.small
}