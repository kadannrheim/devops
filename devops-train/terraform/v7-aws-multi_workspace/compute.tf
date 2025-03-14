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
  for_each      = var.instances  # Используем map с ключами instance1, instance2
  ami           = data.aws_ami.ubuntu-2204.id
  instance_type = each.value     # Берём значение из map (например, "t2.micro")
  subnet_id     = aws_subnet.subnet_a.id
  key_name      = aws_key_pair.keypair.key_name
  tags = {
    Name = each.key  # Назначаем имя по ключу (instance1, instance2)
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

#добавляем для варианта с разными конфигурациями
resource "aws_eip" "eip" {
  for_each = var.instances
}

# Связывание Elastic IP с виртуальной машиной
resource "aws_eip_association" "vm_eip_assoc" {
  for_each    = aws_instance.first-vm
  instance_id = each.value.id
  allocation_id = aws_eip.eip[each.key].id  # так же должен быть EIP с таким же for_each
}


# Вывод публичного ip адреса
output "public_ip" {
  value = aws_eip.vm_eip.public_ip
}

output "public_ips" {
  value = {
    for key, instance in aws_instance.first-vm : key => aws_eip.eip[key].public_ip
  }
}

# Подключение диска. Первый диск загрузочный, поэтому для данных лучше использовать secondary disk, чтобы в любой момент было возможно отключить от ВМ и подключить к другой
resource "aws_ebs_volume" "secondary-disk-first-vm" {
  #availability_zone = aws_instance.first-vm.availability_zone
  #availability_zone = aws_instance.first-vm[each.value].availability_zone  #тоже добавляем [each.value] имя по индексу
  for_each = var.instances  # Используем тот же for_each, что и для aws_instance.first-vm
  availability_zone = aws_instance.first-vm[each.key].availability_zone  # Обращаемся по ключу
  size              = 20
  tags = {
    Name = "disk-${each.key}"  # Добавляем имя диска по ключу
  }
  }


#resource "aws_volume_attachment" "ebs_att" {
#  count       = length(aws_instance.first-vm)  #добавляем счетчик для имени по индексу
#  device_name = "/dev/sdh"
#  volume_id   = aws_ebs_volume.secondary-disk-first-vm[each.value].id #тоже добавляем [each.value] имя по индексу
#  instance_id = aws_instance.first-vm[each.value].id  #тоже добавляем [each.value] имя по индексу
#}

# вариант с for_each
resource "aws_volume_attachment" "ebs_att" {
  for_each = var.instances  # Используем тот же for_each, что и для aws_instance.first-vm

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.secondary-disk-first-vm[each.key].id  # Обращаемся по ключу
  instance_id = aws_instance.first-vm[each.key].id  # Обращаемся по ключу
}

# для уникального имени бакета
resource "random_id" "bucket_suffix" {
  byte_length = 8
}


#lifecycle rules для одного из наших бакетов, таким образом, чтобы происходило автоматическое удаление объектов спустя 30 дней, а для логов через 90 дней
#resource "aws_s3_bucket" "bucket-2" {
  #bucket = "devopstrain-bucket-kadann-3" // Имя должно быть таким как вы указывали ранее
 # bucket = "my-unique-bucket-name-2-${var.unique_suffix}"  # Добавьте уникальный суффикс#или можно сделать уникальным используя идентификатор
 # tags = local.common_tags
#}


# Управление версионированием new
  resource "aws_s3_bucket_versioning" "bucket-2-versioning" {
  bucket = aws_s3_bucket.bucket-2.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Управление жизненным циклом new
resource "aws_s3_bucket_lifecycle_configuration" "bucket-2-lifecycle" {
  bucket = aws_s3_bucket.bucket-2.id  # Ссылка на созданный бакет

  rule {
    id     = "log"
    status = "Enabled"

     filter {
      prefix = "logs/"  # Применяем правило только к объектам с префиксом "logs/"
     }
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }
}