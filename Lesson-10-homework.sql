/*
 * �������� ������: ��������-������� lushrussia.ru 
 */

DROP DATABASE lush;
CREATE DATABASE IF NOT EXISTS lush;
USE lush;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� �������',
	name VARCHAR(150) UNIQUE NOT NULL COMMENT '������������ �������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'	
) COMMENT '������� �������� ��������';

DROP TABLE IF EXISTS catalog_tree;
CREATE TABLE catalog_tree (
	catalog_id INT UNSIGNED NOT NULL COMMENT '������ �� ������',
	parent_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������ ������', -- ��� �������� �������� ������ catalog_id = parent_id
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������',
    PRIMARY KEY (catalog_id, parent_id) COMMENT '��������� ��������� ����'
) COMMENT '������ �������� ��������';

ALTER TABLE catalog_tree ADD CONSTRAINT catalog_tree_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs(id); -- 1:N
ALTER TABLE catalog_tree ADD CONSTRAINT catalog_tree_parent_id FOREIGN KEY (parent_id) REFERENCES catalogs(id); -- 1:N

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������������',
	first_name VARCHAR(100) NOT NULL COMMENT '��� ������������',
    last_name VARCHAR(100) NOT NULL COMMENT '������� ������������',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email ������������', 
    phone VARCHAR(12) NOT NULL UNIQUE COMMENT '����� �������� ������������',  
    city VARCHAR(50) NOT NULL COMMENT '�����',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT '������� �������������';

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT '������ �� ������������',
	login_email VARCHAR(50) COMMENT 'Email ��� �����',
	login_phone VARCHAR(50) COMMENT '������� ��� �����',
    passw VARCHAR(20) NOT NULL COMMENT '������ ������������',
	country VARCHAR(100) COMMENT '������ ����������',    
	city VARCHAR(100) COMMENT '����� ����������',
	street VARCHAR(100) NOT NULL COMMENT '�����',
	house INT NOT NULL COMMENT '���',
	corp INT COMMENT '������/��������',
	apartment INT COMMENT '��������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT '������� �������� ������������� � �������� ��������';

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:1

DROP TABLE IF EXISTS products;
CREATE TABLE products (
 	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ��������',
 	name VARCHAR(255) COMMENT '�������� ��������',
  	description TEXT COMMENT '�������� ��������',
  	volume INT COMMENT '����� ��� ��� ������� ��������',
  	price DECIMAL (11,2) COMMENT '���� ��������',
  	catalog_id INT UNSIGNED NOT NULL COMMENT '������ �� ������ ��������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT '������� ���������';

ALTER TABLE products ADD CONSTRAINT products_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs(id); -- 1:N
ALTER TABLE products ADD COLUMN rating DECIMAL (5,1) UNSIGNED COMMENT '������� ��������';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
  	name VARCHAR(255) COMMENT '�������� ������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT = '������� �������';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� �������',
  	storehouse_id INT UNSIGNED NOT NULL COMMENT '������ �� �����',
  	product_id INT UNSIGNED NOT NULL COMMENT '������ �� �������',
  	value INT UNSIGNED COMMENT '����� �������� ������� �� ������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT = '������� ������� ��������� �� ������';

ALTER TABLE storehouses_products ADD CONSTRAINT storehouses_products_storehouse_id FOREIGN KEY (storehouse_id) REFERENCES storehouses(id); -- 1:N
ALTER TABLE storehouses_products ADD CONSTRAINT storehouses_products_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	user_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������', 
	summa DECIMAL (11,2) COMMENT '����� ������',
	ord_status ENUM ('Created', 'In progress', 'Completed', 'Cancelled') COMMENT '������ ������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT = '������� ��������-�������';

ALTER TABLE orders ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  	order_id INT UNSIGNED NOT NULL COMMENT '������ �� �����',
  	product_id INT UNSIGNED NOT NULL COMMENT '������ �� �������',
  	quantity INT UNSIGNED NOT NULL DEFAULT 1 COMMENT '���������� ���������� ���������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������',
    PRIMARY KEY (order_id, product_id) COMMENT '��������� ��������� ����'
) COMMENT = '������� ��������� � �������';

