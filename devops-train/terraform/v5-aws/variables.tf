variable "filename" {
  description = "Name of file for the output"
  type        = string #указываем тип
  default = "output.txt"
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
#значения перенёс в terraform.tfvars
  #default = {
    #zone = "ru-central1-a"
    #cidr = "10.5.0.0/24"
  }
#}
