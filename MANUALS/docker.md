
docker-compose up -d --build
# Глоссарий
`Dockerfile` — это конфигурационный файл, который содержит инструкции для сборки Docker-образа и запуска контейнера. В нём описываются этапы создания и настройки окружения для приложения.
`Docker Compose` — это инструмент для определения и запуска многоконтейнерных приложений в Docker. Он использует файлы YAML для описания сервисов и их зависимостей, что упрощает развёртывание и управление комплексными приложениями.
`Язык Go (Golang)` — это компилируемый многопоточный язык программирования, разработанный компанией Google. Он создан для разработки веб-сервисов и клиент-серверных приложений, обладает строгой статической типизацией, простым и понятным синтаксисом, поддержкой Unicode и возможностью кроссплатформенной разработки.








# До 2025
---- 
# Установка
* `sudo apt update` обновитm существующий список пакетов.
  
* `sudo apt install apt-transport-https ca-certificates curl software-properties-common` установите несколько необходимых пакетов, которые позволяют apt использовать пакеты через HTTPS.
  
* `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -` Добавьте ключ GPG для официального репозитория Docker в вашу систему.
  
* `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"` Добавьте репозиторий Docker в источники APT.
  
* `sudo apt update`
  
* `apt-cache policy docker-ce` Убедитесь, что установка будет выполняться из репозитория Docker, а не из репозитория Ubuntu по умолчанию.
    * Вы должны получить следующий вывод, хотя номер версии Docker может отличаться:
        ``` 
        docker-ce:
        Installed: (none)
        Candidate: 5:19.03.9~3-0~ubuntu-focal
        Version table:
            5:19.03.9~3-0~ubuntu-focal 500
                500 https://download.docker.com/linux/ubuntu focal/stable amd64 Packages 
        ```    

* `sudo apt install docker-ce` Установите Docker

* `sudo systemctl status docker` Docker должен быть установлен, демон-процесс запущен, а для процесса активирован запуск при загрузке. Проверьте, что он запущен: Active: active (running)

# Настройка 
* `sudo usermod -aG docker ${USER}` доабавление прав пользователю, что бы не вводить каждый раз sudo. После этой команды необходимо переподключиться или ввести : `su - ${USER}`

* `id -nG` Проверьте, что ваш пользователь добавлен в группу docker, пример:
    * `Output
sammy sudo docker` 

* `sudo usermod -aG docker username` Если вам нужно добавить пользователя в группу docker, для которой вы не выполнили вход, объявите имя пользователя явно.
  
# Использование
* `docker [option] [command] [arguments]`
  
* `docker` Чтобы просмотреть все доступные субкоманды.
  
* `docker docker-subcommand --help` Чтобы просмотреть параметры, доступные для конкретной команды.
  
* `docker info` Чтобы просмотреть общесистемную информацию о Docker.
  
# Работа
* `docker search ubuntu` Поиск образа, в данном случае ubuntu. Ожифиальные образы идут без указания владельца.

* `docker pull ubuntu` загрузка образа по имени.

* `docker pull ubuntu:18.04` загрузка с указанием тэга нужной версии, её можно посмотреть на сайте dockerhub.

* `docker images ls` показать скачанные образы.

* `docker create -t -i --name testt ubuntu:18.04` создать докер образ testt

* `docker ps` вывести списока запущенных контейнеров.

* `docker ps -a` вывод списка запущенных контейнеров.

* `docker rename testt test` переименование образа.

* `docker start test` запуск контейнера.

* `docker attach test` подключиться к контейнеру, при отключении завершиться.

* `docker exec -it test bash` подключение к контейнеру, он не закроется после отсоединения.

* `docker stop test` корректное завершение работы контейнера.

* `docker kill test` вырубит не спрашивая.

* `docker rm test` удаление контейнера.

* `docker image rm ubuntu:18.04` удаление образа.

# Сборка
`docker build -t kadannr/nginx1:1 .` где kadannr/nginx1 мною заданное имя, 1 тэг.


# ctop
docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest

# Docker Compose на примере Jenkins

`docker pull jenkins/jenkins` -установка jenkins

    Файл docker-compose.yaml:
    ```
    version: '3.8'
    services:
    jenkins:
        image: jenkins/jenkins:latest-jdk11
        privileged: true
        user: root
        ports:
        - 8080:8080
        - 50000:50000
        container_name: jenkins
        volumes:
        - $HOME/jenkins_compose/jenkins_configuration:/var/jenkins_home
        - /var/run/docker.sock:/var/run/docker.sock
    ```
`docker-compose up -d` -запуск сборки
`docker-compose ps` -просмотр защеных контейнеров
`docker-compose up` -Эта команда используется, когда вы хотите запустить или вызвать все службы в вашем файле docker-compose.yml. Файл Docker-compose.yml определяет ваши сервисы, их свойства, переменные и зависимости.
`docker-compose ps` -просмотра запущенных контейнеров
`docker-compose jenkins` -можете указать docker-compose запустить только один сервис, например nexus
`docker volume ls` -просмотр томов
`docker volume rm` -удаление томов

# Сборка своего образа на примере ElasticSearch centos7
`docker image ls` -просмотр скаченных образов
`docker pull centos:7` -скачать centos 7
переходим в каталог где создаём DOckerfile:
```
FROM centos:7

EXPOSE 9200 9300

USER 0

RUN export ES_HOME="/var/lib/elasticsearch" && \
    yum -y install wget && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
    sha512sum -c elasticsearch-7.17.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-7.17.0-linux-x86_64.tar.gz && \
    rm -f elasticsearch-7.17.0-linux-x86_64.tar.gz* && \
    mv elasticsearch-7.17.0 ${ES_HOME} && \
    useradd -m -u 1000 elasticsearch && \
    chown elasticsearch:elasticsearch -R ${ES_HOME} && \
    yum -y remove wget && \
    yum clean all

COPY --chown=elasticsearch:elasticsearch config/* /var/lib/elasticsearch/config/
    
USER 1000

ENV ES_HOME="/var/lib/elasticsearch" \
    ES_PATH_CONF="/var/lib/elasticsearch/config"
WORKDIR ${ES_HOME}

CMD ["sh", "-c", "${ES_HOME}/bin/elasticsearch"]
```