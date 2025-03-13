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

#вариант с map, где конфигурации отличаются
variable "instances" {
  type = map
  default = {
    instance1 = "t2.micro"
    instance2 = "t3.micro"
  }
}

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.small"]  # Первый инстанс будет t2.micro, второй - t2.small
}