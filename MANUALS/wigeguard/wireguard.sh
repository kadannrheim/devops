# https://blog.komow.ru/wg

1. ЭТАП
# apt update and installation
git clone -b v3.0.6 https://github.com/donaldzou/WGDashboard.git wgdashboard & apt install wireguard iptables python3-pip git mc htop -y & apt upgrade
# Создаём конфиг для сервера https://www.wireguardconfig.com/
#Создаем файл конфигурации сервера в  папке WireGuard
vim /etc/wireguard/server.conf
# Ниже строки PrivateKey добавляем параметр:
# SaveConfig = true
# Добавляем WireGuard в автозагрузку и запускаем его
systemctl enable wg-quick@server
systemctl start wg-quick@server
#Просмотр текущих подключений
wg show

2. ЭТАП
# Настраиваем веб-интерфейс управления сервером
# В качестве веб-панели будем использовать WGDashboard https://github.com/donaldzou/WGDashboard панель написана на Python и не требует дополнительных компонентов в виде веб-сервера, СУБД и тд. Панель позволяет осуществлять управление и мониторинг пользователей и требует наличия Python 3.7+ и Pip3. Python в Debian уже установлен по умолчанию, установим Pip3 командой:
# Скачиваем WGDashboard:
git clone -b v3.0.6 https://github.com/donaldzou/WGDashboard.git wgdashboard
# Переходим в папку WGDashboard
cd wgdashboard/src
# Делаем файл исполняемым и устанавливаем WGDashboard
chmod u+x wgd.sh
./wgd.sh install
# Даем права для папки с файлами конфигурации WireGuard:
chmod -R 755 /etc/wireguard
# Стартуем WGDashboard
./wgd.sh start
# Наша панель слушает порт 10086. Пробуем зайти на нашу веб-панель по адресу http://<ip-сервера>:10086 если все сделано правильно мы должны увидеть окно авторизации:
# Учетные данные по-умолчанию:
# username: admin
# password: admin

```3. Этап, не работает пока
# Автозагрузка панели
# Для того чтобы веб-панель стартовала при старте системы, создаем стартовый скрипт:
vim wg-dashboard.service
# Со следующим содержимым (если вы не меняли расположение скачанных файлов):
```
[Unit]
After=network.service

[Service]
WorkingDirectory=/root/wgdashboard/src
ExecStart=/usr/bin/python3 /root/wgdashboard/src/dashboard.py
Restart=always

[Install]
WantedBy=default.target
```
# Сохраняем скрипт.
# Копируем скрипт в папку systemd:
cp wg-dashboard.service /etc/systemd/system/wg-dashboard.service
# Включаем сервис:
chmod 664 /etc/systemd/system/wg-dashboard.service
systemctl daemon-reload
systemctl enable wg-dashboard.service
systemctl start wg-dashboard.service ```

ПРОПУСТИЛ настройка фаервола
# Настройка межсетевого экрана
# Разрешаем маршрутизацию трафика между интерфейсами. Для этого открываем файл /etc/sysctl.conf в текстовом редакторе:
vim /etc/sysctl.conf
# Находим строку #net.ipv4.ip_forward=1  убираем знак # в начале строки, сохраняем файл и применяем внесенные изменения:
sysctl -p
# Включаем маскарадинг (NAT) на внешнем интерфейсе, название внешнего интерфейса можно посмотреть командой ip a, в нашем примере это enp0s3:
iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
# Разрешаем входящие соединения, если они являются ответом на исходящие:
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
# Разрешаем доступ к серверу по SSH и VPN
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p udp --dport 51820 -j ACCEPT
# Разрешаем доступ с loopback и VPN интерфейсов
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i server -j ACCEPT
# Разрешаем маршрутизацию трафика между VPN и внешней сетью:
iptables -A FORWARD -i server -j ACCEPT
# На последнем этапе добавляем правила по умолчанию:
пропустил iptables -P INPUT DROP
пропустил iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
# Сохраняем созданные правила в файл:
iptables-save > /etc/iptables.rules
# Чтобы правила применялись при загрузке системы открываем файл /etc/network/interfaces и добавляем в конец файла строку:
pre-up iptables-restore < /etc/iptables.rules
# После этого можно пробовать получить доступ к удаленным сетям через наш туннель. 
# На этом настройку можно считать оконченной.