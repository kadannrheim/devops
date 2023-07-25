# Полезные ссылки для выполнения задания

https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/

https://kubernetes.io/docs/concepts/services-networking/_print/ 

https://kubernetes.io/docs/concepts/services-networking/service/#proxy-mode-userspace 


# Практическое задание 2

1. Собрать docker image на базе Dockerfile и файла app.py  https://docs.docker.com/language/python/build-images/ 
`docker build --tag python-docker`
Смотри образы
`docker images`
Можно так же тэг повесить
`docker tag python-docker:latest kadannr/python-docker:v1.0.0`
```
vagrant@us22minikube1vg:~/C:inshare/task2$ docker images
REPOSITORY              TAG       IMAGE ID       CREATED          SIZE
kadannr/python-docker   v1.0.0    328090815736   43 minutes ago   51.8MB
python-docker           latest    328090815736   43 minutes ago   51.8MB 
```
2. После сборки разместить образ на своем акаунте Dockerhub
`docker login` =вписываем свои данный от сайта https://hub.docker.com/
`docker push kadannr/python-docker:v1.0.0`
3. Создать secret объект с credentials от dockerhub и именем pull-secret

4. Создать YAML файл deployment.yaml 

- в качестве образа использовать путь до докерхаба с вашим образом
- использовать 3 реплики приложения
- использовать cpu request = 100m / cpu limits = 500m для контейнера 
- использовать memory request = 100M / Memory limits = 500M для контейнера
- использовать secret с именем  pull-secret для скачивания имаджа с сайта dockerhub
- название микросервиса my-app, label=my-app

5. Задеплоить deployment в кластер в неймспейс homework
```
kubectl apply -f deployment.yaml
```

6. Создать service для доступа к этому POD, декларативно или императивно

7. Создать Ingress для доступа к этому POD, декларативно или императивно, с адресом my-color-app.info и именем ingress-my-app

8. Посмотреть внешний адрес кластера
```
minikube ip
```

9. Добавить в /etc/hosts(WSL or Linux) или в C:\Windows\System32\drivers\etc\hosts (Windows) новую запись
```
IP-адрес-кластера my-color-app.info
```

Пример:
```
192.168.49.2 my-color-app.info
```
10. При помощи браузера зайти по адресу приложения 

# Практическое задание с повышеной сложностью

Разобраться почему каждый раз при обновлении страницы с адресом приложения меняется цвет.
