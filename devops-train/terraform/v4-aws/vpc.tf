resource "aws_vpc" "main" {
  cidr_block = "10.5.0.0/16"
  enable_dns_support = true 
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.5.0.0/24"
  availability_zone = "eu-west-2a"
  
  tags = {
    Name = "subnet_1"
  }
}