#datasources (источники данных) используются для получения информации о существующих ресурсах в облачных провайдерах или других внешних системах
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
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id 
  key_name      = aws_key_pair.keypair.key_name   

  tags = {
    Name = "first-vm"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "foo=bar" >> /etc/environment
              EOF

}

resource "aws_key_pair" "keypair" {
  key_name   = "key_for_ssh"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Для добавления внешнего IP-адреса (Elastic IP) к виртуальной машине и подключения к ней через SSH
# Создание Elastic IP
resource "aws_eip" "vm_eip" {
  domain = "vpc"  # Заменил vpc = true на domain = "vpc" , бест практик новый
}

# Связывание Elastic IP с виртуальной машиной
resource "aws_eip_association" "vm_eip_assoc" {
  instance_id   = aws_instance.first-vm.id
  allocation_id = aws_eip.vm_eip.id
}

# Вывод публичного ip адреса
output "public_ip" {
  value = aws_eip.vm_eip.public_ip
}

# Подключение диска. Первый диск загрузочный, поэтому для данных лучше использовать secondary disk, чтобы в любой момент было возможно отключить от ВМ и подключить к другой
resource "aws_ebs_volume" "secondary-disk-first-vm" {
  availability_zone = aws_instance.first-vm.availability_zone
  size              = 20
  tags = {
    Name = "disk-name"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.secondary-disk-first-vm.id
  instance_id = aws_instance.first-vm.id
}