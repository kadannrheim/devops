# Описание
Harbor — реестр контейнеров с поддержкой сканирования образов
Trivy — инструмент для сканирования уязвимостей в контейнерах

# 1. Установка Harbor и интеграция с Trivy
## Скачиваем
`cd /tmp`
`curl -s https://api.github.com/repos/goharbor/harbor/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep '\.tgz$' | wget -i -`
## Извлекаем
`tar -xzvf harbor-offline-installer-v2.6.1.tgz`
## Перемещаем (для того что бы не было проблем с доступам к файловой системе)
`sudo mv harbor /opt/`
## Идём в папку и копируем шаблон и редактируем его
`cd /opt/harbor`
`cp harbor.yml.tmpl harbor.yml`
В нашем случае берём заготовку `harbor.yaml`

# Установка
`sudo ./install.sh --with-trivy`

## Загрузка образа
`docker login <your-server-ip>`
Введите admin и пароль
Пример на nginx, загружем
`docker pull nginx:alpine`
Тэгируем наш образ
`docker tag nginx:alpine <your-server-ip>/library/nginx_alpine`
Отправка образов в Harbor (мы уже авторизировались выше)
`docker push <your-server-ip>/library/nginx_alpine`

## Работа с UI
https://computingforgeeks.com/install-harbor-image-registry-on-ubuntu/
https://itshaman.ru/articles/3117/kak-ustanovit-harbor-docker-image-registry-na-ubuntu-2204

# troubleshooting
##
##
##