ALTER TABLE orders_products ADD CONSTRAINT orders_products_order_id FOREIGN KEY (order_id) REFERENCES orders(id); -- 1:N
ALTER TABLE orders_products ADD CONSTRAINT orders_products_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	user_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������', 
  	product_id INT UNSIGNED NOT NULL COMMENT '������ �� �������',
  	rating ENUM('1', '2', '3', '4', '5') COMMENT '������ �� 5-�������� �����',
  	comment_text TEXT NOT NULL COMMENT '����� ������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������',
    PRIMARY KEY (user_id, product_id) COMMENT '��������� ��������� ����'
) COMMENT '������� ������� � ���������';

ALTER TABLE comments ADD CONSTRAINT comments_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N
ALTER TABLE comments ADD CONSTRAINT comments_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites (
	user_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������', 
  	product_id INT UNSIGNED NOT NULL COMMENT '������ �� �������',
  	is_favorite BIT COMMENT '������ ������� ��������� ��������� - ���� ������, ���� ����� ����',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������',
    PRIMARY KEY (user_id, product_id) COMMENT '��������� ��������� ����'
) COMMENT '������� ��������� ��������� �������������';

ALTER TABLE favorites ADD CONSTRAINT favorites_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N
ALTER TABLE favorites ADD CONSTRAINT favorites_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

CREATE TABLE images (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
	filename VARCHAR(255) NOT NULL COMMENT '������ ���� � �����',
    metadata JSON NOT NULL COMMENT '���������� ����� (�������������� ��������� ��������)',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT '������� �����������';

DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
  	head VARCHAR(255) NOT NULL COMMENT '��������� ������',
  	body TEXT NOT NULL COMMENT '����� ������',
  	catalog_id INT UNSIGNED COMMENT '������ �� ������ ��������, � ������� ����� ����� ������',
  	product_id INT UNSIGNED COMMENT '������ �� �������, � �������� �������� ����� ������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT '������� ������ � ���������, ������������ � �������� � ��������� ���������';

ALTER TABLE articles ADD CONSTRAINT articles_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs(id); -- 1:N
ALTER TABLE articles ADD CONSTRAINT articles_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ���� �������',
	name VARCHAR(10) UNIQUE NOT NULL COMMENT '������������ ���� �������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'	
) COMMENT '������� ����� ���������, ��� ����� �������������� �����������';

CREATE TABLE image_usage (
	image_id INT UNSIGNED NOT NULL COMMENT '������ �� �����������',
 	target_id INT UNSIGNED NOT NULL COMMENT '������ �� id �������, � �������� ��������� �����������',
 	target_type_id INT UNSIGNED NOT NULL COMMENT '������ �� ��� �������, � �������� ��������� �����������',
 	PRIMARY KEY (image_id, target_id, target_type_id) COMMENT '��������� ��������� ����',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'	
) COMMENT '������� ������ �� �������� � ��������, ������� � ��������� ���������';

ALTER TABLE image_usage ADD CONSTRAINT image_usage_image_id FOREIGN KEY (image_id) REFERENCES images(id); -- 1:N
ALTER TABLE image_usage ADD CONSTRAINT image_usage_target_type_id FOREIGN KEY (target_type_id) REFERENCES target_types(id); -- 1:N


-- filldb ����� ����� ��������, ��������� ������ ������
-- ������� ��������
INSERT INTO 
	catalogs
VALUES 
	(1, '����� � ���', NOW(), NOW()),
	(2, '����� ��� �����', NOW(), NOW()),
	(3, '���� ��� �����', NOW(), NOW()),
	(4, '���� ��� ����', NOW(), NOW()),
	(5, '������', NOW(), NOW()),
	(6, '�������', NOW(), NOW()),
	(7, '������������ ��� �����', NOW(), NOW()),
	(8, '�����, ����� � ����� ��� �����', NOW(), NOW()),
	(9, '����', NOW(), NOW()),
	(10, '����� ��� ����', NOW(), NOW()),
	(11, '��������� ��������', NOW(), NOW()),
	(12, '�����', NOW(), NOW());

-- ������ ��������
INSERT INTO
	catalog_tree
VALUES 
	(1, 1, NOW(), NOW()),
	(2, 1, NOW(), NOW()),
	(3, 1, NOW(), NOW()),
	(4, 1, NOW(), NOW()),
	(5, 5, NOW(), NOW()),
	(6, 5, NOW(), NOW()),
	(7, 5, NOW(), NOW()),
	(8, 5, NOW(), NOW()),
	(9, 9, NOW(), NOW()),
	(10, 9, NOW(), NOW()),
	(11, 9, NOW(), NOW()),
	(12, 9, NOW(), NOW());
	
-- ������������
INSERT INTO 
	users
