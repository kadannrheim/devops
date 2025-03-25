# Описание настройки terraform на AWS
# План:
1. Настройка локальной машины
2. Подключение AWS
3. Создание конфига и перенос файлов terraform на AWS
4. Создание инстанца и подключение к нему по ssh
5. Создание диска, форматирование и монтирование в ОС

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
`terraform init -upgrade` -обновление уже инициализированного
`terraform plan` -проверка плана выполнения
`terraform apply` -применение конфигурации
`terraform init -migrate-state` -init с ключем -migrate-state, чтобы смигрировать наш 
стейт в новое место
`terraform import aws_s3_bucket.bucket-2 devopstrain-learning-bucket-2` -импорт в terraform на примере aws
`terraform output public_ip` -вывод пуличного ip адреса
`terraform apply -destroy -target=aws_instance.first-vm` -удалить созданную ВМ
`terraform destroy -target=aws_instance.first-vm` -или так
`terraform plan -var-file=terraform.tfvars` - запуск с указанием файла с значениями переменных (разные файлы для разных сборок можно использовать)
`terraform state list` -проверка чем управляет terraform
`terraform destroy -target="aws_instance.first-vm[\"instance1\"]" -target="aws_instance.first-vm[\"instance2\"]"` - если нужно удалить конкретные инстанцы () здесь в примере они называются "instance-1" и "instance-2".
`terraform workspace list` -список workspace
`terraform workspace new dev` -создание нового workspace и переключение на него
`terraform workspace select default` -переключение на нужный workspace

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

----
## Настройка подключения по ssh и дебаг

1. Если не б.ьтся пинги проверяем на ui (пример ниже)
2. Проверяем доступность порта:
```bash
└─ $ nc -zv 13.42.217.67 22 
Connection to 13.42.217.67 22 port [tcp/ssh] succeeded!
```
есть нет, то проверяем на ui (пример ниже).


4. Пробуем подключиться, используя секретный ключ (публичный на удалённой машине в инстанце):
`ssh -i ~/.ssh/id_rsa ubuntu@13.42.217.67`

### Примрер настройки для пингов и ssh в UI AWS:
```m
sgr-02430226693e2ea20
IPv4
All ICMP - IPv4
ICMP
All
0.0.0.0/0
–
sgr-0c82b4d83172ab6f5
IPv4
SSH
TCP
22
0.0.0.0/0
```
Важно именно в таком порядке добавить, иначе будет ругаться не явной ошибкой. Или поудалять авто-созданный.

# Загрузка из общедоступного репозитория невозможна, так как текущий пользователь отличается от владельца скачиваемого файла
```
/usr/bin/git exited with 128: fatal: detected dubious ownership in repository at
│ '/media/sf_git/devops/devops-train/terraform/v10-aws-multi_workspace-modul/.terraform/modules/vpc'
│ To add an exception for this directory, call:
│       git config --global --add safe.directory
```
Решение добавить директорию в безопасные для Git, пример директории:
```
git config --global --add safe.directory /media/sf_git/devops/devops-train/terraform/v10-aws-multi_workspace-modul/.terraform/modules/vpc
```