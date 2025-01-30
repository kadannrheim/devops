# Практикум по DevOps
+ Docker
    + Установка и эксплуатация
    + Работа с контейренами
    + Работа с dockerfile
    + Эксплуатация и создание образов
    + Виды и работа с volumes и network
    + Переменные окружения
    + Multistage builds (приложение на go)
    + Docker Registry и создание локального хранилища, Harbor
    + Встроенные утилиты и Lazydocker
    + Безопастность в Docker и сканер trivy
    + Docker compose
    + Docker Swarm


# Docker
## Если нужно заходить по http
`sudo vim /etc/docker/daemon.json`
```
{
  "insecure-registries": ["192.168.1.123"]
}
```
`sudo systemctl restart docker`
Поды после этого придётся скорей всего переподнять, у меня часть из них не встаёт после перезапуска докера. Поэтому перед перезапуском лучше их потушить.