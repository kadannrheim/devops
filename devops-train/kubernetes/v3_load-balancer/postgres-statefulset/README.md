1. Создаем StatefulSet для PostgreSQL, файл postgres-statefulset.yaml.
2. Создаем Secret для пароля PostgreSQL
`kubectl create secret generic postgres-secret --from-literal=password=mysecretpassword`
3. Создаем Service для доступа к PostgreSQL, создать файл postgres-service.yaml.
4. Применяем конфигурацию
```
kubectl apply -f postgres-statefulset.yaml
kubectl apply -f postgres-service.yaml
```
5. Проверяем работу PostgreSQL
```kubectl get pods -l app=postgres
kubectl logs postgres-0  # Проверяем логи
```
6. Проверяем PersistentVolume
kubectl get pvc  # Должен быть PVC для postgres-storage-postgres-0
kubectl get pv   # Проверяем, что PV создан
7. Подключение к PostgreSQL
`kubectl exec -it postgres-0 -- psql -U admin -d mydb`

Результат:
Устойчивое хранилище (/var/lib/postgresql/data)
Уникальное имя пода (postgres-0)
Headless Service (postgres:5432)

# Потенциальные ошибки
FailedScheduling → не хватает ресурсов
FailedMount → проблемы с PVC
FailedCreate → ошибки контейнера