SHOW DATABASES;
USE sample;
SHOW tables; 
DROP DATABASE sample;
CREATE DATABASE sample;

/*
������������ ������� �� ���� �����������, ����������, ��������������
1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.
2. �������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs.
3. (�� �������) ����� ������� ������� � ����������� ����� created_at. � ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' � 2018-08-17. ��������� ������, ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1, ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.
4. (�� �������) ����� ������� ����� ������� � ����������� ����� created_at. �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.
*/

-- 1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
-- ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.

START TRANSACTION; -- �������� ����������

	SELECT 
		* 
	FROM 
		shop.users 
	WHERE id = 1; -- ��������, ��� ������������ � id = 1 ���� � �������� ��

	TRUNCATE TABLE sample.users; -- ������� ������� �� ������� ��, ����� ���� ������
	
	INSERT INTO sample.users 
		(id, name, birthday_at, created_at, updated_at)
	SELECT 
		id, name, birthday_at, created_at, updated_at
	FROM 
		shop.users 
	WHERE 
		id = 1; -- �������� � ������� ������� �� ������ � ������������ � id = 1 �� �������� ��
	
	SELECT 
		* 
	FROM 
		sample.users 
	WHERE id = 1; -- ��������, ��� ������������ � id = 1 ��������
	
	DELETE FROM 
		shop.users 
	WHERE 
		id = 1; -- ������� ������ ������������ � id = 1 �� �������� ��

COMMIT; -- ��������� ����������

SELECT 
	* 
FROM 
	shop.users; -- ���������, ��� ������������ � id = 1 ����������� � �������� ��

INSERT INTO 
	shop.users 
VALUES 
	(1,'��������','1990-10-05','2021-09-20 18:18:53','2021-09-20 18:18:53'); -- ������ �� ����� ������ � ������������ � id = 1 , ��� ����������


-- 2. �������� �������������, ������� ������� �������� name �������� ������� �� ������� products 
-- � ��������������� �������� �������� name �� ������� catalogs.

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
������������ ������� �� ���� ��������� ��������� � �������, ��������"
1. �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".
2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. ��������� ����������� ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.
3. (�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������. ������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����. ����� ������� FIBONACCI(10) ������ ���������� ����� 55.

*/

-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. 
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", 
-- � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", 
-- � 18:00 �� 00:00 � "������ �����", 
-- � 00:00 �� 6:00 � "������ ����".

USE shop;

SET GLOBAL log_bin_trust_function_creators = 1; -- �������� �������� ��� ������ ��-�� ������ ERROR: Error 1418: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)

DELIMITER //

CREATE FUNCTION hello ()
RETURNS TINYTEXT NOT DETERMINISTIC
BEGIN
	DECLARE current_hour INT;
	SET current_hour = HOUR(NOW());
	CASE
		WHEN current_hour BETWEEN 6 AND 11 THEN 
			RETURN "������ ����!"; 
		WHEN current_hour BETWEEN 12 AND 17 THEN 
			RETURN "������ ����!";
		WHEN current_hour BETWEEN 18 AND 23 THEN 
			RETURN "������ �����!";
		WHEN current_hour BETWEEN 0 AND 5 THEN 
			RETURN "������ ����!";
	END CASE;
END//

SELECT HOUR(NOW()), hello ()//

DELIMITER ;
SELECT hello ();

-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
-- ��������� ����������� ����� ����� ��� ���� �� ���. 
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. 
-- ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

USE shop;

DELIMITER //


-- ������� ������� �� �������
CREATE TRIGGER check_name_and_description_on_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = '�������� � �������� �������� �� ������. ������ ���� ��������� ���� �� ���� ����.';
	END IF;
END//

DELIMITER ;

INSERT INTO products 
	(name, description, price, catalog_id)
VALUES
	(NULL, NULL, 1100.00, 1); -- �������� ������
	
INSERT INTO products 
	(name, description, price, catalog_id)
VALUES
	('WD Passport 512 Gb', NULL, 1100.00, 1); -- ����������� ���������
	
INSERT INTO products 
	(name, description, price, catalog_id)
VALUES
	(NULL, '������� ������� ���� �� 512 ��', 1100.00, 1); -- ����������� ���������

SELECT * FROM products;
SELECT * FROM catalogs;
DELETE FROM products WHERE id = 8;

DELIMITER //

-- ������� ������� �� ����������
CREATE TRIGGER check_name_and_description_on_update BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = '�������� � �������� �������� �� ������. ������ ���� ��������� ���� �� ���� ����.';
	END IF;
END//

DELIMITER ;

UPDATE products 
	SET 
		name = NULL,
		description = NULL
WHERE 
	id = 12; -- �������� ������
	
UPDATE products 
	SET 
		name = 'WD Passport 512 Gb',
		description = NULL
WHERE 
	id = 13; -- ����������� ���������

UPDATE products 
	SET 
		name = NULL,
		description = '������� ������� ���� �� 512 ��'
WHERE 
	id = 12; -- ����������� ���������
	


