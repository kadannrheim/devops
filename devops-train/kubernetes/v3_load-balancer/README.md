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