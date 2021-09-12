DROP DATABASE IF EXISTS vk1;
CREATE DATABASE vk1;

SHOW DATABASES;
USE VK1;

-- ДЗ 5 часть 1 Сортировка данных п.1. Создаем таблицу пользователей, поля created_at, updated_at имеют тип varchar

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки', -- искуственный ключ
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
    birthday DATE NOT NULL COMMENT 'Дата рождения',
    gender CHAR(1) NOT NULL COMMENT 'Пол',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя',  -- email + phone - натуральный ключ
    phone VARCHAR(12) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',    
    created_at VARCHAR(19) COMMENT 'Дата и время создания строки',
    updated_at VARCHAR(19) COMMENT 'Дата и время обновленния строки'
) COMMENT 'Таблица пользователей';

-- ДЗ 5 часть 1 Сортировка данных п.1. Вставляем данные, поля created_at, updated_at пустые

INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (1, 'Ezequiel', 'Johnston', '1977-07-05', 'F', 'odoyle@example.org', '+79161234567');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (2, 'Octavia', 'Casper', '1982-09-20', 'M', 'yundt.adriana@example.net', '+79031331234');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (3, 'Ignatius', 'Kuhn', '1993-08-13', 'F', 'lang.tad@example.org', '+79119067890');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (4, 'Jana', 'Lubowitz', '2002-07-09', 'F', 'colleen06@example.org', '+79102123467');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (5, 'Remington', 'Gorczany', '1998-06-13', 'F', 'lwest@example.com', '+79260901254');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (6, 'Richie', 'Dicki', '1978-09-10', 'F', 'schmitt.bernhard@example.net', '+79656744545');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (7, 'Marlee', 'Homenick', '1999-02-04', 'M', 'ecrooks@example.org', '+78127866776');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (8, 'Sofia', 'Runolfsson', '2021-02-24', 'F', 'winfield.ruecker@example.org', '+79856799090');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (9, 'Lila', 'Willms', '1988-09-15', 'F', 'cydney.medhurst@example.org', '+74990908899');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `birthday`, `gender`, `email`, `phone`) VALUES (10, 'Jaycee', 'Trantow', '1990-09-24', 'F', 'silas.prosacco@example.net', '+79100123697');

SELECT * FROM users;

-- ДЗ 5 часть 1 Сортировка данных п.2. Заполняем пустые поля created_at, updated_at текущей датой и временем в формате "20.10.2017 8:10"
UPDATE users SET created_at = DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'), updated_at = DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m') WHERE id < 200;

-- Приводим поля created_at, updated_at к типу DATETIME без потери данных 
UPDATE users 
SET 
  created_at = CONCAT(SUBSTR(created_at, 7, 4), '-', SUBSTR(created_at, 4, 2), '-', SUBSTR(created_at, 1, 2), ' ', SUBSTR(created_at, 12, 2), ':', SUBSTR(created_at, 15, 2), ':00'), 
  updated_at = CONCAT(SUBSTR(updated_at, 7, 4), '-', SUBSTR(updated_at, 4, 2), '-', SUBSTR(updated_at, 1, 2), ' ', SUBSTR(updated_at, 12, 2), ':', SUBSTR(updated_at, 15, 2), ':00') 
WHERE id < 200;

ALTER TABLE users MODIFY created_at DATETIME COMMENT 'Дата и время создания строки'; 
ALTER TABLE users MODIFY updated_at DATETIME COMMENT 'Дата и время обновленния строки'; 

DESCRIBE users; -- проверяем тип полей
SELECT * FROM users; -- проверяем, что значения не потерялись

-- ДЗ 5 часть 1 Сортировка данных п.3. Работа с таблицей storehouses_products
 
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

-- ДЗ 5 п.3. Работа с таблицей storehouses_products
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products 
  (storehouse_id, product_id, value)
VALUES
  (1, 1, 0),
  (1, 2, 2500),
  (1, 3, 0),
  (2, 4, 30),
  (2, 5, 500),
  (1, 6, 1);

-- ДЗ 5 часть 1 Сортировка данных п.3. Сортировка запасов по увеличению value, но с нулевыми значениями в конце
(SELECT * FROM storehouses_products WHERE value > 0 ORDER BY value LIMIT 4)
UNION
(SELECT * FROM storehouses_products WHERE value = 0);

-- ДЗ 5 часть 1 Сортировка данных п.4 Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
-- Возможно, я это задание не так поняла...

SELECT name, 
  CASE
	WHEN DATE_FORMAT(birthday_at, '%m') = '05' THEN CONCAT(DATE_FORMAT(birthday_at, '%d'),'-May-', DATE_FORMAT(birthday_at, '%Y'))
    WHEN DATE_FORMAT(birthday_at, '%m') = '08' THEN CONCAT(DATE_FORMAT(birthday_at, '%d'),'-August-', DATE_FORMAT(birthday_at, '%Y'))
  END AS birthday_month
FROM users WHERE DATE_FORMAT(birthday_at, '%m') IN ('05', '08');

-- ДЗ 5 часть 1 Сортировка данных п.5. Сортировка записей в порядке 5, 1, 2
(SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY id DESC LIMIT 1)
UNION
(SELECT * FROM catalogs WHERE id IN (1, 2) ORDER BY id LIMIT 2);

-- ДЗ 5 часть 2 Агрегация данных п.1 Подсчитайте средний возраст пользователей в таблице users
SELECT FLOOR(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25)) AS average_age FROM users;
SELECT FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) AS average_age FROM users;

-- ДЗ 5 часть 2 Агрегация данных п.2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT 
	DAYOFWEEK(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d'))) AS Day_of_week,
	COUNT(DAYOFWEEK(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d')))) AS Birthdays_count 
FROM users 
GROUP BY DAYOFWEEK(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d'))) 
ORDER BY DAYOFWEEK(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d')));

-- ДЗ 5 часть 2 Агрегация данных п.2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
CREATE TABLE tbl1 (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки', -- искуственный ключ
    value INT COMMENT 'Значение строки'
    ) COMMENT 'Таблица для подсчета произведения чисел';
    INSERT INTO tbl1 
		(value)
    VALUES 
		(1), 
        (2), 
        (3), 
        (4), 
        (5);
	SELECT * FROM tbl1;
    SELECT value, LOG(value) FROM tbl1; -- считаем логарифм от каждого значения
    SELECT SUM(LOG(value)) FROM tbl1; -- считаем сумму этих логарифмов
    SELECT ROUND(EXP(SUM(LOG(value)))) FROM tbl1; -- возводим экспоненту в степень, равную полученной сумме, и округляем
    