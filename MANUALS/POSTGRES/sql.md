# Команды psql

Вот 10 самых часто используемых SQL запросов(Эти запросы покрывают большинство повседневных задач при работе с базами данных):

## 1. SELECT (выборка данных)
```sql
SELECT * FROM employees;
SELECT name, email FROM users WHERE status = 'active';
```

## 2. WHERE (фильтрация)
```sql
SELECT * FROM products WHERE price > 100;
SELECT * FROM orders WHERE order_date >= '2024-01-01';
```

## 3. ORDER BY (сортировка)
## ASC-по возрастанию, DESC-по убыванию
## ORDER BY = "упорядочить по" / "отсортировать по"
```sql
SELECT * FROM customers ORDER BY name ASC; 
SELECT * FROM sales ORDER BY amount DESC, date ASC;
```

## 4. JOIN (объединение таблиц)
## Скрипт связывает имена пользователей с их ноутбуками
## Шаблон `SELECT fieldA, fieldB FROM table1 JOIN table2 ON field1 = field2`
## ON u.user_id = l.user_id - "Связать запись из таблицы users с записью из таблицы laptops только тогда, когда их user_id совпадают"
## Подробное описание. Выбрать имена пользователей и название ноутбуков и брэнд из таблицы users и laptops и связать через left join когда их id совпадают (в БД ноутбуки есть привязка по id пользователя) и отсортировать по имени пользователя в порядке убывания:
```sql
select u.user_name, l.model, l.model
from public.users u 
left join public.laptops l on u.user_id = l.user_id 
order by u.user_name DESC
```
##  "LEFT JOIN" - показывает ВСЕХ пользователей (даже без ноутбуков)

## 5. GROUP BY (группировка)
```sql
SELECT department, COUNT(*) as employee_count 
FROM employees 
GROUP BY department;
```

## 6. INSERT (добавление записей)
```sql
INSERT INTO public.users (user_name, description, full_name, login) 
VALUES ('tommy', 'Пользователь Tommy без ноутбука', 'Tommy Smith', 'tommy_smith');
```

## 7. UPDATE (обновление записей)
```sql
UPDATE products 
SET price = price * 1.1 
WHERE category = 'electronics';
```

## 8. DELETE (удаление записей)
```sql
DELETE FROM logs 
WHERE created_at < '2023-01-01';
```

## 9. LIMIT (ограничение выборки)
```sql
SELECT * FROM products 
ORDER BY created_at DESC 
LIMIT 10;
```

## 10. Агрегирующие функции
```sql
SELECT 
    COUNT(*) as total_orders,
    AVG(amount) as avg_amount,
    SUM(amount) as total_sales
FROM orders;
```

## Бонус - часто используемые комбинации:

### Поиск с пагинацией:
```sql
SELECT * FROM products 
WHERE name LIKE '%phone%' 
ORDER BY price ASC 
LIMIT 20 OFFSET 0;
```

### Группировка с фильтрацией:
```sql
SELECT category, AVG(price) as avg_price 
FROM products 
GROUP BY category 
HAVING AVG(price) > 1000;
```

### Множественное объединение:
```sql
SELECT 
    o.order_number,
    c.name as customer_name,
    p.name as product_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;
```

# Практика:
## Имя и цена масел с ценой более 200 и датой создания от 20 октября отсортированные по убыванию: 
```sql
SELECT name, price 
from products.oil 
where price > 200 and created_at >= '2020.10.20'
order by price desc
```

# Резервное копирование
