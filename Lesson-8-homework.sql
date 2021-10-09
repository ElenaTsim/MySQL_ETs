/* 
������������ ������� �� ���� ����������, ����������, ���������� � �����������. ��������� �������. �������� � �� vk � �������, ������� �� ������������� �����:
1. ����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).
2. ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..
3. ���������� ��� ������ �������� ������ (�����): ������� ��� �������.
������ ���������� ������ � �������������� ����������� ������ (JOIN)
*/

/* 1. ����� ����� ��������� ������������. 
����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, 
������� ������ ���� ������� � ��������� ������������� (������� ��� ���������). 
*/ 


-- �������, ��� ������ ����� ����� 1
SELECT from_user_id, COUNT(1) FROM messages m 
WHERE to_user_id = 1
GROUP BY from_user_id;

-- �������� ������, ����� ���� �� ����-�� ������ ���������, ��� �� ������
UPDATE 
	messages 
SET 
	from_user_id = 17 
WHERE 
	from_user_id = 47
AND 
	to_user_id = 1;

-- �������� ����� ������ ����, ��� ����� ����� 1 ������ ���� ���������
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


/*2. ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���.*/

SELECT 
	COUNT(1) likes_total 
FROM 
	likes l 
INNER JOIN users u ON (
	l.target_id = u.id
)
WHERE 
	l.target_type_id = 1
AND /* ��������� ������� � �������� ������ 10 ��� */
	(
    (YEAR(CURRENT_DATE) - YEAR(u.birthday)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(u.birthday, '%m%d')) 
  ) < 10;


/* 
3. ����������, ��� ������ �������� ������ (�����): ������� ��� �������.
*/

-- ����� ������� �� ���� ������
SELECT
	IF (u.gender = 'M', '�������', '�������') AS liker_gender,
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

-- ������� ������ ��� ���, ��� �������� ������ ������ � ������������
SELECT
	IF (u.gender = 'M', '�������', '�������') AS liker_gender,
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