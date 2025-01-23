-- Создание таблицы для хранения пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,         -- Уникальный идентификатор пользователя
    name VARCHAR(100) NOT NULL,    -- Имя пользователя
    email VARCHAR(100) NOT NULL    -- Email пользователя
);

-- Вставка начальных данных
INSERT INTO users (name, email) VALUES
('Kirrill', 'kirrill@example.com'),
('Platon', 'platon@example.com'),
('Mefodiy', 'mefodiy@example.com');