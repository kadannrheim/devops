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
  ami           = data.aws_ami.ubuntu-2204.id  # Указываем AMI
  #instance_type = "t2.micro"                   # Указываем тип инстанса один на всех
  subnet_id     = aws_subnet.subnet_a.id       # Указываем подсеть
  key_name      = aws_key_pair.keypair.key_name  # Указываем ключевую пару
  
  count = length(var.instances) #добавляем счётчик для создания нескольких машин по индексу
  tags = {
    Name = var.instances[count.index]  
  #переводи на создание имени по индексу
  #tags = {
    #Name = "first-vm"
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

# Для добавления внешнего IP-адреса (Elastic IP) к виртуальной машине и подключения к ней через SSH
# Создание Elastic IP
resource "aws_eip" "vm_eip" {
  domain = "vpc"  # Заменил vpc = true на domain = "vpc" , бест практик новый
}

# Связывание Elastic IP с виртуальной машиной
resource "aws_eip_association" "vm_eip_assoc" {
  instance_id   = aws_instance.first-vm[0].id # Привязываем к первому инстансу
  allocation_id = aws_eip.vm_eip.id
}

# Вывод публичного ip адреса
output "public_ip" {
  value = aws_eip.vm_eip.public_ip
}

# Подключение диска. Первый диск загрузочный, поэтому для данных лучше использовать secondary disk, чтобы в любой момент было возможно отключить от ВМ и подключить к другой
resource "aws_ebs_volume" "secondary-disk-first-vm" {
  #availability_zone = aws_instance.first-vm.availability_zone
  availability_zone = aws_instance.first-vm[count.index].availability_zone  #тоже добавляем [count.index] имя по индексу
  size              = 20
  count             = length(aws_instance.first-vm) #добавляем счетчик для имени по индексу
  #tags = {
  #  Name = "disk-name"
  }


resource "aws_volume_attachment" "ebs_att" {
  count       = length(aws_instance.first-vm)  #добавляем счетчик для имени по индексу
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.secondary-disk-first-vm[count.index].id #тоже добавляем [count.index] имя по индексу
  instance_id = aws_instance.first-vm[count.index].id  #тоже добавляем [count.index] имя по индексу
}
