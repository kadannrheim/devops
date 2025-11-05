# Протестирована и проверена 04.11.2025 на 
Установка Docker на Ubuntu 24.04 — пошаговая инструкция:

## 1. Обновление системы
```bash
sudo apt update
sudo apt upgrade -y
```

## 2. Установка необходимых пакетов
```bash
sudo apt install -y apt-transport-https ca-certificates curl gnupg
```

## 3. Добавление официального GPG-ключа Docker
```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

## 4. Добавление репозитория Docker
```bash
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## 5. Обновление пакетного менеджера
```bash
sudo apt update
```

## 6. Установка Docker
```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## 7. Запуск и включение Docker
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

## 8. Проверка установки
```bash
sudo docker --version
sudo docker run hello-world
```

## 9. Настройка прав для текущего пользователя (опционально)
Чтобы не использовать `sudo` с Docker командами:
```bash
sudo usermod -aG docker $USER
```
После этого нужно **выйти и зайти заново** в систему.

## 10. Проверка работы без sudo
```bash
docker run hello-world
```

## Установка Docker Compose (если нужно)
Docker Compose уже включен в установку, но если нужна отдельная установка:
```bash
sudo apt install -y docker-compose-plugin
```

## Полезные команды для проверки
```bash
# Проверить статус службы
sudo systemctl status docker

# Посмотреть информацию о Docker
docker info

# Посмотреть запущенные контейнеры
docker ps
```

После выполнения этих шагов Docker будет успешно установлен и готов к работе на Ubuntu 24.04!