/* 
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”. Работаем с БД vk и данными, которые вы сгенерировали ранее:
1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
3. Определить кто больше поставил лайков (всего): мужчины или женщины.
Задачи необходимо решить с использованием объединения таблиц (JOIN)
*/

/* 1. Пусть задан некоторый пользователь. 
Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений). 
*/ 


-- смотрим, кто вообще писал юзеру 1
SELECT from_user_id, COUNT(1) FROM messages m 
WHERE to_user_id = 1
GROUP BY from_user_id;

-- обновила данные, чтобы было от кого-то больше сообщений, чем от других
UPDATE 
	messages 
SET 
	from_user_id = 17 
WHERE 
	from_user_id = 47
AND 
	to_user_id = 1;

-- отбираем среди друзей того, кто писал юзеру 1 больше всех сообщений
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
		f1.friend_id AS friend_of_1
	FROM
		friendship f1
	INNER JOIN friendship f2 ON (
		f1.request_type_id = f2.request_type_id
		AND f1.friend_id = f2.user_id
		AND f1.user_id = f2.friend_id
)
WHERE
	f1.request_type_id = 2
	AND f1.user_id = 1
)
SELECT
	u.id user_id,
	CONCAT (u.first_name, ' ', u.last_name) user_name,
	COUNT(m.id) messages_to_1
FROM friends f
INNER JOIN users u ON (
	f.friend_of_1 = u.id
)
INNER JOIN messages m ON (
	m.from_user_id = u.id 
)
WHERE 
	to_user_id = 1
GROUP BY friend_of_1
ORDER BY COUNT(1) DESC
LIMIT 1;


/*2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/

SELECT 
	COUNT(1) likes_total 
FROM 
	likes l 
INNER JOIN users u ON (
	l.target_id = u.id
)
WHERE 
	l.target_type_id = 1
AND /* вычисляем возраст и отбираем меньше 10 лет */
	(
    (YEAR(CURRENT_DATE) - YEAR(u.birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(u.birthday, '%m%d')) 
  ) < 10;


/* 
3. Определить, кто больше поставил лайков (всего): мужчины или женщины.
*/

-- Общая картина по всем лайкам
SELECT
	IF (u.gender = 'M', 'Мужчины', 'Женщины') AS liker_gender,
	COUNT(1) AS likes_quantity
FROM 
	likes l
INNER JOIN users u ON (
	l.user_id = u.id
)
GROUP BY 
	liker_gender 
ORDER BY 
	likes_quantity DESC
;

-- Выводим только пол тех, кто поставил больше лайков в совокупности
SELECT
	IF (u.gender = 'M', 'Мужчины', 'Женщины') AS liker_gender,
	COUNT(1) AS likes_quantity
FROM 
	likes l
INNER JOIN users u ON (
	l.user_id = u.id
)
GROUP BY 
	liker_gender 
ORDER BY 
	likes_quantity DESC
LIMIT 1
;