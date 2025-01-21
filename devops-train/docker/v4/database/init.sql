-- Создание пользователя postgres
CREATE ROLE postgres WITH LOGIN PASSWORD 'password';
ALTER ROLE postgres CREATEDB;

-- Создание таблицы для хранения пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,         -- Уникальный идентификатор пользователя
    name VARCHAR(100) NOT NULL,    -- Имя пользователя
    email VARCHAR(100) NOT NULL    -- Email пользователя
);

-- Вставка начальных данных
INSERT INTO users (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');
