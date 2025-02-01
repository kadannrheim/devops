## Инициализация
`docker swarm init --advertise-addr <ip address>`
Далле будет команда на подключение нод в выводе

## Проверька узлов Docker Swarm 
`docker node ls`

## Создание сервиса
`docker service create --name my-web-service --publish published=8080,target=80 --replicas=3 nginx`

## Масштабирование сервиса
`docker service scale my-web-service=5`

## Обновление сервиса
`docker service update --image new-image:tag --replicas=6 my-web-service`

## Проверка статуса сервиса
`docker service ps my-web-service`

## Создаём агрузку на кластере
docker-compose.yml:
```yml
version: "3.8"  # Используйте версию 3.8 для поддержки всех функций Swarm
services:
  web:
    image: nginx:latest  # Используем образ nginx
    ports:
      - "8080:80"  # Пробрасываем порт 8080 на хосте на порт 80 в контейнере
    deploy:
      mode: replicated  # Режим репликации
      replicas: 3  # Количество реплик
      restart_policy:
        condition: on-failure  # Перезапускать только при ошибках
        delay: 5s  # Задержка перед перезапуском
        max_attempts: 3  # Максимальное количество попыток перезапуска
        window: 120s  # Время для оценки успешности перезапуска
      update_config:
        parallelism: 1  # Количество контейнеров, обновляемых одновременно
        delay: 10s  # Задержка между обновлениями
      rollback_config:
        parallelism: 1  # Количество контейнеров, откатываемых одновременно
        delay: 10s  # Задержка между откатами
      resources:
        limits:
          cpus: "0.5"  # Ограничение на использование CPU
          memory: "512M"  # Ограничение на использование памяти
        reservations:
          cpus: "0.1"  # Резервирование CPU
          memory: "256M"  # Резервирование памяти
    networks:
      - webnet  # Подключаем сервис к сети

networks:
  webnet:  # Определяем сеть
    driver: overlay  # Используем драйвер overlay для Swarm
```
После создания файла docker-compose.yml, можно развернуть этот стек в кластере Docker Swarm используя команду:
`docker stack deploy -c docker-compose.yaml my_stack_name`
## Если траблы, смотрим логи:
`docker service logs my_stack_name_web`

## Если нужны изменения, правим docker-compose.yml и переразворачиваем стек
`docker stack deploy -c docker-compose.yml my_stack_name`

## Удаление стека
`docker stack rm my_stack_name`