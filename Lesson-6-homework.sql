/* ��-6
1. ���������������� �������, ������� ����������� �� �������, ���������� ��������� ������������� �/��� ��������� (JOIN ���� �� ���������).
2. ����� ����� ��������� ������������. 
�� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.
3. ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.
4. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?
5. ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.
*/

USE vk;
SHOW TABLES;

-- fill-db �� �������, �������� ������ � ������� ������, � ������� ������ � � ������� ����-����� ����� ���� insert-�
SELECT * FROM likes;
INSERT INTO likes (user_id, target_id, target_type_id) VALUES (FLOOR(1 + RAND() * 100), FLOOR(1 + RAND() * 100), FLOOR(1 + RAND() * 3));

SELECT * FROM posts;
INSERT INTO posts (user_id, head, body, is_public) VALUES (IF (FLOOR(1 + RAND() * 2) = 1,  FLOOR(1 + RAND() * 99), NULL), substr(MD5(RAND()), 1, 10), MD5(RAND()), 1);

SELECT * FROM post_media pm ;
INSERT INTO post_media (post_id, media_id, created_at, updated_at) VALUES (FLOOR(1 + RAND() * 30), FLOOR(1 + RAND() * 100), NOW(), NOW());

/*
1. ���������������� �������, ������� ����������� �� �������, ���������� ��������� ������������� �/��� ��������� (JOIN ���� �� ���������).
*/

-- ������ �� ���� ��-6
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

-- ������� �������� ��� join-��
-- ���.1
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

-- ���.2
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


/* 2. ����� ����� ��������� ������������. 
�� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.
���� �� ���������� ��������� ����� ����� �������������� (� ��� �������) 
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


/*3. ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.
3.1 ������� ����� ������� ������������� - �� 2
����� �� ������������, � ������ ���������� ��������������, �.�., �� �� ���� �� user_id, 
� ���� �� target_type_id = 1 � ������ �� targed_id, ������� id ������������
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

-- 3.2 ������� ���������� ������, ������������ ������ �������� �������������� - � �� ��� 7
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
4. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?
*/

-- ����� �������
SELECT 
	(
		SELECT 
			CASE 
				WHEN gender = 'M' THEN '�������' 
				WHEN gender = 'F' THEN '�������'
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

-- ������� ������ ��� ���, ��� �������� ������
SELECT 
	(
		SELECT 
			CASE 
				WHEN gender = 'M' THEN '�������' 
				WHEN gender = 'F' THEN '�������'
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
5. ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.
������� ����� ����� ���������� ������, ������ � ��������� �� ������������
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

/* ���������� ���������  � �������� �������
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

