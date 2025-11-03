# Резервное копирование через pg_dumpall всех БД (нужно установить postgresql-client-15, версия должна соответствовать версии psql)
1. Вписать вручную
```bash
pg_dumpall -h 192.168.1.126 -p 5432 -U postgres -f all_databases_backup.sql
```
2. Или через переменные
```bash
# Загрузить переменные из .env
source .env

# Использовать в команде
pg_dumpall -h 192.168.1.126 -p 5432 -U $DB_USER -f all_databases_backup.sql
# Пароль: $DB_PASSWORD
```
