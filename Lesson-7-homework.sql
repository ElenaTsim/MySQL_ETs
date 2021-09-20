/*
1. ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
3. (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). ���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.

*/

USE shop;

-- 1. ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.

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

-- 2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.

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

-- 3. (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). 
-- ���� from, to � label �������� ���������� �������� �������, ���� name � �������. 
-- �������� ������ ������ flights � �������� ���������� �������.

-- ������� ������� � ��������� ������� �� �������
CREATE TABLE flights (
  id SERIAL PRIMARY KEY COMMENT '�����',
  `from` VARCHAR(50) NOT NULL COMMENT '������',
  `to` VARCHAR(50) NOT NULL COMMENT '����'
) COMMENT '�����';

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
  `label` VARCHAR(50) NOT NULL COMMENT '�����������',
  `name` VARCHAR(50) NOT NULL COMMENT '�������� ������'	
) COMMENT '������';

INSERT INTO cities 
	(id, `label`, `name`) 
VALUES 
	(1, 'moscow', '������'),
	(2, 'irkutsk', '�������'),
	(3, 'novgorod', '��������'),
	(4, 'kazan', '������'),
	(5, 'omsk', '����')
;

SELECT * FROM cities;

-- ���������� ����� � ���������� ������� ��-������

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

