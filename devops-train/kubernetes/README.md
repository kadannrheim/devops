# Блок заданий по kubernetes
Ingress в Kubernetes - это ресурс, который позволяет управлять входящим трафиком в кластер
LoadBalancer включает в себя внешний IP-адрес, который клиенты могут использовать для доступа к сервису

# План
1. Запуск k8s кластера 
2. Подключение к кластеру
3. Запуск продакшн нагрузки через kubectl
4. Запуск ресурсов из манифеста
5. Настройка Limits/Requests. Master и Work nodes
6. Pod статусы. Readiness, Liveness проверки
7. Ресурс Service. Тип NodePort
8. Service типа ClusterIP и ExternalName
9. Запуск pod с инструментарием
10. Port forwarding
11. Service типа Load balancer. Ресурс Ingress. Пускаем трафик из интернета
12. Cert-manager. Автоматическое получение SSL сертификата
13. Хранение данных: ConfigMap, Secrets
14. Volumes: персистентность данных(PV, PVC)
15. Volumes: подключаем ConfigMap/PVC
16. Настройка приложения через ENV/Secrets
17. StatefulSets
18. DaemonSet
19. Jobs и запуск по расписанию Cronjobs
20. NodeAffinity, NodeSelector
21. PodDisruptionBudget, PriorityClass
22. HorizontalPodAutoscaler
23. Autoscaler
24. LimitRange/ResourceQuota
25. Service Accounts, Users & RBAC

# Команды управления kubernetes через kubectl

`kubectl create -f simple.yaml` -создать деплоймент
`kubectl apply -f simple.yaml` - обновление сущности
`kubectl delete deployment busybox` -удалить деплоймент
`kubectl get pods --all-namespaces` -вывести все Pods из всех Namespaces
`kubectl scale deployment <deployment-name> --replicas=3` -изменить количество реплик
`kubectl describe <тип-ресурса> <имя-ресурса>` -для получения подробной информации о статусе ресурса
`kubectl describe nodes` -пример использования describe или `kubectl describe deployment sample-site`
`kubectl get nodes -o wide` -какие ноды запущены 
`kubectl label nodes NODENAME label=value` -указадние своих labels на нодах
`kubectl get svc` -вывести созданные сервисы (нужны для сетевого доступа к подам)
`kubectl get svc -n ingress-nginx` -вывести конкретный (просмотр ингресса, поиск external-ip)
`kubectl get deployments -l app=sample-site` -вывести все развёртывания с метками (labels) sample-site
`kubectl exec deploy/toolkit -ti -- /bin/bash` -зайти в под
`kubectl port-forward service/sample-site-clusterip 8081:80` -проброс порта по имени svc, далее доступен по http://127.0.0.1:8081 или поду `kubectl port-forward sample-site-768999cc84-4tdtg  8081:80`
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.6.4/deploy/static/provider/cloud/deploy.yaml` -установка ingress контроллера, он нужен для управления входящим трафиком в кластер
`kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml` -установка cert manager для управления сертификатами
`kubectl get pod -n cert-manager` вывод cert-manager
`kubectl describe configmap sample-config` -вывод инфо конфиг мапа
`kubectl describe secret sample-secret` -вывод инфо секрета
`kubectl describe pvc sample-claim` -вывод инфо volume
`kubectl exec deploy/redis -ti -- /bin/ls /usr/local/etc/redis` -скписок файлов конфигмап
`kubectl logs env-pod` -вывод логов
`kubectl delete statefulset example-statefulset` -удаление statefulset
`kubectl get events --sort-by=.metadata.creationTimestamp` ивенты куба
`kubectl get daemonsets.apps sample-ds` -вывод daemonset
`kubectl patch cronjobs.batch sample-cronjob -p '{"spec" : {"suspend" : true }}'` -временно приостановить создание новых Job по расписанию, не удаляя самого CronJob, например, для отладки. Это можно сделать через указание Suspend И вернуть обратно, изменив true на false
`kubectl describe quota -n=default` -квота на ресурсы в пространстве имён default или в любом указанном другом
`kubectl get events` ивенты для анализа ошибок
Создание нагрузки:
`hey -n 10000 http://{IP_OF_NODE}:32080/` -создаём нагрузку, ip вставляем нашей ноды
`kubectl get pods -w -l app=app-cpu` -смотрим за количеством подов

# Статусы подов

`Pending` - pod принят k8s, но еще не запущен.
`Running` - pod уже привязан к ноде, и все его контейнеры были созданы. И как минимум один из них запущен, либо в процессе запуска/перезапуска
`Succeeded` - все контейнеры пода успешно завершили свою работу. Более pod уже не будет запускаться(обычно это Job)
`Failed` - все контейнеры пода завершили работу, но как минимум один с ошибкой. То есть он либо завершился с ненулевым статусом, либо был убит системой
`Unknown` - состояние пода неизвестно, вероятно из-за отсутствия коммуникации с рабочей нодой
`CrashLoopBackOff` - процесс внутри пода завершается с ошибкой
`ImagePullBackOff` - не найден образ контейнера, либо нет доступа к образу

# Статусы контейнеров

`Waiting` - если контейнер не находится в Running/Terminated, значит он Waiting =) Например, он находится в подготовительном процессе для запуска, скачивает образ контейнера
`Running` - Означает что все успешно запустилось
`Terminated` - Успешно или не очень завершилась работа контейнера. Более подробно вы можете посмотреть с помощью команды kubectl describe pod

# Пробы подов

`livenessProbe` - проверка, что контейнер еще жив, то есть не подвис и выполняет свои функции. Эта проверка выполняется с указанным интервалом после старта контейнера

`readinessProbe` - определение момента готовности контейнера принимать трафик(нагрузку). Эта проверка особенно полезна для приложений, запуск которых может занимать значительное время, в том время как уже сам контейнер давно запущен. Если не установить такую проверку, то для кубера он будет выглядеть как готовый контейнер, и он начнет отправлять на него трафик, хотя по факту приложение еще запускается.

`startupProbe` - проверяет, запущено ли приложение внутри контейнера. Это может быть использовано для настройки проверок livenessProbe медленно запускающихся контейнеров, чтобы избежать их завершения до того, как они полностью заработают. Эта проверка вызывается только в начале работы контейнера, в отличие от двух остальных, которые делают проверку периодически

# Интервал портов по умолчанию разрешенном в k8s для NodePort.
`30000-32767`