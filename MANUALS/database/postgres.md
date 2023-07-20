# Общая информация по БД Postgres
## Восстановление backup к примеру на Docker
### Копирует\создаём файл на хосте (где стоит сам docker)
```
sudo cp test_dump.sql /var/lib/docker/volumes/postgres14_data/_data
root@d02dd17d1577:/var/lib/postgresql/data14# ls
test_dump.sql
```
### Подключаюсь в контейнеру с БД, контейнер psql14
```
docker exec -it psql14 bash
```
### Восстанавливаю backup и вижу сразу вывод. 
```
root@d02dd17d1577:/var/lib/postgresql/data14# psql -U postgres -f ./test_dump.sql test_database
SET
...
(1 row)
ALTER TABLE
```
## Создание backup на примере Docker
### В контейнере создаем бэкап БД `test_database`
/var/lib/postgresql/data# pg_dump -U postgres -d test_database > test_database_dump.sql

## Общее
`psql -h localhost -p 5432 -U postgres -W` -подключение к postgres хост\порт\пользователь
`/l` -показать таблицы
`\c [nameDB]` -подключение к БД

# Выполнить запрос в БД postgres и выгрузить результат в csv. Пример #sql #psql
```
SELECT offence_id, user_name, status, to_char(ins_time, 'YYYY-MM-DD HH24:MI:SS') as date FROM lawn.offence_status_history WHERE ins_time::date > '2023-03-01' and ins_time::date < '2023-03-24' and user_name NOT LIKE 'Белова Анна' and user_name NOT LIKE 'Автоматически'
```
как выгрузить в csv
```
Copy (Сюда вставляем селект) To '/tmp/spb_select2.csv' With CSV DELIMITER ',' HEADER;
```
