# Используем базовый образ wg-easy
FROM ghcr.io/wg-easy/wg-easy:latest

# Устанавливаем дополнительные пакеты (если нужно)
#RUN apt-get update && apt-get install -y \
#    some-package \
#    && rm -rf /var/lib/apt/lists/*

# Копируем свои скрипты (если нужно)
#COPY ./scripts /app/scripts

# Устанавливаем переменные окружения (если нужно)
ENV WG_HOST=${WG_HOST}
ENV PASSWORD_HASH=${PASSWORD_HASH}

# Открываем порты
EXPOSE 51820/udp
EXPOSE 51821/tcp

# Запускаем wg-easy
CMD ["node", "server.js"]