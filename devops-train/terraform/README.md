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

## Управляющие комнады AWS

`aws configure list`
`aws sts get-caller-identity` 
`aws s3 ls`
`aws --version` -версия
`aws configure` -настрока подключения AWS


# Визуализцаия инфраструктуры terraform
## Графы
Ненерируем граф
`terraform graph > graph.dot`
Ставим доп. пакет
`sudo apt install graphviz`
Преобразуем граф
`dot -Tpng graph.dot -o graph.png`