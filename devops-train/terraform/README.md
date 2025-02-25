# Описание настройки terraform на AWS

## Установка вручную (использовался данный способ)
1. Скачиваем нужный файл (AMD64) и `unzip имя_архива` его
2. Переместите извлеченный исполняемый файл terraform в каталог, включенный в переменную среды PATH, например, /usr/local/bin:
`sudo mv terraform /usr/local/bin/`
3. Проверьте установку, выполнив следующую команду:
`terraform version`


# Запасной вариант. Установка согласно официальной инструкции
https://developer.hashicorp.com/terraform/install#linux# Описание настройки terraform на AWS

## Установка вручную (использовался данный способ)
1. Скачиваем нужный файл (AMD64) и `unzip имя_архива` его
2. Переместите извлеченный исполняемый файл terraform в каталог, включенный в переменную среды PATH, например, /usr/local/bin:
`sudo mv terraform /usr/local/bin/`
3. Проверьте установку, выполнив следующую команду:
`terraform version`


# Запасной вариант. Установка согласно официальной инструкции
https://developer.hashicorp.com/terraform/install#linux

## Управляющие команды terraform:

`terraform init` -инициализация terraform
`terraform plan` -проверка плана выполнения
`terraform apply` -применение конфигурации
`terraform init -migrate-state` -init с ключем -migrate-state, чтобы смигрировать наш 
стейт в новое место
`terraform import aws_s3_bucket.bucket-2 devopstrain-learning-bucket-2` -импорт в terraform на примере aws
`terraform output public_ip` -вывод пуличного ip адреса

## Управляющие комнады AWS

`aws configure list` -какие ключи стоят и какой регион выставлен
`aws sts get-caller-identity` 
`aws s3 ls`
`aws --version` -версия
`aws configure` -настрока подключения AWS
`aws ec2 describe-regions --output table` -список доступных регионов
`aws configure set region eu-west-2` -выставить регион (и на локальном работает)


# Визуализцаия инфраструктуры terraform
## Графы
Ненерируем граф
`terraform graph > graph.dot`
Ставим доп. пакет
`sudo apt install graphviz`
Преобразуем граф
`dot -Tpng graph.dot -o graph.png`


# trobleshooting
## Проверка региона
Если к примеру нет инстанца или других создаваемых сущностей или не подключается по ssh на созданный бакет, можно проверить регион.
1. какой регион выставлен на UI
2. Выполнить в aws `aws configure list`
3. Выполнить на пк `aws configure list`
4. Сравнить регионы
5. Сверить регионы в файлах providers.tf и backend.tf 
6. Выставить везде один регион, в том числе и на пк командой aws configure set region имя_региона