1. Создание таблицы
```sql
create table public.users (
user_id SERIAL primary key,
user_name VARCHAR(100) not null,
description text,
created_at TIMESTAMP default CURRENT_TIMESTAMP
);
```

2. Наполнение таблицы
```sql
insert into public.users (user_name, description) values
('Мария Сидорова', 'UX/UI дизайнер, специалист по мобильным интерфейсам'),
('Алексей Козлов', 'Data scientist, машинное обучение'),
('Ольга Волкова', 'Project manager, Agile методологии'),
('Дмитрий Новиков', 'DevOps инженер, облачные технологии'),
('Екатерина Смирнова', 'Frontend разработчик, React/Vue'),
('Сергей Попов', 'Бэкенд разработчик, Python/Django'),
('Анна Федорова', 'Тестировщик, автоматизация тестов');
```
```sql
INSERT INTO products.bread (user_name, description, weight_grams, price, created_at) VALUES
('Багет французский', 'Свежий хрустящий багет с хрустящей корочкой', 250, 120.00, CURRENT_TIMESTAMP),
('Бородинский хлеб', 'Ржаной хлеб с тмином и кориандром', 500, 85.00, CURRENT_TIMESTAMP),
('Кукурузный хлеб', 'Мягкий хлеб с добавлением кукурузной муки', 400, 95.00, CURRENT_TIMESTAMP),
('Чиабатта', 'Итальянский хлеб с пористой мякотью', 300, 110.00, CURRENT_TIMESTAMP),
('Цельнозерновой тостовый', 'Полезный хлеб из цельного зерна', 450, 75.00, CURRENT_TIMESTAMP),
('Бриошь', 'Сладкая булочка с маслянистой текстурой', 150, 65.00, CURRENT_TIMESTAMP),
('Лаваш армянский', 'Тонкий пресный хлеб', 200, 55.00, CURRENT_TIMESTAMP),
('Содовый хлеб', 'Ирландский хлеб без дрожжей', 350, 80.00, CURRENT_TIMESTAMP),
('Фокачча с розмарином', 'Итальянская лепешка с оливковым маслом', 280, 130.00, CURRENT_TIMESTAMP),
('Пита ливанская', 'Карманный хлеб для начинки', 100, 45.00, CURRENT_TIMESTAMP);
```
3. Изменение таблицы, добавление столбца
`ALTER TABLE public.users ADD COLUMN full_name VARCHAR(200)`
или добавление нескольких столбцов
```sql
ALTER TABLE products.bread 
ADD COLUMN weight_grams INTEGER,
ADD COLUMN price DECIMAL(10,2);
```

4. Наполнение столбца
```sql
UPDATE public.users SET full_name = 
    CASE user_id
        WHEN 1 THEN 'Петров Иван Сергеевич'
        WHEN 2 THEN 'Сидорова Мария Андреевна'
        WHEN 3 THEN 'Козлов Алексей Владимирович'
        WHEN 4 THEN 'Волкова Ольга Дмитриевна'
        WHEN 5 THEN 'Новиков Дмитрий Павлович'
        WHEN 6 THEN 'Смирнова Екатерина Игоревна'
        WHEN 7 THEN 'Попов Сергей Николаевич'
        WHEN 8 THEN 'Федорова Анна Викторовна'
    END
```
# Изменение названи столбца
`ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;`