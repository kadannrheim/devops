# Описание
Trivy — инструмент для сканирования уязвимостей в контейнерах

# Ручное сканирование Trivy, установка как отдельный инструмент
## Скачать образ Trivy
`docker pull aquasec/trivy:latest`

## Сканирование локального образа
`docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image <имя_образа>`

## Обновление базы данных Trivy: Trivy использует базу данных уязвимостей, которую нужно периодически обновлять. Это можно сделать с помощью команды:
`docker run --rm aquasec/trivy:latest --cache-dir /tmp/trivy/.cache trivy --download-db-only`

# troubleshooting
##