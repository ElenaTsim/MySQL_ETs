DROP DATABASE vk;
CREATE DATABASE vk;

SHOW DATABASES;
USE VK;

-- ""
-- ''
-- ``

-- phone 89771112233 
-- Тип
-- 1. Физическое представление 
-- 2. Внешнее представление
-- 3. Набор операций

-- INT + - / *
-- VARCHAR конкатенация (слияние строк)

-- INT(11) VARCHAR(11)

-- PRIMARY KEY (уникально идент. запись в таблице) + не может быть пустым. У каждой таблицы может быть только одитн первичный ключ.
-- Ограничение целостности (логическое ограничение доменной области) 
-- 0. Ограничение типа
-- 1. NOT NULL
-- 2. UNIQUE
-- 3. Значения по умолчанию для атрибута
-- 4. Внешний ключ (ссылочную целостность)

SELECT 1 FROM DUAL;
SELECT 1;
SELECT NOW();
SELECT current_timestamp();

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки', -- искуственный ключ
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
    birthday DATE NOT NULL COMMENT 'Дата рождения',
    gender CHAR(1) NOT NULL COMMENT 'Пол',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя',  -- email + phone - натуральный ключ
    phone VARCHAR(11) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',    
    created_at DATETIME COMMENT 'Дата и время создания строки',
    updated_at DATETIME COMMENT 'Дата и время обновленния строки'
) COMMENT 'Таблица пользователей';

-- email phone

-- имя_атрибута тип_атрибута ОЦ
-- id SERIAL PRIMARY KEY
-- SERIAL - INT UNSIGNED NOT NULL AUTO_INCREMENT

CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
	city VARCHAR(100) COMMENT 'Город проживания',
    country VARCHAR(100) COMMENT 'Старана проживания',    
    `status` VARCHAR(10) COMMENT 'Текущий статус',
	created_at DATETIME COMMENT 'Дата и время создания строки',    
    updated_at DATETIME COMMENT 'Дата и время обновленния строки'
) COMMENT "Таблица профилей";

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:1
-- users <- profiles 

-- n:n
CREATE TABLE friendship (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
    friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
    request_type VARCHAR(10) COMMENT 'Тип запроса',
    requested_at DATETIME COMMENT 'Время отправки приглашения',
    confirmed_at DATETIME COMMENT 'Время подтверждения приглашения',
    created_at DATETIME COMMENT 'Дата и время создания строки',    
    updated_at DATETIME COMMENT 'Дата и время обновленния строки',
    PRIMARY KEY (user_id, friend_id) COMMENT 'Составной первичный ключ'
);

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:n
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); -- 1:n

-- Cвязи
-- 1. Через внешний ключ. Внешний ключ всегда связывает одно поле таблицы с другим полем другой таблицы. 1:1, 1:n
-- 2. Через таблицу связи n:n

-- Алгоритм
-- 1. Создаем первую широкую сущность (основная/основные сущности домменной области)
-- 2. Нормалируем исходные сущности
-- 3. Связываем сущности
-- 4. Определяем первичный ключ
-- 5. Создаем остальные ОЦ
-- 6. GO TO 1 (Пытаемся описать новый функционал в рамках существующих сущностей)

-- user_id, friend_id 

CREATE TABLE friendship_request_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Типы запроса на дружбы";

/* 
По структуре всё понятно
Чего, на мой взгляд, не хватает:
- родной город (в таблицу users)
- поле "интересы" или "о себе" - VARCHAR(255) (в таблицу users)
- семейное положение (выбор из справочника) - я бы добавила в таблицу profiles
- таблицу родственных отношений пользователя с другими пользователями
