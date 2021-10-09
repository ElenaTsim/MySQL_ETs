INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (1, 'ea', '1990-03-06 16:15:17', '1997-09-14 20:30:59');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (2, 'sit', '2004-01-10 08:26:45', '2005-07-31 17:07:23');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (3, 'magnam', '2019-08-18 17:55:26', '1999-11-14 16:21:30');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (4, 'molestiae', '2013-10-25 13:14:35', '2008-11-12 09:27:09');
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES (5, 'enim', '1982-12-23 07:58:45', '2006-08-02 17:10:23');

SELECT * FROM media_types;
UPDATE media_types SET name = 'audio' WHERE id = 1;
UPDATE media_types SET name = 'image' WHERE id = 2;
UPDATE media_types SET name = 'video' WHERE id = 3;
UPDATE media_types SET name = 'gif' WHERE id = 4;
UPDATE media_types SET name = 'document' WHERE id = 5;

SELECT * FROM media_types;

