DROP DATABASE vk;
CREATE DATABASE vk;
USE vk;
SHOW TABLES;

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'ID пользователя', -- искуственный ключ
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
    birthday DATE NOT NULL COMMENT 'Дата рождения',
    gender CHAR(1) NOT NULL COMMENT 'Пол',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя',  -- email + phone - натуральный ключ
    phone VARCHAR(11) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',    
    created_at DATETIME COMMENT 'Дата и время создания строки',
    updated_at DATETIME COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица пользователей';

-- SELECT REGEXP_LIKE('+79991234567', '^\\+7[0-9]{10}$');

ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки';
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки';
ALTER TABLE users MODIFY gender ENUM('M', 'F') NOT NULL COMMENT 'Пол';
ALTER TABLE users MODIFY phone VARCHAR(12) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя'; 
-- ALTER TABLE users DROP CONSTRAINT сheck_phone;
-- ALTER TABLE users ADD CONSTRAINT сheck_phone CHECK (REGEXP_LIKE(phone, '^\\+7[0-9]{10}$')) ; -- задаем формат номера телефона

DESCRIBE users;

-- email + phone - ключ

CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'ID пользователя',
	city VARCHAR(100) COMMENT 'Город проживания',
    country VARCHAR(100) COMMENT 'Старана проживания',    
    `status` VARCHAR(10) COMMENT 'Текущий статус пользователя',
	created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',    
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки'
) COMMENT "Таблица профилей"; 

ALTER TABLE profiles MODIFY `status` ENUM('Online', 'Offline', 'Disabled') NOT NULL COMMENT 'Текущий статус пользователя';
ALTER TABLE profiles MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки';
ALTER TABLE profiles MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки'; 

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- Создаем Внешний ключ, 1:1

CREATE TABLE friendship (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора запроса о дружбе',
    friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
    request_type_id INT UNSIGNED NOT NULL COMMENT 'Тип запроса',
    requested_at DATETIME COMMENT 'Дата и время запроса',
    confirmed_at DATETIME COMMENT 'Дата и время подтверждения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',  
    PRIMARY KEY (user_id, friend_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Таблица дружбы';

CREATE TABLE  friendship_request_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'ID типа запроса',
    request_type_name VARCHAR(10) NOT NULL UNIQUE COMMENT 'Название типа запроса',
    created_at DATETIME COMMENT 'Дата и время создания строки',
    updated_at DATETIME COMMENT 'Дата и время обновления строки'	
) COMMENT 'Справочник типов запросов дружбы';

-- Внешний ключ всегдя связывает одно поле одной таблицы с одним полем другой таблицы

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); -- 1:N
ALTER TABLE friendship ADD CONSTRAINT friendship_request_type_id FOREIGN KEY (request_type_id) REFERENCES friendship_request_types(id); -- 1:N

ALTER TABLE friendship_request_types MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки';
ALTER TABLE friendship_request_types MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'; 
ALTER TABLE friendship MODIFY requested_at DATETIME NOT NULL COMMENT 'Дата и время запроса'; 

CREATE TABLE communities (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'ID типа запроса',
    `name` VARCHAR(150) NOT NULL UNIQUE COMMENT 'Название сообщества',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица сообществ';

-- SHOW TABLES;
-- RENAME TABLE community_id TO communities;

CREATE TABLE communities_users (
	community_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на сообщество',
    user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя',
    PRIMARY KEY (community_id, user_id) COMMENT 'Составной первичный ключ', 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица участников сообществ, связь между пользователями и группами';

ALTER TABLE communities_users ADD CONSTRAINT communities_users_community_id FOREIGN KEY (community_id) REFERENCES communities(id); -- 1:N
ALTER TABLE communities_users ADD CONSTRAINT communities_users_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:N

CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время  создания строки',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время  обновления строки'
) COMMENT 'Таблица сообщений';

ALTER TABLE messages ADD CONSTRAINT messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id); 
ALTER TABLE messages ADD CONSTRAINT messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id); 