VALUES 
	(1, '���������', '��������', 'val_serg@mail.ru', '+79267834566', '������', NOW(), NOW()),
	(2, '�����', '�������', 'lena345@yandex.ru', '+79857009090', '�����-���������', NOW(), NOW()),
	(3, '�����', '������', 'irina.1985@mail.ru', '+79030901123', '�������', NOW(), NOW()),
	(4, '��������', '��������', 'catalina_ma@me.com', '+79254343434', '������', NOW(), NOW()),
	(5, '�������', '�������', 'natapav@yandex.ru', '+79061154567', '�����-���������', NOW(), NOW()),
	(6, '���������', '�������', '4951329087@gmail.com', '+79057771124', '�������', NOW(), NOW()),
	(7, '�����', '���������', 'dmitrieva.mv@mail.ru', '+79104535432', '�����', NOW(), NOW()),
	(8, '�����', '��������', 'sofi_le@mail.ru', '+79110906543', '�����', NOW(), NOW()),
	(9, '������', '��������', 'sergey_savitky@bk.ru', '+79129066723', '������', NOW(), NOW()),
	(10, '�����', '�������', 'petrova_olga@gmail.com', '+79161090909', '������', NOW(), NOW());

-- �������
INSERT INTO 
	profiles 
VALUES 
	(1, 'val_serg@mail.ru', '+79267834566', 'tetge757', '������', '������', '��������� ��������', 23, 1, 115, NOW(), NOW()),
	(2, 'lena345@yandex.ru', '+79857009090', '08363636', '������', '�����-���������', '������� ��������', 98, NULL, 87, NOW(), NOW()),
	(3, 'irina.1985@mail.ru', '+79030901123', 'TrTr_*&7Q', '������', '�������', '��������', 5, 2, 34, NOW(), NOW()),
	(4, 'catalina_ma@me.com', '+79254343434', '123456', '������', '������', '�������� ��������', 26, NULL, NULL, NOW(), NOW()),
	(5, 'natapav@yandex.ru', '+79061154567', 'Qwerty123', '������', '�����-���������', '����� �������', 12, NULL, 45, NOW(), NOW()),
	(6, '4951329087@gmail.com', '+79057771124', '01011980', '������', '�������', '������', 2, 1, 10, NOW(), NOW()),
	(7, 'dmitrieva.mv@mail.ru', '+79104535432', 'Nhjv,jwbg5', '������', '���������', '����������������', 30, NULL, NULL, NOW(), NOW()),
	(8, 'sofi_le@mail.ru', '+79110906543', 'Sonya_2305', '������', '�����', '�������', 3, NULL, 30, NOW(), NOW()),
	(9, 'sergey_savitky@bk.ru', '+79129066723', 'RgnThm678', '������', '������', '���������', 76, 3, 18, NOW(), NOW()),
	(10, 'petrova_olga@gmail.com', '+79161090909', 'LushRussia1', '������', '������', '1905 ����', 7, 1, NULL, NOW(), NOW());
	
-- ������
DESC storehouses;
INSERT INTO 
	storehouses 
VALUES 
	(1, '����� ������', NOW(), NOW()),
	(2, '����� ��������', NOW(), NOW()),
	(3, '����� ��������', NOW(), NOW());

-- ��������
DESC products;
INSERT INTO 
	products 
VALUES 
	(1, '�������', '���� ��� ���� � �������� ����', 250, 1100.00, 4, NOW(), NOW(), 4.7),
	(2, '�������', '���������� �������� ��� ��-�������', 100, 1000.00, 7, NOW(), NOW(), 4.3),
	(3, '���� ��� ������', '������� � �����', 500, 1900.00, 6, NOW(), NOW(), 3.9),
	(4, '������������ ����������', '���� ��� �������������� ���� ����', 50, 2360.00, 12, NOW(), NOW(), 4.5),
	(5, '����', '������ ����� � ���������������', 75, 700.00, 12, NOW(), NOW(), 4.5),
	(6, '��������', '����� ��� ���������� ���� ����', 75, 700.00, 12, NOW(), NOW(), 3.5),
	(7, '�������', '������� ������� ��� ����� �����', 1, 750.00, 6, NOW(), NOW(), 4.4),
	(8, '������ �����', '����� ��� ����� � ���� ������', 225, 1400.00, 8, NOW(), NOW(), 5.0),
	(9, 'Coal face', '������ ��������� ��������', 1, 800.00, 11, NOW(), NOW(), 5.0),
	(10, '��������� ������', '����� ��� ����� � ������� ��������� � �����-������', 1, 720.00, 2, NOW(), NOW(), 4.5);

