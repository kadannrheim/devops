1. Создаём таблицу
```sql
CREATE TABLE public.passwords (
    password_id SERIAL PRIMARY KEY,
    password VARCHAR(100),
    user_id INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Внешний ключ должен быть внутри CREATE TABLE
    CONSTRAINT fk_password_user 
        FOREIGN KEY (user_id) 
        REFERENCES public.users(user_id)
        ON DELETE SET DEFAULT -- Поведение: При удалении пользователя, user_id получит значение по умолчанию
);
```

2. Наполнение. Для примера возъмём бех хэшей
```sql
-- Простое наполнение (выполните этот запрос)
INSERT INTO public.passwords (user_id, password) VALUES 
(1, 'petrov123'),
(2, 'sidorova456'),
(3, 'kozlov789'),
(4, 'volkova321'),
(5, 'novikov654'),
(6, 'smirnova987'),
(7, 'popov000'),
(8, 'fedorova111');
```