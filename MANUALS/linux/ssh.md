# Настройка ssh на ОС Linux (ubuntu 24.04)
# Базовая установка и настройка
SSH может работать в нескольких режимах, если нужен как сервер для подключений его нужно установить, тот который из коробки не подойдёт и его лучше выключить если по какой то причине он включен.
`sudo apt update && sudo apt install openssh-server`

`ssh-keygen -t ed25519 -C "ваш_email@example.com"` -Генерация ключа Ed25519 (рекомендуется)

`ssh-keygen -t rsa -b 4096 -C "ваш_email@example.com"` - Генерация RSA-ключа (для совместимости)

`ssh-keygen -lf ~/.ssh/id_ed25519.pub` -Посмотреть fingerprint ключа

----
# Настройка подключения по ключу
Скопировать ключь можно по scp или по ssh-copy-key
scp  Копирование с локальной машины на удалённую:
```bash
scp /путь/к/локальному/файлу username@удалённый_сервер:/путь/на/удалённом/сервере/
scp ~/documents/report.txt user@192.168.1.100:/home/user/downloads/
```
scp  Копирование с удалённой машины на локальную
```bash
scp username@удалённый_сервер:/путь/к/файлу /локальный/путь/
scp user@192.168.1.100:/var/log/app.log ~/backups/
```
`ssh-copy-id user@host` -по ssh-copy-id (удобней всего)

# Jump! через машину внешним адресом на локальнуж в той же сети
`ssh -J kadannr@server-train:22 kadannr@192.168.1.53`
----
# Файлы конфигурации и пути
Конфигурацию SSH-сервера (/etc/ssh/sshd_config)

----
# Траблшуттинг
1. Права на файл (ключ)
Права на файлы:

На локальной машине:

```bash
chmod 600 ~/.ssh/id_ed25519  # Закрытый ключ
chmod 644 ~/.ssh/id_ed25519.pub  # Публичный ключ
```
На удалённом сервере:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
2. Разрешение на подключение через key в конфигах ssh
Конфигурацию SSH-сервера (/etc/ssh/sshd_config):
Убедитесь, что есть строки:

```ini
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
PasswordAuthentication no  # (опционально, для отключения парольной аутентификации)
После правки перезапустите SSH:
```
```bash
sudo systemctl restart sshd
```
3. Команды для диагностики:
    Ключ -vvv покажет детали процесса аутентификации
    `sudo ss -tulnp | grep ssh` (должен быть в выводе что слушает и какой порт обязательно, если нет, тогда ssh нужно ставить) 

    `sudo systemctl status ssh`

    `ssh-add -l` -На клиенте проверьте, что ключ добавлен в агент

    `sudo grep ssh /var/log/syslog` -Некоторые системы используют /var/log/secure или /var/log/syslog

    `sudo ufw status`

    `sudo systemctl enable --now ssh` -Запустите сервер

    `tail -f /var/log/auth.log` -диагностика при аутентификации

    `ssh-add ~/.ssh/id_ed25519`  -Добавление ключа

    `ssh -i ~/.ssh/другой_ключ user@host` -указать ключ при подключении

----
# Удобства
Подключение по имени
```~/.ssh/config
Host web-server
  HostName 192.168.1.53
  User kadannr
  IdentityFile ~/.ssh/id_rsa # или id_ed25519
  Port 22
```

