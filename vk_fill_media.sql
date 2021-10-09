DESC media;
SELECT * FROM media;
-- DELETE FROM media where id < 200;

-- SELECT SUBSTR(MD5(RAND()), 1, 10);
-- SELECT CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10));

INSERT INTO media (filename, media_type_id, metadata, user_id) VALUE (
	CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10)),
    FLOOR(1 + RAND() * 5),
    '{}',
    FLOOR(1 + RAND() * 100)
);

UPDATE media SET
	metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "wav", "duration" : ', FLOOR(1 + RAND() * 100000), '}')
	WHERE media_type_id = 1;

SELECT * FROM media;
-- SELECT CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}');

UPDATE media SET 
	metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
	WHERE media_type_id = 2;

UPDATE media SET 
	metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "mp3", "duration" : ', FLOOR(1 + RAND() * 100000), '}')
	WHERE media_type_id = 3;
    
UPDATE media SET 
	metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "gif", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
	WHERE media_type_id = 4;
 
UPDATE media SET
	metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "pdf", "type" : "Adobe Acrobat document"}')
	WHERE media_type_id = 5 
    AND 
    id < 60;

UPDATE media SET
	metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "xls", "type" : "MS Excel document"}')
	WHERE media_type_id = 5 
    AND 
    id BETWEEN 60 AND 70;
    
UPDATE media SET
	metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "doc", "type" : "MS Word document"}')
	WHERE media_type_id = 5 
    AND 
    id > 70;
    
SELECT * FROM media
WHERE media_type_id = 5;