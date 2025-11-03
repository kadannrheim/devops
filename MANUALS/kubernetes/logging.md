# kube-prometheus-stack включает в себя следующие компоненты:
Prometheus: основной инструмент мониторинга, который собирает и хранит метрики.
Alertmanager: обрабатывает и отправляет оповещения на основе триггеров, установленных в Prometheus.
Grafana: визуализирует данные, собираемые Prometheus.
kube-state-metrics: служба, которая генерирует метрики из состояния объектов Kubernetes, таких как поды, узлы и т.д.
node_exporter: экспортер метрик для k8s-нод, он собирает информацию о ресурсах, таких как CPU, память, диск и т.д.
Prometheus Operator: создает, настраивает и управляет экземплярами Prometheus и Alertmanager.

# Установка:
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install -n monitoring kube-prometheus-stack prometheus-community/kube-prometheus-stack
```

# Прокидываем порт
`kubectl port-forward svc/kube-prometheus-stack-grafana 1080:80 -n monitoring`

# Переходим на localhost:1080 

# Доступы
Логин: admin
Пароль в секретах:
```bash
kubectl get secrets -n monitoring
kubectl get secret -n monitoring kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```