module "vpc" {
  source     = "terraform-aws-modules/vpc/aws"
  version    = "5.7.0"
  
  name       = "my-vpc"
  cidr       = "10.5.0.0/16"

  azs             = ["eu-west-2a"]
  private_subnets = ["10.5.0.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Project = "my-vpc"
  }
}