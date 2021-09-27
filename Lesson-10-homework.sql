/*
 * Курсовой проект: интернет-магазин lushrussia.ru 
 */

DROP DATABASE lush;
CREATE DATABASE IF NOT EXISTS lush;
USE lush;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор раздела',
	name VARCHAR(150) UNIQUE NOT NULL COMMENT 'Наименование раздела',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'	
) COMMENT 'Таблица разделов каталога';

DROP TABLE IF EXISTS catalog_tree;
CREATE TABLE catalog_tree (
	catalog_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на раздел',
	parent_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на родительский раздел', -- для разделов верхнего уровня catalog_id = parent_id
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
    PRIMARY KEY (catalog_id, parent_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Дерево разделов каталога';

ALTER TABLE catalog_tree ADD CONSTRAINT catalog_tree_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs(id); -- 1:N
ALTER TABLE catalog_tree ADD CONSTRAINT catalog_tree_parent_id FOREIGN KEY (parent_id) REFERENCES catalogs(id); -- 1:N

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор пользователя',
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя', 
    phone VARCHAR(12) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',  
    city VARCHAR(50) NOT NULL COMMENT 'Город',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица пользователей';

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Ссылка на пользователя',
	login_email VARCHAR(50) COMMENT 'Email для входа',
	login_phone VARCHAR(50) COMMENT 'Телефон для входа',
    passw VARCHAR(20) NOT NULL COMMENT 'Пароль пользователя',
	country VARCHAR(100) COMMENT 'Страна проживания',    
	city VARCHAR(100) COMMENT 'Город проживания',
	street VARCHAR(100) NOT NULL COMMENT 'Улица',
	house INT NOT NULL COMMENT 'Дом',
	corp INT COMMENT 'Корпус/строение',
	apartment INT COMMENT 'Квартира',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица профилей пользователей с адресами доставки';

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:1

DROP TABLE IF EXISTS products;
CREATE TABLE products (
 	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор продукта',
 	name VARCHAR(255) COMMENT 'Название продукта',
  	description TEXT COMMENT 'Описание продукта',
  	volume INT COMMENT 'Объем или вес единицы продукта',
  	price DECIMAL (11,2) COMMENT 'Цена продукта',
  	catalog_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на раздел каталога',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица продуктов';

ALTER TABLE products ADD CONSTRAINT products_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs(id); -- 1:N
ALTER TABLE products ADD COLUMN rating DECIMAL (5,1) UNSIGNED COMMENT 'Рейтинг продукта';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор склада',
  	name VARCHAR(255) COMMENT 'Название склада',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT = 'Таблица складов';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор позиции',
  	storehouse_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на склад',
  	product_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на продукт',
  	value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT = 'Таблица запасов продуктов на складе';

ALTER TABLE storehouses_products ADD CONSTRAINT storehouses_products_storehouse_id FOREIGN KEY (storehouse_id) REFERENCES storehouses(id); -- 1:N
ALTER TABLE storehouses_products ADD CONSTRAINT storehouses_products_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор заказа',
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя', 
	summa DECIMAL (11,2) COMMENT 'Сумма заказа',
	ord_status ENUM ('Created', 'In progress', 'Completed', 'Cancelled') COMMENT 'Статус заказа',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT = 'Таблица интернет-заказов';

ALTER TABLE orders ADD CONSTRAINT orders_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  	order_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на заказ',
  	product_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на продукт',
  	quantity INT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Количество заказанных продуктов',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
    PRIMARY KEY (order_id, product_id) COMMENT 'Составной первичный ключ'
) COMMENT = 'Таблица продуктов в заказах';

ALTER TABLE orders_products ADD CONSTRAINT orders_products_order_id FOREIGN KEY (order_id) REFERENCES orders(id); -- 1:N
ALTER TABLE orders_products ADD CONSTRAINT orders_products_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя', 
  	product_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на продукт',
  	rating ENUM('1', '2', '3', '4', '5') COMMENT 'Оценка по 5-балльной шкале',
  	comment_text TEXT NOT NULL COMMENT 'Текст отзыва',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
    PRIMARY KEY (user_id, product_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Таблица отзывов о продуктах';

ALTER TABLE comments ADD CONSTRAINT comments_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N
ALTER TABLE comments ADD CONSTRAINT comments_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя', 
  	product_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на продукт',
  	is_favorite BIT COMMENT 'Статус отметки избранным продуктом - либо выбран, либо выбор снят',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
    PRIMARY KEY (user_id, product_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Таблица избранных продуктов пользователей';

ALTER TABLE favorites ADD CONSTRAINT favorites_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N
ALTER TABLE favorites ADD CONSTRAINT favorites_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

CREATE TABLE images (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	filename VARCHAR(255) NOT NULL COMMENT 'Полный путь к файлу',
    metadata JSON NOT NULL COMMENT 'Метаданные файла (дополнительные параметры картинки)',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица изображений';

DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
  	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор статьи',
  	head VARCHAR(255) NOT NULL COMMENT 'Заголовок статьи',
  	body TEXT NOT NULL COMMENT 'Текст статьи',
  	catalog_id INT UNSIGNED COMMENT 'Ссылка на раздел каталога, в котором будет видна статья',
  	product_id INT UNSIGNED COMMENT 'Ссылка на продукт, в карточке которого будет статья',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица статей о продуктах, отображаемых в разделах и карточках продуктов';

ALTER TABLE articles ADD CONSTRAINT articles_catalog_id FOREIGN KEY (catalog_id) REFERENCES catalogs(id); -- 1:N
ALTER TABLE articles ADD CONSTRAINT articles_product_id FOREIGN KEY (product_id) REFERENCES products(id); -- 1:N

DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор типа объекта',
	name VARCHAR(10) UNIQUE NOT NULL COMMENT 'Наименование типа объекта',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'	
) COMMENT 'Таблица типов сущностей, где могут использоваться изображения';

CREATE TABLE image_usage (
	image_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на изображение',
 	target_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на id объекта, к которому относится изображение',
 	target_type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на тип объекта, к которому относится изображение',
 	PRIMARY KEY (image_id, target_id, target_type_id) COMMENT 'Составной первичный ключ',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'	
) COMMENT 'Таблица ссылок на картинки в разделах, статьях и карточках продуктов';

ALTER TABLE image_usage ADD CONSTRAINT image_usage_image_id FOREIGN KEY (image_id) REFERENCES images(id); -- 1:N
ALTER TABLE image_usage ADD CONSTRAINT image_usage_target_type_id FOREIGN KEY (target_type_id) REFERENCES target_types(id); -- 1:N


-- filldb очень плохо работает, вставляем данные руками
-- разделы каталога
INSERT INTO 
	catalogs
VALUES 
	(1, 'Ванна и душ', NOW(), NOW()),
	(2, 'Бомбы для ванны', NOW(), NOW()),
	(3, 'Пены для ванны', NOW(), NOW()),
	(4, 'Гели для душа', NOW(), NOW()),
	(5, 'Волосы', NOW(), NOW()),
	(6, 'Шампуни', NOW(), NOW()),
	(7, 'Кондиционеры для волос', NOW(), NOW()),
	(8, 'Маски, кремы и масло для волос', NOW(), NOW()),
	(9, 'Лицо', NOW(), NOW()),
	(10, 'Маски для лица', NOW(), NOW()),
	(11, 'Очищающие средства', NOW(), NOW()),
	(12, 'Кремы', NOW(), NOW());

-- дерево каталога
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
	
-- пользователи
INSERT INTO 
	users
VALUES 
	(1, 'Валентина', 'Сергеева', 'val_serg@mail.ru', '+79267834566', 'Москва', NOW(), NOW()),
	(2, 'Елена', 'Козлова', 'lena345@yandex.ru', '+79857009090', 'Санкт-Петербург', NOW(), NOW()),
	(3, 'Ирина', 'Ярцева', 'irina.1985@mail.ru', '+79030901123', 'Воронеж', NOW(), NOW()),
	(4, 'Катерина', 'Мальгина', 'catalina_ma@me.com', '+79254343434', 'Москва', NOW(), NOW()),
	(5, 'Наталья', 'Павлова', 'natapav@yandex.ru', '+79061154567', 'Санкт-Петербург', NOW(), NOW()),
	(6, 'Александр', 'Синицын', '4951329087@gmail.com', '+79057771124', 'Воронеж', NOW(), NOW()),
	(7, 'Мария', 'Дмитриева', 'dmitrieva.mv@mail.ru', '+79104535432', 'Псков', NOW(), NOW()),
	(8, 'София', 'Лебедева', 'sofi_le@mail.ru', '+79110906543', 'Псков', NOW(), NOW()),
	(9, 'Сергей', 'Савицкий', 'sergey_savitky@bk.ru', '+79129066723', 'Самара', NOW(), NOW()),
	(10, 'Ольга', 'Петрова', 'petrova_olga@gmail.com', '+79161090909', 'Москва', NOW(), NOW());

-- профили
INSERT INTO 
	profiles 
VALUES 
	(1, 'val_serg@mail.ru', '+79267834566', 'tetge757', 'Россия', 'Москва', 'Ленинский проспект', 23, 1, 115, NOW(), NOW()),
	(2, 'lena345@yandex.ru', '+79857009090', '08363636', 'Россия', 'Санкт-Петербург', 'Невский проспект', 98, NULL, 87, NOW(), NOW()),
	(3, 'irina.1985@mail.ru', '+79030901123', 'TrTr_*&7Q', 'Россия', 'Воронеж', 'Лизюкова', 5, 2, 34, NOW(), NOW()),
	(4, 'catalina_ma@me.com', '+79254343434', '123456', 'Россия', 'Москва', 'Уланский переулок', 26, NULL, NULL, NOW(), NOW()),
	(5, 'natapav@yandex.ru', '+79061154567', 'Qwerty123', 'Россия', 'Санкт-Петербург', 'Малая Морская', 12, NULL, 45, NOW(), NOW()),
	(6, '4951329087@gmail.com', '+79057771124', '01011980', 'Россия', 'Воронеж', 'Ленина', 2, 1, 10, NOW(), NOW()),
	(7, 'dmitrieva.mv@mail.ru', '+79104535432', 'Nhjv,jwbg5', 'Россия', 'Кронштадт', 'Коммунистическая', 30, NULL, NULL, NOW(), NOW()),
	(8, 'sofi_le@mail.ru', '+79110906543', 'Sonya_2305', 'Россия', 'Псков', 'Барская', 3, NULL, 30, NOW(), NOW()),
	(9, 'sergey_savitky@bk.ru', '+79129066723', 'RgnThm678', 'Россия', 'Самара', 'Цветочная', 76, 3, 18, NOW(), NOW()),
	(10, 'petrova_olga@gmail.com', '+79161090909', 'LushRussia1', 'Россия', 'Москва', '1905 года', 7, 1, NULL, NOW(), NOW());
	
-- склады
DESC storehouses;
INSERT INTO 
	storehouses 
VALUES 
	(1, 'Склад Москва', NOW(), NOW()),
	(2, 'Склад Нахабино', NOW(), NOW()),
	(3, 'Склад Подольск', NOW(), NOW());

-- продукты
DESC products;
INSERT INTO 
	products 
VALUES 
	(1, 'Бродяга', 'Гель для душа с ароматом леса', 250, 1100.00, 4, NOW(), NOW(), 4.7),
	(2, 'Авокадо', 'Смягчающее средство для ко-вошинга', 100, 1000.00, 7, NOW(), NOW(), 4.3),
	(3, 'Пиво для Синтии', 'Шампунь с пивом', 500, 1900.00, 6, NOW(), NOW(), 3.9),
	(4, 'Божественное увлажнение', 'Крем для чувствительной кожи лица', 50, 2360.00, 12, NOW(), NOW(), 4.5),
	(5, 'Аиша', 'Свежая маска с антиоксидантами', 75, 700.00, 12, NOW(), NOW(), 4.5),
	(6, 'Амазонка', 'Маска для проблемной кожи лица', 75, 700.00, 12, NOW(), NOW(), 3.5),
	(7, 'Новинка', 'Твердый шампунь для роста волос', 1, 750.00, 6, NOW(), NOW(), 4.4),
	(8, 'Основа основ', 'Маска для волос и кожи головы', 225, 1400.00, 8, NOW(), NOW(), 5.0),
	(9, 'Coal face', 'Мягкое очищающее средство', 1, 800.00, 11, NOW(), NOW(), 5.0),
	(10, 'Беспечная любовь', 'Бомба для ванны с маслами бергамота и иланг-иланга', 1, 720.00, 2, NOW(), NOW(), 4.5);

-- изображения
INSERT INTO 
	images 
	(filename, metadata) 
VALUES 
(
	CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10)),
    CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
);

-- типы объектов, содержащих изображения
INSERT INTO 
	target_types 
	(id, name) 
VALUES 
	(1, 'catalogs'),
	(2, 'products'),
	(3, 'articles'); 

-- статьи
DESC articles;
INSERT INTO 
	articles 
	(id, head, body, catalog_id, product_id) 
VALUES 
	(1, 'Пять бестселлеров против пластика в вашей ванной', 'Как избавиться от ненужной упаковки с продуктами naked care', 2, NULL),
	(2, 'Путешествуйте налегке', 'Твёрдые самоконсервирующиеся продукты могут стать движением в правильном направлении', 6, 7),
	(3, 'Хна', 'Хна является отличной альтернативой синтетическим краскам для волос', 5, NULL),
	(4, 'Тональная основа', 'Как выбрать свой идеальный оттенок тональной основы', 9, 6),
	(5, 'Твердый гель для душа', 'Твердые гели для душа не содержат мыльной основы', 4, NULL);
	
-- заказы
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
	
-- продукты в заказах
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
	
-- избранные продукты пользователей
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
	
-- запасы продуктов на складах
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
	
-- ссылки на изображения
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
	
-- отзывы о продуктах
DESC comments;
INSERT INTO 
	comments 
	(user_id, product_id, rating, comment_text) 
VALUES 
	(1, 1, 2, 'Плохой продукт - не оправдал ожиданий'),
	(2, 10, 5, 'Отличный продукт - очень понравился'),
	(3, 1, 4, 'хороший'),
	(4, 8, 3, 'Так себе'),
	(5, 7, 2, 'Совершенно не годится'),
	(6, 2, 5, 'Прекрасное средство'),
	(7, 4, 5, 'Очень помогло'),
	(8, 3, 2, 'Стало только хуже'),
	(9, 3, 3, 'Ни рыба ни мясо'),
	(10, 6, 4, 'Не идеален но хорош');
	
