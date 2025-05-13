# Развёртывание vpn wireguard на docker через docker-compose
## Переменную PASSWORD уже не используют. Теперь PASSWORD_HASH. Генерируем хэш с помощью команды
1.
Но сперва ставим докер: https://docs.docker.com/engine/install/ubuntu/
2.
Всё остальное
`docker run --rm -it ghcr.io/wg-easy/wg-easy wgpw 'my_password'`
Символы $ экранируем ещё одним $. Из негерации кавычки убираем. Мануал здесь https://github.com/wg-easy/wg-easy/blob/master/How_to_generate_an_bcrypt_hash.md
3. 
Запускаем сборку `docker compose up -d`
## Структура
wireguard-ui/
├── .env
├── docker-compose.yml
├── Dockerfile
# └── config/
#    └── wg-easy/
#        ├── wg0.conf
#        ├── privatekey
#        └── другие_файлы_конфигурации

Всё идём в UI!
----
4. 
Эта нужно если настраивать на хосте или зайти в контейнер, вообщем прозапас здесь:
## Команды управления
`sudo wg-quick up wg0`
`sudo wg-quick down wg0`

Проверьте, что трафик идет через VPN:
`curl ifconfig.me`

Статус подключения
`sudo wg`

Чтобы WireGuard запускался автоматически при загрузке системы, включите сервис:
`sudo systemctl enable wg-quick@wg0`
`sudo systemctl start wg-quick@wg0`

## Настройка клиента (ubuntu 22.04)
Установка
`sudo apt install wireguard`

Создайте директорию для конфигурации:
`sudo mkdir -p /etc/wireguard`

Создайте файл конфигурации (например, wg0.conf):
`sudo nano /etc/wireguard/wg0.conf`

Вставьте конфигурацию, предоставленную администратором сервера

Запустите WireGuard с конфигурацией wg0:
`sudo wg-quick up wg0`

Проверьте статус подключения:
`sudo wg`

Пример рабочего сервиса
```bash
interface: wg0
  public key: <публичный_ключ_клиента>
  private key: (hidden)
  listening port: PORT

peer: <публичный_ключ_сервера>
  endpoint: IP:PORT
  allowed ips: 0.0.0.0/0
  latest handshake: 1 minute ago
  transfer: 1.23 MiB received, 456.78 MiB sent
```

----
## Troubleshooting
### Ошибка нет resolvconf
```bash
└─ $ sudo wg-quick up wg0
...
/usr/bin/wg-quick: line 32: resolvconf: command not found
[#] ip link delete dev wg0
```
Ошибка /usr/bin/wg-quick: line 32: resolvconf: command not found указывает на то, что на вашей системе отсутствует утилита resolvconf, которая используется для управления DNS-настройками
Установите утилиту resolvconf с помощью пакетного менеджера:
```bash
sudo apt update
sudo apt install resolvconf
```
После установки убедитесь, что служба resolvconf запущена:
```bash
sudo systemctl enable resolvconf
sudo systemctl start resolvconf
```
Проверьте, что DNS-серверы настроены:
`resolvectl status wg0`