Настроить IPsec/IKEv2 VPN на Ubuntu 24.04 через консоль можно напрямую через strongSwan без Network Manager:

## 1. **Установка strongSwan**
```bash
sudo apt update
sudo apt install -y strongswan libcharon-extra-plugins libstrongswan-extra-plugins
```

## 2. **Настройка конфигурации**
Предполагая, что у вас есть данные от Beget:
- Адрес сервера
- Логин (обычно в формате `vpnXXXXX@beget.com`)
- Пароль
- PSK (pre-shared key, если используется)

### a. **Настройка `/etc/ipsec.conf`** . Готовый мой фал лежит локально\облако
```bash
sudo nano /etc/ipsec.conf
```
Добавьте:
```conf
config setup
    charondebug="ike 2, knl 2, cfg 2"
    uniqueids=no
    strictcrlpolicy=no

conn beget-vpn
    # Тип подключения
    authby=secret
    
    # Настройки IKE
    ike=aes256-sha256-modp2048!
    esp=aes256-sha256!
    
    # Режим
    keyexchange=ikev2
    type=tunnel
    
    # Агрессивный режим (если требуется)
    aggressive=no
    
    # Клиентские настройки
    left=%defaultroute
    leftsourceip=%config
    leftauth=eap-mschapv2
    leftid=your_login@beget.com  # ЗАМЕНИТЕ на ваш логин
    leftfirewall=yes
    
    # Серверные настройки
    right=vpn.beget.com          # ИЛИ адрес сервера от Beget
    rightsubnet=0.0.0.0/0
    rightauth=psk
    rightid=@beget.com
    
    # Автоподключение
    auto=add
    dpdaction=restart
    dpddelay=30s
    dpdtimeout=120s
    
    # Переподключение
    rekey=yes
    reauth=no
```

### b. **Настройка `/etc/ipsec.secrets`**
```bash
sudo nano /etc/ipsec.secrets
```
Добавьте (замените значения):
```conf
# PSK для сервера
your_login@beget.com : PSK "your_psk_here"  # PSK от Beget

# EAP логин/пароль
your_login@beget.com : EAP "your_password_here"  # Пароль от Beget
```

## 3. **Настройка DNS** (опционально, но рекомендуется)
```bash
sudo nano /etc/strongswan.d/charon/dns.conf
```
Убедитесь, что есть строки:
```conf
dns {
    load = yes
}
```

## 4. **Включение IPv4 форвардинга**
```bash
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
```

## 5. **Запуск и управление VPN**

### Запуск strongSwan:
```bash
sudo systemctl restart strongswan-starter
sudo systemctl enable strongswan-starter
```

### Проверка статуса:
```bash
sudo systemctl status strongswan-starter
sudo ipsec status
```

### Подключение к VPN:
```bash
sudo ipsec up beget-vpn
```

### Отключение:
```bash
sudo ipsec down beget-vpn
```

### Проверка подключения:
```bash
# Проверьте туннель
ip addr show

# Проверьте маршруты
ip route show

# Проверьте доступность через VPN
ping -I <vpn_interface_ip> 8.8.8.8
```

## 6. **Логи и отладка**
Если есть проблемы, смотрите логи:
```bash
# В реальном времени
sudo journalctl -fu strongswan-starter

# Детальные логи
sudo ipsec statusall
sudo ipsec whack --trafficstatus
```

## 7. **Автозапуск при загрузке**
```bash
# Измените auto=add на auto=start в /etc/ipsec.conf если нужно авто-подключение
sudo nano /etc/ipsec.conf
# Замените: auto=add → auto=start
```