# Docker Общая информация
## Установка Docker
Для ubuntu 22.04 добавлял репозиторий
https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

## Просмотр установленной верси docker
`$ docker --version`

## Список запущенных конейтнеров 
`docker ps`
Список контейнеров
`docker ps -a`

## Добавьте текущего пользователя в docker группу
`sudo usermod -aG docker $USER`
## Установка lazydocker
https://lindevs.com/install-lazydocker-on-ubuntu

## Устновка ctop
https://system-administrators.info/?p=8554

## Если нужно заходить по http
`sudo vim /etc/docker/daemon.json`
```
{
  "insecure-registries": ["192.168.1.123"]
}
```
`sudo systemctl restart docker`
Поды после этого придётся скорей всего переподнять, у меня часть из них не встаёт после перезапуска докера. Поэтому перед перезапуском лучше их потушить.