CREATE TABLE media (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
	filename VARCHAR(255) NOT NULL COMMENT 'Полный путь к файлу',
    media_type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на тип файла',
    metadata JSON NOT NULL COMMENT 'Метаданные файла (дополнительные параметры, в зависимости от типа файла)',
    user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица медиафайлов';

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(255) NOT NULL UNIQUE COMMENT 'Название типа',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Типы медиафайлов';

ALTER TABLE media ADD CONSTRAINT media_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id); 
ALTER TABLE media ADD CONSTRAINT media_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

/*
размер длительность разрешение кодек 

file = {
	"size":"...",
    "extension":"...",
    "resolution":"...",
    "time":"..."
}

file.size

*/

SELECT JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32') AS `JSON`;
SELECT JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32')->"$.size";

CREATE TABLE test_json (body JSON);

INSERT test_json (body) VALUES (JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32'));
SELECT * FROM test_json;
SELECT body->"$.size" FROM test_json;

INSERT test_json (body) VALUES (JSON_OBJECT('size', 123, 'extension', 'jpeg', 'resolution', '32x32'));
INSERT test_json (body) VALUES (JSON_OBJECT('name', 'John', 'age', '31', 'gender', 'm'));

/*
1 + 1
"1" + "1" = 2
"HELLO" + 1 = 1
*/

SELECT * FROM test_json;
DELETE FROM test_json WHERE 1=1 AND body = JSON_OBJECT('size', 123);
INSERT test_json (body) VALUES ('{"size":123, "extension": "jpeg", "resolution": "32x32"}');

drop table like_tables;
CREATE TABLE like_table (line varchar(100));
INSERT INTO like_table (line) value ('+7(999)111-22-33');
SELECT * FROM like_table WHERE line = '+7(999)111-22-33';
SELECT * FROM like_table WHERE line LIKE '+7(999)%';
INSERT INTO like_table (line) value ('Иванов Петр Борисович');
INSERT INTO like_table (line) value ('Ivanov Pert Borisovich');
SELECT * FROM like_table;
SELECT * FROM like_table WHERE line LIKE '%П__р%';

/* 
% - любое количество любых символов
_ - один любой символ
*/

SELECT REGEXP_LIKE('+79991234567', '^\\+7[0-9]{10}$');

/* 
* - любое количество любых символов (0 тоже)
+ - более одного символа
. - один любой символ
^ - начало строки
$ - конец строки
[0-9] - перечисление
\\ - экранирование
[a-z] - перечисление
{10} - сколько раз
*/

SHOW TABLES;

DROP TABLE like_table;
DROP TABLE test_json;

/* CRUD - create, read, update, delete */

SHOW TABLES;
DESCRIBE users;

USE INFORMATION_SCHEMA;
SHOW TABLES;

USE vk;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA' AND TABLE_NAME LIKE '%CONSTR%';
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'vk';

SELECT * FROM users;

-- +79

-- CEIL()
-- FLOOR()
SELECT CONCAT('FOO', 'BAR');
SELECT CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND()));

SELECT REGEXP_LIKE(CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())), '^\\+7[0-9]{10}$');

SELECT * FROM users;
UPDATE users SET phone = CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())) WHERE id < 200;
-- UPDATE users SET phone = CONCAT('17', 9000000000 + FLOOR(999999999 * RAND())) WHERE id < 200;
SELECT * FROM users;
SELECT COUNT(*) FROM users;

SELECT * FROM messages;

UPDATE messages SET
	from_user_id = FLOOR(1 + RAND() * 100),
    to_user_id = FLOOR(1 + RAND() * 100) 
     WHERE id < 200;
     
SELECT * FROM media;

DESC media;

SELECT * FROM media_types;
UPDATE media_types SET name = 'audio' WHERE id = 1;
UPDATE media_types SET name = 'image' WHERE id = 2;
UPDATE media_types SET name = 'video' WHERE id = 3;
UPDATE media_types SET name = 'gif' WHERE id = 4;
UPDATE media_types SET name = 'document' WHERE id = 5;

