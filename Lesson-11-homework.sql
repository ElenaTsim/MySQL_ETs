/*
Практическое задание по теме “Оптимизация запросов”
1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/

-- 1. Создайте таблицу logs типа Archive. 
-- Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

USE shop;

CREATE TABLE logs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор записи',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания записи', 
	table_name ENUM('users', 'catalogs', 'products') COMMENT 'Имя таблицы',
	prim_key_value BIGINT COMMENT 'Идентификатор первичного ключа',
	name_value VARCHAR(255) COMMENT 'Значение поля name'
) ENGINE=Archive COMMENT 'Таблица логов';

DROP TRIGGER write_log_on_insert_into_users;

-- создаем триггер на вставку записи в лог при добавлении новой записи в таблицу users
DELIMITER //

CREATE TRIGGER write_log_on_insert_into_users AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO 
	logs 
	(table_name, prim_key_value, name_value, created_at)
	VALUES
	('users', NEW.id, NEW.name, NEW.created_at);
END//

DELIMITER ;

DROP TRIGGER write_log_on_insert_into_catalogs;

-- создаем триггер на вставку записи в лог при добавлении новой записи в таблицу catalogs
DELIMITER //

CREATE TRIGGER write_log_on_insert_into_catalogs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO 
	logs 
	(table_name, prim_key_value, name_value, created_at)
	VALUES
	('catalogs', NEW.id, NEW.name, NOW());
END//

DROP TRIGGER write_log_on_insert_into_products;

-- создаем триггер на вставку записи в лог при добавлении новой записи в таблицу products
DELIMITER //

CREATE TRIGGER write_log_on_insert_into_products AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO 
	logs 
	(table_name, prim_key_value, name_value, created_at)
	VALUES
	('products', NEW.id, NEW.name, NEW.created_at);
END//

DELIMITER ;

SHOW TRIGGERS;

DESC users;
SELECT * FROM users;
INSERT INTO
users 
(name, birthday_at)
VALUES
('Кира', '2001-09-16');

INSERT INTO 
products 
(name, description, price, catalog_id) 
VALUES 
('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', '6040.00', 2);

INSERT INTO 
catalogs 
(name) 
VALUES 
('Ноутбуки');

SELECT * FROM logs; -- после трех вставленных в таблицы записей в таблице логов добавилось 3 записи

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DROP PROCEDURE create_million_users;

DELIMITER //

CREATE PROCEDURE create_million_users(IN total BIGINT, IN portion INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE i_name VARCHAR(255);
	DECLARE i_birthday_at DATE;

	START TRANSACTION;
	WHILE i < total DO
		SET i_name = CONCAT(SUBSTR(MD5(RAND()), 1, 10)); -- рандомное имя
		SET i_birthday_at = NOW() 
			- INTERVAL FLOOR(RAND() * 50) YEAR 
			- INTERVAL FLOOR(RAND() * 12) MONTH
    		- INTERVAL FLOOR(RAND() * 28) DAY; -- рандомный день рождения
	
		IF NOT EXISTS (SELECT id FROM users WHERE name = i_name OR birthday_at = i_birthday_at) THEN
			INSERT INTO users (name, birthday_at)
			VALUES (i_name, i_birthday_at); -- если не найден такой пользователь, вставляем данные
			SET i = i + 1; -- увеличиваем счетчик
		END IF;
	
		IF i % portion = 0 THEN
			COMMIT; -- запись порции данных
			START TRANSACTION; -- начало новой транзакции
		END IF;
	END WHILE;
	COMMIT; -- запись остатка
END//

DELIMITER ;

CALL create_million_users(1000000, 10000);

/*
Практическое задание по теме “NoSQL”
1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
*/

-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
redis-cli
SADD ip '127.0.0.0' '255.255.8.112' '148.49.22.33' -- добавляем IP в коллекцию
SMEMBERS ip -- список IP в коллекции
SCARD ip -- количество IP в коллекции

-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу
-- и наоброт, поиск электронного адреса пользователя по его имени.

set some_email@someserver.ru some_name -- для примера задаем пару имя-email в обе стороны
set some_name some_email@someserver.ru

get some_email@someserver.ru -- результат выполнения "some_name" 
get some_name -- результат выполнения "some_email@someserver.ru"


-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

-- Таблица разделов каталога catalogs
use catalogs
-- вставка одной строки
db.catalogs.insert({"name": "Клавиатуры"})
-- вставка сразу нескольких строк
db.catalogs.insertMany([
	{"name": "Системные блоки"}, 
	{"name": "Мониторы"}, 
	{"name": "Ноутбуки"}, 
	{"name": "Принтеры"}])

-- Таблица товарных позиций products
use products
-- вставка одной строки
db.products.insert({"name": "Apple Magic Keyboard", "description": "Bluetooth-клавиатура для устройств Apple", "price": "5999.00", "catalog_id": "10", "created_at": new Date(), "updated_at": new Date()}) 
-- вставка сразу нескольких строк
db.products.insertMany([
	{"name": "Монитор Dell 27 дюймов", "description": "Широкоформатный монитор", "price": "13000.00", "catalog_id": "8", "created_at": new Date(), "updated_at": new Date()},
	{"name": "Принтер Ricoh-FX115", "description": "Черно-белый лазерный принтер", "price": "8700.00", "catalog_id": "11", "created_at": new Date(), "updated_at": new Date()},
	{"name": "WD Passport 1 Tb", "description": "Внешний USB-накопитель", "price": "5200.00", "catalog_id": "1", "created_at": new Date(), "updated_at": new Date()}])

