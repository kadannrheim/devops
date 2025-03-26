data "aws_ami" "ubuntu-2204" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "first-vm" {
  ami           = data.aws_ami.ubuntu-2204.id
  subnet_id = module.vpc.private_subnets[0]
  key_name      = aws_key_pair.keypair.key_name
  
  count = length(var.instances) # Используем count для создания нескольких машин
  tags = {
    Name = "${terraform.workspace}-${var.instances[count.index]}"  # Добавляем workspace в имя
  }

  instance_type = var.instance_types[count.index]  # Устанавливаем тип инстанса по индексу

  user_data = <<-EOF
              #!/bin/bash
              echo "foo=bar" >> /etc/environment
              EOF
}

resource "aws_key_pair" "keypair" {
  key_name   = "key_for_ssh"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Создание Elastic IP
resource "aws_eip" "vm_eip" {
  domain = "vpc"  # Заменил vpc = true на domain = "vpc", best practice
}

# Связывание Elastic IP с виртуальной машиной
resource "aws_eip_association" "vm_eip_assoc" {
  instance_id   = aws_instance.first-vm[0].id # Привязываем к первому инстансу
  allocation_id = aws_eip.vm_eip.id
}

# Вывод публичного IP адреса
output "public_ip" {
  value = aws_eip.vm_eip.public_ip
}

# Подключение диска
resource "aws_ebs_volume" "secondary-disk-first-vm" {
  availability_zone = aws_instance.first-vm[count.index].availability_zone
  size              = 20
  count             = length(aws_instance.first-vm) # Используем count для создания нескольких дисков
  tags = {
    Name = "${terraform.workspace}-disk-${count.index}"  # Добавляем workspace в имя диска
  }
}

resource "aws_volume_attachment" "ebs_att" {
  count       = length(aws_instance.first-vm)  # Используем count для привязки дисков
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.secondary-disk-first-vm[count.index].id
  instance_id = aws_instance.first-vm[count.index].id
}


data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "devopstrain-bucket-kadannr"
    key    = "terraform/aws-vpc/state" # используем данные из VPC-проекта
    region = "eu-west-2"
  }
}