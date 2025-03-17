resource "aws_vpc" "main" {
  cidr_block = "10.5.0.0/16"
  enable_dns_support = true 
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "subnet-a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.5.0.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "subnet_1"
  }
}

output "subnet-id" {
  description = "Return subnet ID"
  value       = aws_subnet.subnet-a.id
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Таблица маршрутизации
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Привязка таблицы маршрутизации к подсети
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.subnet-a.id
  route_table_id = aws_route_table.public_route_table.id
}