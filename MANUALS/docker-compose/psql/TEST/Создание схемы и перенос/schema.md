# Создание схемы
```sql
CREATE SCHEMA schema_name;
```

# 2. Перенос таблицы (без зависимстей)
```sql
ALTER TABLE old_schema.table_name SET SCHEMA new_schema;
```

# 3. Создание таблицы в опредеделённой схеме
```sql
CREATE TABLE schema_name.table_name (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```