SELECT SUBSTR(MD5(RAND()), 1, 10);
SELECT CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10));
INSERT INTO media (filename, media_type_id, metadata, user_id) VALUE (
	CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10)),
    FLOOR(1 + RAND() * 5),
    '{}',
    FLOOR(1 + RAND() * 100)
);

SELECT CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "wav", "duration" : ', FLOOR(1 + RAND() * 100000), '}');
UPDATE media SET metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "wav", "duration" : ', FLOOR(1 + RAND() * 100000), '}')
WHERE media_type_id = 1;

SELECT metadata->"$.size" FROM media WHERE media_type_id = 1;
UPDATE media SET filename = CONCAT_WS('.', filename, metadata->"$.extension")
WHERE media_type_id = 1;
SELECT * FROM media WHERE media_type_id = 1;

SELECT * FROM media;
SELECT CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}');
UPDATE media SET metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
WHERE media_type_id = 2;


-- Добавленные таблицы для постов и лайков

CREATE TABLE topics (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Название тематики',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Тематики постов';

CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  author_id INT UNSIGNED NOT NULL COMMENT "Ссылка на автора поста",
  body TEXT NOT NULL COMMENT "Текст поста",
  topic_id INT UNSIGNED NOT NULL COMMENT "Тематика поста",
  visible_to ENUM('Everyone', 'Friends') NOT NULL COMMENT 'Настройка видимости',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время  создания строки',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время  обновления строки'
) COMMENT 'Таблица постов';

ALTER TABLE posts ADD CONSTRAINT posts_author_id FOREIGN KEY (author_id) REFERENCES users(id); 
ALTER TABLE posts ADD CONSTRAINT posts_topic_id FOREIGN KEY (topic_id) REFERENCES topics(id); 
ALTER TABLE posts DROP CONSTRAINT posts_user_id;
ALTER TABLE posts RENAME COLUMN user_id TO author_id;
-- ALTER TABLE users ADD CONSTRAINT сheck_phone CHECK (REGEXP_LIKE(phone, '^\\+7[0-9]{10}$')) ; -- задаем формат номера телефона

DESC posts;
DESC messages;



CREATE TABLE postmedia (
  media_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на медиафайл',
  post_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пост',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (media_id, post_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Медиафайлы в постах';

ALTER TABLE postmedia ADD CONSTRAINT postmedia_media_id FOREIGN KEY (media_id) REFERENCES media(id); 
ALTER TABLE postmedia ADD CONSTRAINT postmedia_post_id FOREIGN KEY (post_id) REFERENCES posts(id); 

CREATE TABLE object_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Название таблицы объекта',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Типы объектов, в которых могут быть лайки';

CREATE TABLE post_likes (
  user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на автора лайка',
  post_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на id поста',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (user_id, post_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Таблица лайков для постов';

CREATE TABLE media_likes (
  user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на автора лайка',
  media_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на id файла',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (user_id, media_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Таблица лайков для файлов';

CREATE TABLE user_likes (
  user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на автора лайка',
  liked_user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на id пользователя - объекта лайка',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (user_id, liked_user_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Таблица лайков для пользователей';

ALTER TABLE post_likes ADD CONSTRAINT post_likes_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE post_likes ADD CONSTRAINT post_likes_post_id FOREIGN KEY (post_id) REFERENCES posts(id); 

ALTER TABLE media_likes ADD CONSTRAINT media_likes_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE media_likes ADD CONSTRAINT media_likes_media_id FOREIGN KEY (media_id) REFERENCES media(id); 

ALTER TABLE user_likes ADD CONSTRAINT user_likes_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE user_likes ADD CONSTRAINT user_likes_liked_user_id FOREIGN KEY (liked_user_id) REFERENCES users(id); 


/*SHOW TABLES;
USE INFORMATION_SCHEMA;
SHOW TABLES;

USE vk;

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'INFORMATION_SCHEMA' AND TABLE_NAME LIKE '%CONSTR%';
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA = 'vk';
SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'vk';

SELECT * FROM users;
*/