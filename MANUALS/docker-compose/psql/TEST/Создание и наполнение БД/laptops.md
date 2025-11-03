1. Создаём таблицу
```sql
-- Создаем таблицу ноутбуков
CREATE TABLE public.laptops (
    laptop_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    processor VARCHAR(100),
    ram_gb INTEGER,
    storage_gb INTEGER,
    purchase_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Внешний ключ на таблицу users
    -- Поведение: При удалении пользователя, user_id получит значение по умолчанию
CONSTRAINT fk_laptop_user 
    FOREIGN KEY (user_id) 
    REFERENCES public.users(user_id)
    ON DELETE SET NULL
)
```
>CONSTRAINT - объявление ограничения (правила)
>fk_laptop_user - имя ограничения (можно любое, но лучше осмысленное)
>Цель: дать имя правилу, чтобы потом можно было его изменить или удалить

2. Наполняем её
```sql
-- Вставляем ноутбуки для пользователей
INSERT INTO public.laptops (user_id, brand, model, processor, ram_gb, storage_gb, purchase_date) VALUES 
(1, 'Apple', 'MacBook Pro 16"', 'M2 Pro', 32, 1000, '2023-05-15'),
(1, 'Dell', 'XPS 13', 'Intel i7', 16, 512, '2021-03-10'),
(2, 'Apple', 'MacBook Air', 'M1', 16, 512, '2022-11-20'),
(3, 'Lenovo', 'ThinkPad P1', 'Intel i9', 64, 2000, '2023-01-08'),
(4, 'Microsoft', 'Surface Laptop 5', 'Intel i7', 16, 512, '2023-02-14'),
(5, 'Dell', 'Precision 5560', 'Intel Xeon', 32, 1000, '2022-09-05'),
(6, 'Apple', 'MacBook Pro 14"', 'M2 Pro', 32, 1000, '2023-04-18'),
(7, 'Framework', 'Laptop 13', 'AMD Ryzen 7', 32, 1000, '2023-07-22'),
(8, 'HP', 'EliteBook 840', 'Intel i5', 16, 256, '2021-12-10'),
(2, 'Asus', 'ZenBook 14', 'Intel i7', 16, 512, '2020-08-15')
```
3. Выборка из двух баз
```sql
SELECT 
    l.laptop_id,
    l.brand,
    l.model,
    l.processor,
    u.user_id,
    u.full_name
FROM public.laptops l
JOIN public.users u ON l.user_id = u.user_id
```