/*
������������ ������� �� ���� ������������ ��������
1. �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������, ������������� ���������� ����� � ���������� ���� name.
2. (�� �������) �������� SQL-������, ������� �������� � ������� users ������� �������.
*/

-- 1. �������� ������� logs ���� Archive. 
-- ����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������, ������������� ���������� ����� � ���������� ���� name.

USE shop;

CREATE TABLE logs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������', 
	table_name ENUM('users', 'catalogs', 'products') COMMENT '��� �������',
	prim_key_value BIGINT COMMENT '������������� ���������� �����',
	name_value VARCHAR(255) COMMENT '�������� ���� name'
) ENGINE=Archive COMMENT '������� �����';

DROP TRIGGER write_log_on_insert_into_users;

-- ������� ������� �� ������� ������ � ��� ��� ���������� ����� ������ � ������� users
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

-- ������� ������� �� ������� ������ � ��� ��� ���������� ����� ������ � ������� catalogs
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

-- ������� ������� �� ������� ������ � ��� ��� ���������� ����� ������ � ������� products
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
('����', '2001-09-16');

INSERT INTO 
products 
(name, description, price, catalog_id) 
VALUES 
('MSI B250M GAMING PRO', '����������� ����� MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', '6040.00', 2);

INSERT INTO 
catalogs 
(name) 
VALUES 
('��������');

SELECT * FROM logs; -- ����� ���� ����������� � ������� ������� � ������� ����� ���������� 3 ������

-- 2. (�� �������) �������� SQL-������, ������� �������� � ������� users ������� �������.

DROP PROCEDURE create_million_users;

DELIMITER //

CREATE PROCEDURE create_million_users(IN total BIGINT, IN portion INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE i_name VARCHAR(255);
	DECLARE i_birthday_at DATE;

	START TRANSACTION;
	WHILE i < total DO
		SET i_name = CONCAT(SUBSTR(MD5(RAND()), 1, 10)); -- ��������� ���
		SET i_birthday_at = NOW() 
			- INTERVAL FLOOR(RAND() * 50) YEAR 
			- INTERVAL FLOOR(RAND() * 12) MONTH
    		- INTERVAL FLOOR(RAND() * 28) DAY; -- ��������� ���� ��������
	
		IF NOT EXISTS (SELECT id FROM users WHERE name = i_name OR birthday_at = i_birthday_at) THEN
			INSERT INTO users (name, birthday_at)
			VALUES (i_name, i_birthday_at); -- ���� �� ������ ����� ������������, ��������� ������
			SET i = i + 1; -- ����������� �������
		END IF;
	
		IF i % portion = 0 THEN
			COMMIT; -- ������ ������ ������
			START TRANSACTION; -- ������ ����� ����������
		END IF;
	END WHILE;
	COMMIT; -- ������ �������
END//

DELIMITER ;

CALL create_million_users(1000000, 10000);

/*
������������ ������� �� ���� �NoSQL�
1. � ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.
2. ��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������ � ��������, ����� ������������ ������ ������������ �� ��� �����.
3. ����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.
*/

-- 1. � ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.
redis-cli
SADD ip '127.0.0.0' '255.255.8.112' '148.49.22.33' -- ��������� IP � ���������
SMEMBERS ip -- ������ IP � ���������
SCARD ip -- ���������� IP � ���������

-- 2. ��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������
-- � �������, ����� ������������ ������ ������������ �� ��� �����.

set some_email@someserver.ru some_name -- ��� ������� ������ ���� ���-email � ��� �������
set some_name some_email@someserver.ru

get some_email@someserver.ru -- ��������� ���������� "some_name" 
get some_name -- ��������� ���������� "some_email@someserver.ru"


-- 3. ����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.

-- ������� �������� �������� catalogs
use catalogs
-- ������� ����� ������
db.catalogs.insert({"name": "����������"})
-- ������� ����� ���������� �����
db.catalogs.insertMany([
	{"name": "��������� �����"}, 
	{"name": "��������"}, 
	{"name": "��������"}, 
	{"name": "��������"}])

-- ������� �������� ������� products
use products
-- ������� ����� ������
db.products.insert({"name": "Apple Magic Keyboard", "description": "Bluetooth-���������� ��� ��������� Apple", "price": "5999.00", "catalog_id": "10", "created_at": new Date(), "updated_at": new Date()}) 
-- ������� ����� ���������� �����
db.products.insertMany([
	{"name": "������� Dell 27 ������", "description": "��������������� �������", "price": "13000.00", "catalog_id": "8", "created_at": new Date(), "updated_at": new Date()},
	{"name": "������� Ricoh-FX115", "description": "�����-����� �������� �������", "price": "8700.00", "catalog_id": "11", "created_at": new Date(), "updated_at": new Date()},
	{"name": "WD Passport 1 Tb", "description": "������� USB-����������", "price": "5200.00", "catalog_id": "1", "created_at": new Date(), "updated_at": new Date()}])

