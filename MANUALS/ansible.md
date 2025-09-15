# 1. Установка и настройка
## Начало
```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y python3.12
```
Выбор версии по умолачнию python, добавляем возможные варианты:
```
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
```
И устанавливаем нужную по умолчанию:
`sudo update-alternatives --config python3`


## Переходим в ansible

```bash
sudo apt install -y software-properties-common

sudo apt-add-repository --yes --update ppa:ansible/ansible

sudo apt install -y ansible

ansible --version
```

## Добавление машины в inventory Ansible
vim ansible/inventory/hosts, пример:
```bash
[web]
web1 ansible_host=192.168.1.100 ansible_user=kadannr
[local]
localhost ansible_connection=local
```
## Проверка подключения к управляемой машине
`ansible -i ~/ansible/inventory/hosts all --list-hosts` -Проверьте список хостов

`ansible -i ~/ansible/inventory/hosts all -m ping` -Проверьте подключение ping

`ansible -i ~/ansible/inventory/hosts server -m ping` -Проверьте факты Ansible

## Примеры использования
`ansible -i ~/ansible/inventory/hosts server -a "uptime"` -выполнить команду

`ansible -i ~/ansible/inventory/hosts all -a "df -h"` -проверить свободное место

`ansible -i ~/ansible/inventory/hosts server -b -a "apt update"` -установить пакет

# 2. Эксплуатация
`make check` -просмотр какие измениния будут внесны


# Кратко:
- Питон должен быть 3 версии, одинаковый на хостах
- должен стоять ssh (везде)
- должен стоять ansible на сервере (откуда собираешься управлять)
- настраиваешь хосты inventory/hosts (на сервере и последующие файлы там же)
- настраиваешь tasks/setup.yml содержит задачи для первоначальной настройки и подготовки системы(Установка зависимостей, Настройка репозиториев, Создание системных пользователей, Базовая конфигурация ОС)
- Makefile позволяет автоматизировать различные задачи администрирования через модуль make в Ansible (Запуск плейбуков в режиме проверки (dry-run), Сбор фактов с хостов, Работа с инвентарём (inventory), Отладка переменных хостов, Валидация синтаксиса плейбуков, Управление vault-файлами, Установка зависимостей ролей)

----
# Ошибки (установка производиkfcm на ОС Linux или встроенную Ubuntu 20 в Windows 10)
## Убрать ошибку "Are you sure you want to continue connecting (yes/no/[fingerprint])? null_resource.squid: Still creating... [10s elapsed]". https://ask-dev.ru/info/81968/how-to-ignore-ansible-ssh-authenticity-checking
Если Вы работали с сервером по ssh, то наверняка знаете о такой штуке как known hosts. Это та самая штука, которая запоминает отпечатки (fingerprint) всех серверов, которые Вы посещаете и не поволяет сливать пароли и секретные ключи, если отпечаток не совпал. Она просто Вас не пустит дальше, обьясняя это тем, что Вас пытаются обмануть. (аутентичная проверка подлинности SSH), можно убрать эту проверку создав в папке с ansible файл ansible.cfg с параметрами:
```
[defaults]
host_key_checking = False
```
или https://adment.org.ua/admin/79-ssh-known-hosts-removal
Можно стереть запись про этот сервер на клиенте. Проще всего это сделать командой (Но это удалит данные про все сервера. Расположение файла может быть и другим, если в конфиге ssh указано это директивой UserKnownHostsFile):

`$ rm ~/.ssh/known_hosts`

Если же Вам нужно удалить конкретный хост, то почему бы не открыть файл в текстовом редакторе и не удалить нужную строчку. Ну что, логично и так можно сделать, если у Вас на клиенте не включена опция HashKnownHosts. Если же она включена, то найти нужную строчку будет проблематично.

Но удалить запись всё-таки можно, командой:
`$ ssh-keygen -R host.com`
ssh-keygen -R 62.84.116.4

Мне помогло создание аналогичного файла ansible.cfg в системной папке /etc/ansible/ansible.cfg