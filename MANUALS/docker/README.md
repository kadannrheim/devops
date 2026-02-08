Установка 2026
Нужно добавить GPG-ключ Docker. Вот решение:

## 🔑 **Добавление GPG-ключа Docker:**

### 1. **Удалите старые ключи и репозиторий (если были проблемы):**
```bash
sudo rm /etc/apt/sources.list.d/docker.list
sudo rm -f /etc/apt/trusted.gpg.d/docker.gpg
sudo rm -f /etc/apt/keyrings/docker.asc
sudo rm -f /etc/apt/keyrings/docker.gpg
```

### 2. **Добавьте официальный GPG-ключ Docker:**
```bash
# Создайте директорию для ключей
sudo install -m 0755 -d /etc/apt/keyrings

# Скачайте ключ
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Установите правильные права
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

### 3. **Добавьте репозиторий Docker правильно:**
```bash
# Определите кодовое имя системы
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 4. **Обновите apt и установите Docker:**
```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

---

## ⚡ **Альтернативный метод (если первый не сработает):**

### **Метод 1: Используйте apt-key (устаревший, но работает):**
```bash
# Добавьте ключ
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Добавьте репозиторий
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
```

### **Метод 2: Вручную добавить ключ:**
```bash
# Скачайте ключ
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Добавьте репозиторий
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

---

## 🔍 **Проверка:**

### 1. **Убедитесь, что ключ добавлен:**
```bash
sudo apt-key list | grep -A1 -B1 Docker
# ИЛИ
ls -la /etc/apt/keyrings/
```

### 2. **Проверьте файл репозитория:**
```bash
cat /etc/apt/sources.list.d/docker.list
```
Должно быть что-то вроде:
```
deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu noble stable
```

### 3. **Если всё ещё есть ошибка, попробуйте:**
```bash
# Очистите apt кеш
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*

# Обновите заново
sudo apt update
```

### 4. **Установите Docker после успешного обновления:**
```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

---

## 📝 **Если всё равно не работает:**
Возможно, проблема с доступностью репозитория. Проверьте:
```bash
# Проверьте доступность репозитория
curl -I https://download.docker.com/linux/ubuntu/dists/noble/InRelease

# Попробуйте временно отключить проверку подписи (НЕ РЕКОМЕНДУЕТСЯ для продакшена)
# sudo sed -i '/download.docker.com/s/^/# /' /etc/apt/sources.list.d/docker.list
# echo "deb [trusted=yes] https://download.docker.com/linux/ubuntu noble stable" | sudo tee -a /etc/apt/sources.list.d/docker.list
```

После добавления ключа всё должно заработать. Ключ с отпечатком `7EA0A9C3F273FCD8` должен появиться в списке доверенных ключей.