/*
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

*/

USE shop;

-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
	users.name user_name, 
	COUNT(users.id) quantity
FROM 
	users
INNER JOIN orders ON 
(
	users.id = orders.user_id
)
GROUP BY
	users.id
HAVING
	COUNT(users.id) >= 1
;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT 
	p.id product_id,
	p.name product_name,
	p.description product_description,
	c.name catalog_name
FROM 
	products p
INNER JOIN catalogs c ON 
(
	p.catalog_id = c.id
)
ORDER BY p.id	
;

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

-- Создаем таблицы и наполняем данными из примера
CREATE TABLE flights (
  id SERIAL PRIMARY KEY COMMENT 'Номер',
  `from` VARCHAR(50) NOT NULL COMMENT 'Откуда',
  `to` VARCHAR(50) NOT NULL COMMENT 'Куда'
) COMMENT 'Рейсы';

INSERT INTO flights 
	(id, `from`, `to`) 
VALUES 
	(1, 'moscow', 'omsk'),
	(2, 'novgorod', 'kazan'),
	(3, 'irkutsk', 'moscow'),
	(4, 'omsk', 'irkutsk'),
	(5, 'moscow', 'kazan')
;

SELECT * FROM flights;

CREATE TABLE cities (
  id SERIAL PRIMARY KEY COMMENT 'Id',
  `label` VARCHAR(50) NOT NULL COMMENT 'Обозначение',
  `name` VARCHAR(50) NOT NULL COMMENT 'Название города'	
) COMMENT 'Города';

INSERT INTO cities 
	(id, `label`, `name`) 
VALUES 
	(1, 'moscow', 'Москва'),
	(2, 'irkutsk', 'Иркутск'),
	(3, 'novgorod', 'Новгород'),
	(4, 'kazan', 'Казань'),
	(5, 'omsk', 'Омск')
;

SELECT * FROM cities;

-- Отображаем рейсы с названиями городов по-русски

SELECT 
	f.id flight_number,
	c1.name city_from_name,
	c2.name city_to_name
FROM 
	flights f
INNER JOIN cities c1 ON 
(
	f.`from` = c1.`label`
)
INNER JOIN cities c2 ON
(
	f.`to` = c2.`label`
)
ORDER BY f.id	
;

