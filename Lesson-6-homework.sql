/* ДЗ-6
1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).
2. Пусть задан некоторый пользователь. 
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
*/

USE vk;
SHOW TABLES;

-- fill-db не работал, добавила ланные в таблицу лайков, в таблицу постов и в таблицу пост-медиа через свои insert-ы
SELECT * FROM likes;
INSERT INTO likes (user_id, target_id, target_type_id) VALUES (FLOOR(1 + RAND() * 100), FLOOR(1 + RAND() * 100), FLOOR(1 + RAND() * 3));

SELECT * FROM posts;
INSERT INTO posts (user_id, head, body, is_public) VALUES (IF (FLOOR(1 + RAND() * 2) = 1,  FLOOR(1 + RAND() * 99), NULL), substr(MD5(RAND()), 1, 10), MD5(RAND()), 1);

SELECT * FROM post_media pm ;
INSERT INTO post_media (post_id, media_id, created_at, updated_at) VALUES (FLOOR(1 + RAND() * 30), FLOOR(1 + RAND() * 100), NOW(), NOW());

/*
1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).
*/

-- Запрос из лога ДЗ-6
WITH friends AS (
	SELECT
		friend_id AS to_users_id
	FROM
		friendship
	WHERE
		user_id = 1
		AND request_type_id = 1
		
	UNION
	SELECT
		user_id AS to_users_id
	FROM
		friendship
	WHERE
		friend_id = 1
		AND request_type_id = 1
		
	UNION
	SELECT
		friend_id AS to_users_id
	FROM
		friendship
	WHERE
		user_id = 1
		AND request_type_id = 2
		
	UNION
	SELECT
		user_id AS to_users_id
	FROM
		friendship
	WHERE
		friend_id = 1
		AND request_type_id = 2 
)
SELECT
	id,
	first_name,
	last_name
FROM
	users
WHERE
	id IN (
	 SELECT to_users_id FROM friends 
	);

-- Попытки улучшить без join-ов
-- вар.1
WITH friends AS (
	SELECT
		CASE 
			WHEN user_id = 1 THEN friend_id 
			WHEN friend_id = 1 THEN user_id
		END friend_of_1
	FROM
		friendship
	WHERE
		(user_id = 1 AND request_type_id = 1 AND confirmed_at IS NOT NULL) OR
		(friend_id = 1 AND request_type_id = 1 AND confirmed_at IS NOT NULL)
	UNION
	SELECT
		CASE 
			WHEN user_id = 1 THEN friend_id 
			WHEN friend_id = 1 THEN user_id
		END friend_of_1
	FROM
		friendship
	WHERE
		(user_id = 1 AND request_type_id = 2) OR
		(friend_id = 1 AND request_type_id = 2)
	)
SELECT
	id,
	CONCAT (first_name,' ', last_name)
FROM
	users
WHERE
	id IN (
	 SELECT friend_of_1 FROM friends 
	);

-- вар.2
WITH friends AS (
	SELECT
		IF (user_id = 1, friend_id, user_id) AS friend_of_1 
	FROM
		friendship
	WHERE
		(user_id = 1 OR friend_id = 1)
		AND request_type_id = 1 
		AND confirmed_at IS NOT NULL
	UNION
	SELECT
		IF (user_id = 1, friend_id, user_id) AS friend_of_1 
	FROM
		friendship
	WHERE
		(user_id = 1 OR friend_id = 1)
		AND request_type_id = 2 
	)
SELECT
	id,
	CONCAT (first_name,' ', last_name)
FROM
	users
WHERE
	id IN (
	 SELECT friend_of_1 FROM friends 
	);


/* 2. Пусть задан некоторый пользователь. 
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
Ищем по количеству сообщений между двумя пользователями (в обе стороны) 
*/ 

-- var.1
WITH friends AS (
	SELECT
		IF (user_id = 1, friend_id, user_id) AS friend_of_1 
	FROM
		friendship
	WHERE
		(user_id = 1 OR friend_id = 1)
		AND request_type_id = 1 
		AND confirmed_at IS NOT NULL
	UNION
	SELECT
		IF (user_id = 1, friend_id, user_id) AS friend_of_1 
	FROM
		friendship
	WHERE
		(user_id = 1 OR friend_id = 1)
		AND request_type_id = 2 
	)
SELECT
	IF (from_user_id = 1, to_user_id, from_user_id) AS friend_of_1_id,
	(
		SELECT 
			CONCAT (first_name,' ', last_name)
		FROM 
			users u 
		WHERE 
			u.id = IF (m.from_user_id = 1, m.to_user_id, m.from_user_id)
	) AS friend_name,
	COUNT(1) AS messages
FROM
	messages m
