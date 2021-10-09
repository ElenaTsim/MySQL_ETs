SHOW DATABASES;
USE sample;
SHOW tables; 
DROP DATABASE sample;
CREATE DATABASE sample;

/*
Практическое задание по теме “Транзакции, переменные, представления”
1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
3. (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/

-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION; -- начинаем транзакцию

	SELECT 
		* 
	FROM 
		shop.users 
	WHERE id = 1; -- убедимся, что пользователь с id = 1 есть в основной БД

	TRUNCATE TABLE sample.users; -- очистим таблицу из учебной БД, чтобы была пустая
	
	INSERT INTO sample.users 
		(id, name, birthday_at, created_at, updated_at)
	SELECT 
		id, name, birthday_at, created_at, updated_at
	FROM 
		shop.users 
	WHERE 
		id = 1; -- вставлям в таблицу учебной БД запись о пользователе с id = 1 из основной БД
	
	SELECT 
		* 
	FROM 
		sample.users 
	WHERE id = 1; -- убедимся, что пользователь с id = 1 добавлен
	
	DELETE FROM 
		shop.users 
	WHERE 
		id = 1; -- удаляем данные пользователя с id = 1 из основной БД

COMMIT; -- завершаем транзакцию

SELECT 
	* 
FROM 
	shop.users; -- убедиться, что пользователь с id = 1 отсутствует в основной БД

INSERT INTO 
	shop.users 
VALUES 
	(1,'Геннадий','1990-10-05','2021-09-20 18:18:53','2021-09-20 18:18:53'); -- Вернем на место запись о пользователе с id = 1 , еще пригодится


-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.

USE shop;

CREATE OR REPLACE VIEW 
	product_view AS
SELECT 
	p.id AS product_id,
	p.name AS product_name,
	c.name AS catalog_name
FROM 
	products p 
LEFT JOIN 
	catalogs c ON 
	(
		p.catalog_id = c.id 
	)
ORDER BY 
	p.id;

SELECT * FROM product_view;

/*
Практическое задание по теме “Хранимые процедуры и функции, триггеры"
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

*/

-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

USE shop;

SET GLOBAL log_bin_trust_function_creators = 1; -- пришлось добавить эту строку из-за ошибки ERROR: Error 1418: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)

DELIMITER //

CREATE FUNCTION hello ()
RETURNS TINYTEXT NOT DETERMINISTIC
BEGIN
	DECLARE current_hour INT;
	SET current_hour = HOUR(NOW());
	CASE
		WHEN current_hour BETWEEN 6 AND 11 THEN 
			RETURN "Доброе утро!"; 
		WHEN current_hour BETWEEN 12 AND 17 THEN 
			RETURN "Добрый день!";
		WHEN current_hour BETWEEN 18 AND 23 THEN 
			RETURN "Добрый вечер!";
		WHEN current_hour BETWEEN 0 AND 5 THEN 
			RETURN "Доброй ночи!";
	END CASE;
END//

SELECT HOUR(NOW()), hello ()//

DELIMITER ;
SELECT hello ();

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop;

DELIMITER //


-- создаем триггер на вставку
CREATE TRIGGER check_name_and_description_on_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Название и описание продукта не заданы. Должно быть заполнено хотя бы одно поле.';
	END IF;
END//

DELIMITER ;

INSERT INTO products 
	(name, description, price, catalog_id)
VALUES
	(NULL, NULL, 1100.00, 1); -- вызывает ошибку
	
INSERT INTO products 
	(name, description, price, catalog_id)
VALUES
	('WD Passport 512 Gb', NULL, 1100.00, 1); -- вставляется корректно
	
INSERT INTO products 
	(name, description, price, catalog_id)
VALUES
	(NULL, 'Внешний жесткий диск на 512 Гб', 1100.00, 1); -- вставляется корректно

SELECT * FROM products;
SELECT * FROM catalogs;
DELETE FROM products WHERE id = 8;

DELIMITER //

-- создаем триггер на обновление
CREATE TRIGGER check_name_and_description_on_update BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Название и описание продукта не заданы. Должно быть заполнено хотя бы одно поле.';
	END IF;
END//

DELIMITER ;

UPDATE products 
	SET 
		name = NULL,
		description = NULL
WHERE 
	id = 12; -- вызывает ошибку
	
UPDATE products 
	SET 
		name = 'WD Passport 512 Gb',
		description = NULL
WHERE 
	id = 13; -- обновляется корректно

UPDATE products 
	SET 
		name = NULL,
		description = 'Внешний жесткий диск на 512 Гб'
WHERE 
	id = 12; -- обновляется корректно
	


