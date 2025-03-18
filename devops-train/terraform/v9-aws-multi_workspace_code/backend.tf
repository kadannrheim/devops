terraform {
  backend "s3" {
    bucket                      = "devopstrain-bucket-kadannr" //имя созданного backet из задания 7
    key                         = "terraform/aws-vpc/state"
    region                      = "eu-west-2"
  }
}