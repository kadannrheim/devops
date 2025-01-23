## Создайте микросервисное приложение с такими критериями:

- [ ] frontend (элементарная веб страница с JS, которая делает запросы к бекенду)
- [ ] backend (например приложение на go или python/php, которое работает с базой данных)
- [ ] database (по вашему выбору pgsql, mysql, mongodb). Не забудьте подключить volumes
- [ ] nginx proxy (как мы уже делали в этом и прошлых задачах)
- [ ] используйте environment переменные для указания параметров подключения к базе данных
- [ ] все это необходимо описать в docker-compose.yml


# Структура
```
├── docker-compose.yml
├── .env
├── backend/
│   ├── Dockerfile
│   ├── main.go
├── frontend/
│   ├── Dockerfile
│   ├── index.html
│   ├── script.js
├── nginx/
│   ├── Dockerfile
│   ├── nginx.conf
└── database/
    └── init.sql
```
