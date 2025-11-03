cert-manager v1.13.1
helm version: Version:"v3.17.3"
helmfile --version: helmfile version 0.157.0

# Частые команды
Сборка образа Docker (сменить перед этим на новые версии):

`docker build -t kadannr/golang-redis-app:0.0.3 -f Dockerfile .`

Пуш в докер хаб
`docker push kadannr/golang-redis-app:0.0.3`

----
Упаковка приложения

`helm package golang-redis-app-chart`

Отправка в dockerhub ( команда публикует Helm‑чарт в реестр контейнеров (Docker Hub) по стандарту OCI, делая его доступным для установки через helm install с указанием OCI‑пути.)

`helm push golang-redis-app-chart-0.2.2.tgz  oci://registry-1.docker.io/kadannr`

Установка helm из dockerhub (golang-redis-app в этой команде - это имя релиза (release name) в Helm.).
golang-redis-app-chart (Helm chart) Указывается в команде установки
golang-redis-app (Docker image) # Указывается в values.yaml ВНУТРИ chart'a (image:  repository: kadannr/golang-redis-app  # ⬅️ ИМЯ ОБРАЗА)
```bash
helm install -n default golang-redis-app \
  oci://registry-1.docker.io/kadannr/golang-redis-app-chart --version 0.2.2
```

Обновление helm из dockerhub
```bash
helm upgrade --install -n default golang-redis-app \
  oci://registry-1.docker.io/kadannr/golang-redis-app-chart --version 0.2.2
```

helm установка релиза (Образ берется из указанного в values.yaml репозитория. values.yaml НЕ пушится в Docker Hub при сборке образа). Версия релиза меняется в Chart.yaml (version: 0.2.4  # ⬅️ УВЕЛИЧЬ ВЕРСИЮ (было 0.2.3))

`helm upgrade golang-redis-app ./golang-redis-app-chart -n default` 

Поиск и фильтрация по имени пода

`kubectl get pods -l app=golang-redis-app -n default`

Удаление подов

`kubectl delete pods -l app=golang-redis-app -n default`

Удаление релиза helm

`helm uninstall golang-redis-app -n default`

Проверка релизов

`helm list -n default`

Удаление релиза

`helm uninstall -n default golang-redis-app`

Удаление деплоймента

`kubectl delete deployment golang-redis-app-deployment`

loki
`helm upgrade --install -f loki-values.yaml loki --version 5.15.0 grafana/loki -n logging`


# Стенография
Отредактировал версии в файлах
Создал образ
Сделал пуш образа в докерхаб