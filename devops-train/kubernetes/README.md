# Блок заданий по kubernetes



# Команды управления kubernetes через kubectl

`kubectl create -f sample.yaml` -создать деплоймент
`kubectl delete deployment busybox` -удалить деплоймент
`kubectl get pods --all-namespaces` -вывести все Pods из всех Namespaces
`kubectl scale deployment <deployment-name> --replicas=3` -изменить количество реплик
`kubectl describe <тип-ресурса> <имя-ресурса>` -для получения подробной информации о статусе ресурса