-- �����������
INSERT INTO 
	images 
	(filename, metadata) 
VALUES 
(
	CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10)),
    CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
);

-- ���� ��������, ���������� �����������
INSERT INTO 
	target_types 
	(id, name) 
VALUES 
	(1, 'catalogs'),
	(2, 'products'),
	(3, 'articles'); 

-- ������
DESC articles;
INSERT INTO 
	articles 
	(id, head, body, catalog_id, product_id) 
VALUES 
	(1, '���� ������������ ������ �������� � ����� ������', '��� ���������� �� �������� �������� � ���������� naked care', 2, NULL),
	(2, '������������� �������', '������ �������������������� �������� ����� ����� ��������� � ���������� �����������', 6, 7),
	(3, '���', '��� �������� �������� ������������� ������������� ������� ��� �����', 5, NULL),
	(4, '��������� ������', '��� ������� ���� ��������� ������� ��������� ������', 9, 6),
	(5, '������� ���� ��� ����', '������� ���� ��� ���� �� �������� ������� ������', 4, NULL);
	
-- ������
DESC orders;
INSERT INTO 
	orders 
	(id, user_id, summa, ord_status) 
VALUES 
	(1, 2, 5383.00, 'Created'),
	(2, 4, 1225.00, 'In progress'),
	(3, 1, 12950.00, 'Completed'),
	(4, 9, 4678.00, 'Cancelled'),
	(5, 2, 2999.00, 'In progress'),
	(6, 5, 4625.00, 'Created'),
	(7, 1, 3900.00, 'Completed'),
	(8, 7, 7600.00, 'Created'),
	(9, 10, 8432.00, 'Created'),
	(10, 2, 4530.00, 'Completed');
	
-- �������� � �������
DESC orders_products;
INSERT INTO 
	orders_products 
	(order_id, product_id, quantity) 
VALUES 
	(1, 2, 1),
	(1, 5, 1),
	(2, 4, 2),
	(3, 1, 1),
	(4, 9, 2),
	(5, 2, 1),
	(6, 5, 1),
	(7, 1, 3),
	(8, 7, 1),
	(9, 10, 4),
	(10, 2, 2);
	
-- ��������� �������� �������������
DESC favorites;
INSERT INTO 
	favorites 
	(user_id, product_id, is_favorite) 
VALUES 
	(1, 2, 1),
	(1, 5, 1),
	(2, 4, 0),
	(3, 1, 1),
	(4, 9, 0),
	(5, 2, 1),
	(6, 5, 1),
	(7, 1, 1),
	(8, 7, 1),
	(9, 10, 0),
	(10, 2, 1);
	
-- ������ ��������� �� �������
DESC storehouses_products;
INSERT INTO 
	storehouses_products 
	(id, storehouse_id, product_id, value) 
VALUES 
	(1, 1, 2, 10),
	(2, 1, 5, 15),
	(3, 1, 4, 20),
	(4, 1, 1, 12),
	(5, 2, 9, 10),
	(6, 2, 2, 7),
	(7, 2, 5, 19),
	(8, 3, 1, 1),
	(9, 3, 7, 16),
	(10, 3, 2, 8);
	
-- ������ �� �����������
DESC image_usage;
INSERT INTO 
	image_usage 
	(image_id, target_id, target_type_id) 
VALUES 
	(1, 1, 2),
	(2, 10, 3),
	(3, 1, 1),
	(4, 8, 1),
	(5, 7, 2),
	(6, 2, 3),
	(7, 4, 1),
	(8, 3, 2),
	(9, 3, 3),
	(10, 6, 2);
	
-- ������ � ���������
DESC comments;
INSERT INTO 
	comments 
	(user_id, product_id, rating, comment_text) 
VALUES 
	(1, 1, 2, '������ ������� - �� �������� ��������'),
	(2, 10, 5, '�������� ������� - ����� ����������'),
	(3, 1, 4, '�������'),
	(4, 8, 3, '��� ����'),
	(5, 7, 2, '���������� �� �������'),
	(6, 2, 5, '���������� ��������'),
	(7, 4, 5, '����� �������'),
	(8, 3, 2, '����� ������ ����'),
	(9, 3, 3, '�� ���� �� ����'),
	(10, 6, 4, '�� ������� �� �����');
	
