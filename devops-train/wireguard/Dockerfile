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
ENV PASSWORD_HASH=$2a$14$lOCTdM.4slPrIAjcsbjYrOc5pzbpNO/neGZdIj9w2/5Smek7hqXMC

# Открываем порты
EXPOSE 51820/udp
EXPOSE 51821/tcp

# Запускаем wg-easy
CMD ["node", "server.js"]