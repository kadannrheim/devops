# Используем базовый образ для Go
FROM golang:1.21-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы приложения в контейнер
COPY . .

# Загружаем зависимости и компилируем приложение
RUN go mod init backend \
    && go get github.com/lib/pq \
    && go mod tidy \
    && go build -o backend .

# Указываем команду для запуска приложения
CMD ["./backend"]

# Указываем порт для взаимодействия
EXPOSE 8080