WHERE 
	from_user_id = 1 AND to_user_id IN (
	 SELECT friend_of_1 FROM friends 
	)
OR 
	to_user_id = 1 AND from_user_id IN (
	 SELECT friend_of_1 FROM friends 
	)
GROUP BY (IF (from_user_id = 1, to_user_id, from_user_id))
ORDER BY COUNT(1) DESC
LIMIT 1
; 

-- var.2
SELECT 
	IF (from_user_id = 1, to_user_id, from_user_id) AS friend_of_1_id,
	(
		SELECT 
			CONCAT (first_name,' ', last_name)
		FROM 
			users u 
		WHERE 
			u.id = IF (m.from_user_id = 1, m.to_user_id, m.from_user_id)
	) AS friend_name,
	COUNT(1) AS messages
FROM 
	messages m
WHERE 
	from_user_id = 1 OR to_user_id = 1
GROUP BY friend_of_1_id
ORDER BY COUNT(1) DESC
LIMIT 1;


/*3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
3.1 Находим лайки молодых пользователей - их 2
Лайки не поставленные, а именно полученные пользователями, т.е., мы не ищем по user_id, 
а ищем по target_type_id = 1 и дальше по targed_id, равному id пользователя
*/

WITH youngsters AS (
	SELECT 
		id AS youngster_id 
	FROM 
		users
	ORDER BY 
		birthday DESC
	LIMIT 10
)
SELECT 
	COUNT(target_id) 
FROM 
	likes 
WHERE 
	target_id IN (
	 SELECT youngster_id FROM youngsters 
	)
	AND
	target_type_id = 1 
;

-- 3.2 Считаем количество лайков, поставленных самыми молодыми пользователями - а их уже 7
WITH youngsters AS (
	SELECT 
		id AS youngster_id
	FROM 
		users
	ORDER BY 
		birthday DESC
	LIMIT 10
)
SELECT 
	COUNT(user_id)
FROM 
	likes 
WHERE 
	user_id IN (
	 SELECT youngster_id FROM youngsters 
	);


/* 
4. Определить кто больше поставил лайков (всего) - мужчины или женщины?
*/

-- Общая картина
SELECT 
	(
		SELECT 
			CASE 
				WHEN gender = 'M' THEN 'Мужчины' 
				WHEN gender = 'F' THEN 'Женщины'
			END genders 
		FROM 
			users u 
		WHERE
			u.id = l.user_id
	) AS liker_gender,
	COUNT(1) AS likes_quantity
FROM 
	likes l 
GROUP BY 
	liker_gender 
ORDER BY 
	likes_quantity DESC
;

-- Выводим только пол тех, кто поставил больше
SELECT 
	(
		SELECT 
			CASE 
				WHEN gender = 'M' THEN 'Мужчины' 
				WHEN gender = 'F' THEN 'Женщины'
			END genders
		FROM 
			users u 
		WHERE
			u.id = l.user_id
	) AS liker_gender,
	COUNT(1) AS likes_quantity
FROM 
	likes l 
GROUP BY 
	liker_gender 
ORDER BY 
	likes_quantity DESC
LIMIT 1
;

/* 
5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
Считаем через общее количество лайков, постов и сообщений от пользователя
*/

SELECT 
	(
		SELECT 
			CONCAT (first_name,' ', last_name)
		FROM 
			users u 
		WHERE 
			us.id = u.id
	) AS user_name,
	(
		SELECT 	
			COUNT(1)
		FROM 
			likes l 
		WHERE 
			l.user_id = us.id
	) + 
	(
		SELECT 	
			COUNT(1)
		FROM 
			messages m 
		WHERE 
			m.from_user_id = us.id	
	) +
	(
		SELECT 	
			COUNT(1)
		FROM 
			posts p 
		WHERE 
			p.user_id = us.id	
	)
	AS total_activities
FROM 
	users us
ORDER BY
	total_activities DESC
LIMIT 10
;

/* захотелось посчитать  в обратную сторону
SELECT 
	(
		SELECT 
			CONCAT (first_name,' ', last_name)
		FROM 
			users u 
		WHERE 
			us.id = u.id
	) AS user_name,
	(
		SELECT 	
			COUNT(1)
		FROM 
			likes l 
		WHERE 
			l.user_id = us.id
	) AS total_likes,  
	(
		SELECT 	
			COUNT(1)
		FROM 
			messages m 
		WHERE 
			m.from_user_id = us.id	
	) AS total_messages, 
	(
		SELECT 	
			COUNT(1)
		FROM 
			posts p 
		WHERE 
			p.user_id = us.id	
	) AS total_posts,
	(
		SELECT 
			total_likes + total_messages + total_posts
	) AS total_activities
FROM 
	users us
ORDER BY
	total_activities DESC
LIMIT 10
;
*/

