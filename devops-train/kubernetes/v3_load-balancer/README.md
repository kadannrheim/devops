# Выполнены задания 11
# Задание 11. Service типа Load balancer. Ресурс Ingress. Пускаем трафик из интернета

11. Service типа Load balancer. Ресурс Ingress. Пускаем трафик из интернета
# Доп. задание
Попробуйте настроить свой собственный домен(если у вас он есть) и хост в ingress
Готово.
1. Прописать имя своего сайта в конфиге
`  - host: <вашподдомен>.radost.ru`
2. Узнаём IP-адрес  Nginx Ingress Controller. Ищем EXTERNAL-IP у сервиса типа LoadBalance
`kubectl get svc -n ingress-nginx`
3. Прописываем в настройке доменных зон у DNS-провайдера зону `A` с нашим адресом. 
4. Ждём пару минут и проверяем
`curl -v kadannr.online`

12. Cert-manager. Автоматическое получение SSL сертификата
13. Хранение данных: ConfigMap, Secrets
14. Volumes: персистентность данных(PV, PVC)
15. Volumes: подключаем ConfigMap/PVC
    1. Доп. задание - выполнено. Посмотреть конфиг redis.conf:
    `kubectl exec deploy/redis -ti -- cat /usr/local/etc/redis/redis.conf`
    2. Доп. задание - #task . Изучите Projected volumes. Они позволяют подключать несколько источников данных в одну директорию. Создайте такой deployment. 
16. Настройка приложения через ENV/Secrets
17. StatefulSets
    1. Полезно знать - #task . Попробуйте развернуть базу Cockroachdb(Совместим на уровне протокола и SQL с postgresql) используя их оператор для этого.
    2. Доп.задание - выполнено. Задание для самостоятельной практики
    Запустите сервер PostgresSQL в режиме statefulset (одну реплику).
    Сложил в отдельной папке postgres-statefulset.