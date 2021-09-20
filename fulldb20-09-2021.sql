#
# TABLE STRUCTURE FOR: catalogs
#

DROP TABLE IF EXISTS `catalogs`;

CREATE TABLE `catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) COMMENT='Разделы интернет-магазина';

INSERT INTO `catalogs` (`id`, `name`) VALUES ('1', 'Процессоры');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('2', 'Материнские платы');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('3', 'Видеокарты');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('4', 'Жесткие диски');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('5', 'Оперативная память');


#
# TABLE STRUCTURE FOR: discounts
#

DROP TABLE IF EXISTS `discounts`;

CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `discount` float unsigned DEFAULT NULL COMMENT 'Величина скидки от 0.0 до 1.0',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`),
  KEY `index_of_product_id` (`product_id`)
) COMMENT='Скидки';

INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('1', 1, 1, '73683000', '1977-02-09 09:40:11', '2017-12-28 15:16:42', '2012-11-09 06:51:50', '1971-06-14 11:41:13');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('2', 2, 2, '2', '2002-11-23 21:13:16', '2021-02-25 03:51:15', '1970-04-28 03:42:53', '1998-08-15 19:52:28');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('3', 3, 3, '9', '2006-03-10 08:12:09', '2003-04-16 01:31:27', '1994-04-26 16:54:33', '2003-12-25 11:47:28');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('4', 4, 4, '5', '1973-10-16 11:47:04', '2002-06-22 19:21:53', '2012-11-05 14:10:47', '2010-05-05 00:18:20');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('5', 5, 5, '946044', '1991-04-10 17:52:58', '1993-03-19 21:26:34', '1986-08-02 01:34:17', '1984-09-11 22:26:26');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('6', 6, 6, '6', '1986-02-06 11:17:36', '2007-10-07 04:30:04', '2020-10-18 05:27:21', '1976-08-28 02:06:49');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('7', 1, 7, '202', '1977-05-13 23:32:49', '1980-01-30 08:14:30', '2000-07-12 03:56:16', '1988-03-21 04:23:49');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('8', 2, 1, '4319660', '2002-02-05 00:31:59', '2007-05-03 21:14:08', '2003-10-08 12:57:23', '1992-09-28 23:39:58');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('9', 3, 2, '401779000', '2010-01-01 15:38:56', '2019-07-09 01:36:17', '2000-08-04 11:26:19', '1999-08-13 23:41:47');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('10', 4, 3, '4234', '1996-04-05 02:46:43', '1972-05-01 22:07:05', '1974-04-27 23:54:53', '1983-01-02 07:46:47');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('11', 5, 4, '0', '2011-01-12 20:05:11', '2019-02-28 09:33:22', '1970-02-05 04:25:08', '2007-01-11 20:50:48');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('12', 6, 5, '32066700', '2006-04-27 16:44:36', '2015-08-07 09:35:40', '1992-07-09 19:54:36', '2005-04-21 12:51:36');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('13', 1, 6, '71', '2011-08-06 20:42:45', '2010-01-22 10:12:08', '1999-06-29 18:01:53', '2010-04-06 03:47:55');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('14', 2, 7, '394768000', '1973-10-19 13:50:22', '2001-02-09 06:56:52', '1988-05-09 13:27:17', '2015-03-15 07:03:41');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('15', 3, 1, '77448', '1992-06-16 22:06:25', '1975-09-07 12:15:18', '2014-06-13 21:08:22', '1992-12-30 22:32:26');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('16', 4, 2, '321629000', '1982-01-27 13:01:36', '1999-01-21 22:48:27', '1971-07-15 03:15:42', '1976-06-19 14:11:24');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('17', 5, 3, '7', '2014-11-06 04:42:12', '2018-10-03 03:07:43', '2002-07-12 00:47:59', '2002-03-20 21:03:43');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('18', 6, 4, '525763000', '2009-03-16 12:07:02', '1974-01-01 16:48:49', '1985-05-05 16:08:35', '2020-08-10 17:05:10');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('19', 1, 5, '87708800', '1998-11-27 09:50:48', '1975-05-01 04:23:02', '1989-06-14 00:38:25', '1983-08-27 22:09:30');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('20', 2, 6, '239052', '2009-02-16 23:17:23', '1978-09-13 14:12:25', '1970-10-19 16:24:09', '1971-03-18 17:28:09');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('21', 3, 7, '13', '1985-01-03 20:45:47', '1982-11-05 01:52:21', '1974-06-05 14:40:40', '1991-04-23 17:04:42');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('22', 4, 1, '9958810', '2000-08-31 16:55:51', '1984-11-07 10:53:53', '1991-11-18 07:36:59', '1975-11-19 22:19:59');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('23', 5, 2, '0', '1970-01-23 00:42:36', '1970-10-03 11:11:29', '2017-05-07 00:41:43', '1991-01-06 06:16:55');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('24', 6, 3, '1989', '2016-08-08 21:56:04', '2017-09-19 16:56:10', '1981-07-05 20:10:16', '1976-06-15 04:16:20');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('25', 1, 4, '8', '1976-02-25 14:46:39', '2018-06-26 05:53:06', '1989-02-15 06:29:07', '1970-06-12 01:37:49');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('26', 2, 5, '0', '1974-01-16 14:43:32', '2016-09-20 11:33:32', '1988-12-14 01:47:36', '2002-06-04 00:47:02');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('27', 3, 6, '726338', '2015-07-24 17:56:00', '2020-01-19 19:40:19', '1983-06-13 16:56:07', '1983-06-12 21:26:17');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('28', 4, 7, '6846850', '1997-10-14 11:08:27', '2010-05-30 07:40:16', '1981-03-19 08:16:21', '1981-07-28 21:08:18');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('29', 5, 1, '39966500', '2003-08-25 02:10:15', '2006-05-16 22:20:26', '1999-11-13 09:21:30', '2004-02-16 08:14:38');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('30', 6, 2, '39984', '2015-08-30 09:29:12', '1976-03-24 01:20:57', '1976-02-10 18:23:47', '2013-10-26 21:17:26');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('31', 1, 3, '78739', '1991-01-22 17:21:56', '1977-08-30 01:59:36', '1996-08-25 20:41:00', '1990-01-22 20:01:42');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('32', 2, 4, '7742', '1997-12-20 19:41:24', '1981-05-02 00:46:40', '1981-01-21 05:15:57', '1985-02-28 03:21:27');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('33', 3, 5, '48093200', '1982-04-18 16:05:26', '1979-09-25 14:58:33', '2003-08-23 08:03:14', '1970-08-10 22:26:22');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('34', 4, 6, '0', '1986-12-06 19:08:21', '1995-09-20 19:55:11', '1994-12-08 17:44:37', '1984-02-24 20:21:04');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('35', 5, 7, '499', '1970-09-30 08:51:16', '1997-03-24 04:01:12', '2004-06-14 18:15:43', '1993-09-21 22:11:29');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('36', 6, 1, '990810000', '1996-07-18 00:25:32', '1999-10-27 13:11:48', '2001-03-18 08:39:34', '2001-08-14 17:38:26');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('37', 1, 2, '71906200', '2005-10-07 18:33:31', '2005-06-14 17:45:56', '1995-01-06 20:51:31', '2005-04-11 21:11:00');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('38', 2, 3, '357426', '2006-02-09 20:24:13', '2011-09-12 09:20:05', '2013-05-30 12:15:17', '2019-12-24 10:02:19');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('39', 3, 4, '88734700', '2012-09-19 16:16:59', '2004-11-02 22:23:05', '1998-05-24 02:12:08', '2015-05-18 21:37:13');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('40', 4, 5, '77389', '2012-09-29 02:29:22', '2019-11-15 15:58:48', '1993-10-06 17:06:53', '1984-10-07 12:07:39');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('41', 5, 6, '69', '2015-08-07 05:36:06', '2010-08-28 11:04:57', '1994-12-05 18:13:56', '2012-04-12 18:39:50');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('42', 6, 7, '7694', '2015-02-11 13:44:30', '2012-01-01 19:47:05', '1980-06-29 20:08:13', '1988-04-30 22:40:47');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('43', 1, 1, '88780', '2000-09-18 06:36:59', '2013-01-13 04:46:29', '1980-12-19 00:55:02', '1986-08-09 23:29:01');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('44', 2, 2, '727', '2014-02-14 02:33:05', '2017-05-18 20:19:05', '1979-05-27 09:46:48', '1987-09-11 23:24:46');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('45', 3, 3, '30817500', '2019-06-13 01:21:07', '2009-12-28 22:47:22', '1984-05-19 12:44:38', '1970-02-09 12:19:54');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('46', 4, 4, '5', '2006-08-22 13:40:58', '1971-04-18 14:44:27', '2003-11-15 07:38:10', '1978-02-07 21:33:42');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('47', 5, 5, '98', '1979-11-08 20:00:39', '2018-12-12 23:41:46', '2008-12-01 02:55:10', '1995-06-16 18:51:20');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('48', 6, 6, '752', '1973-09-05 07:55:41', '2004-11-08 01:45:47', '1975-05-26 05:17:33', '2011-01-14 04:21:25');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('49', 1, 7, '635858', '2004-04-03 19:18:24', '2014-11-24 13:55:26', '2021-03-03 12:53:57', '1980-05-16 19:53:34');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('50', 2, 1, '745344000', '1983-12-31 17:00:17', '2019-06-01 18:52:19', '1993-08-31 09:12:18', '2020-06-12 21:20:39');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('51', 3, 2, '475', '2001-12-26 01:02:23', '1974-01-31 09:25:09', '1997-10-11 10:33:35', '1994-08-29 23:23:51');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('52', 4, 3, '80184400', '1997-11-29 16:26:34', '2014-06-29 21:17:37', '1991-05-26 13:02:31', '1980-04-15 09:50:45');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('53', 5, 4, '633160000', '2021-08-29 02:21:05', '2010-02-08 19:30:00', '1976-06-06 17:03:24', '1980-03-28 08:33:24');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('54', 6, 5, '951378000', '2021-09-18 13:03:35', '2016-01-11 02:05:51', '2018-03-13 19:24:46', '1999-09-21 16:53:19');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('55', 1, 6, '2988', '1982-02-25 13:18:47', '2004-06-10 07:24:35', '2004-03-04 12:13:11', '1973-06-15 22:39:48');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('56', 2, 7, '96881200', '2003-02-17 08:38:57', '1973-10-05 18:38:07', '2019-02-04 18:41:01', '1995-07-06 19:00:05');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('57', 3, 1, '5747', '2016-11-09 04:46:38', '2000-06-17 06:05:14', '2009-06-16 15:49:51', '2009-12-24 15:14:15');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('58', 4, 2, '7', '1991-05-07 00:11:17', '1983-12-06 04:53:55', '1977-02-18 19:09:38', '2004-08-01 13:02:40');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('59', 5, 3, '41', '1995-06-29 23:06:54', '2012-11-11 11:57:07', '1974-11-15 11:57:04', '2017-07-22 19:52:55');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('60', 6, 4, '304393000', '2020-06-07 03:10:05', '1991-12-13 05:23:17', '1981-02-27 13:17:24', '1971-01-14 13:11:41');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('61', 1, 5, '1', '2013-02-22 10:51:24', '2007-11-03 01:17:28', '2016-09-18 01:37:06', '2002-04-11 04:22:49');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('62', 2, 6, '5944620', '2021-03-24 08:57:20', '2011-10-05 15:11:55', '1979-11-19 08:34:29', '2001-03-04 18:06:43');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('63', 3, 7, '8', '1994-06-10 11:19:21', '1972-07-28 01:57:30', '2018-02-04 09:31:25', '2015-04-05 18:00:21');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('64', 4, 1, '0', '1981-11-05 07:48:57', '1987-07-14 17:24:32', '1984-11-04 08:23:38', '2009-07-06 01:59:06');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('65', 5, 2, '82406', '1988-11-15 14:17:21', '2003-06-02 21:31:28', '1990-03-25 22:50:36', '2003-07-02 04:09:31');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('66', 6, 3, '9063', '2006-12-11 05:41:51', '2021-03-17 18:49:40', '1977-10-24 01:57:08', '2003-07-17 07:57:29');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('67', 1, 4, '81138800', '2007-10-28 05:19:14', '1977-01-14 09:32:52', '2013-04-21 18:25:07', '1970-09-11 15:48:40');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('68', 2, 5, '6724320', '2013-06-12 11:49:13', '2005-12-25 07:35:01', '2018-12-29 16:56:14', '1971-08-27 05:26:16');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('69', 3, 6, '6669840', '2019-06-15 13:52:41', '2004-03-22 11:19:52', '2020-06-05 08:48:31', '1994-07-15 12:57:13');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('70', 4, 7, '67039000', '2014-07-09 13:30:24', '1997-04-19 08:18:10', '1992-08-21 11:26:19', '1983-03-02 22:27:03');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('71', 5, 1, '3', '2011-04-16 04:05:55', '2019-09-27 00:21:35', '2008-09-11 23:49:07', '2009-10-22 21:13:54');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('72', 6, 2, '611', '2012-07-23 18:28:43', '2020-06-15 12:01:29', '2017-05-29 15:48:36', '1982-01-21 20:39:25');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('73', 1, 3, '5', '1970-11-21 10:47:15', '1993-04-01 13:38:20', '1994-11-23 00:44:45', '1991-03-29 03:13:13');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('74', 2, 4, '8', '1983-01-20 04:36:45', '1994-07-05 23:09:33', '1994-05-01 21:31:14', '2004-03-10 12:54:57');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('75', 3, 5, '33', '1984-06-28 14:08:39', '1993-01-02 21:19:35', '2003-01-25 12:01:12', '1982-03-05 17:29:50');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('76', 4, 6, '26802600', '1997-01-01 18:11:58', '1973-08-17 06:53:51', '2000-05-04 21:46:10', '2004-03-14 22:56:54');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('77', 5, 7, '816', '1979-07-20 23:47:11', '1986-08-26 18:20:57', '2009-10-22 03:28:22', '1983-02-14 03:10:08');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('78', 6, 1, '414952', '1996-07-13 04:11:27', '1995-07-02 23:25:53', '2013-03-06 13:15:24', '1990-02-23 21:23:33');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('79', 1, 2, '4', '1999-05-28 18:44:22', '1980-03-20 07:04:21', '2009-10-10 16:58:40', '2005-04-05 23:09:46');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('80', 2, 3, '87011', '1996-02-29 06:39:01', '2020-10-26 08:19:50', '1981-09-29 02:24:00', '2014-11-28 01:54:13');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('81', 3, 4, '0', '2000-06-13 17:31:20', '2006-08-27 04:14:59', '2013-12-06 01:06:07', '1995-03-12 10:18:57');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('82', 4, 5, '17201600', '2001-08-21 10:29:39', '2002-01-12 13:06:36', '1997-09-16 03:55:15', '2017-08-09 03:29:17');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('83', 5, 6, '813', '1996-11-01 14:12:13', '1985-07-16 08:25:15', '2008-10-23 15:48:05', '1990-04-08 08:24:32');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('84', 6, 7, '7305320', '1994-06-06 15:34:57', '2015-01-19 00:36:29', '2006-04-01 11:21:04', '1985-02-28 21:27:52');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('85', 1, 1, '87', '2004-12-09 05:59:36', '1985-01-11 01:37:57', '1971-06-16 15:27:49', '1982-04-21 22:09:48');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('86', 2, 2, '69', '2008-05-11 19:10:09', '1972-11-23 05:08:12', '1975-05-14 13:49:18', '1997-01-20 21:36:08');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('87', 3, 3, '4672', '1977-07-21 21:37:14', '1993-01-15 21:36:15', '2021-01-08 11:49:17', '1978-08-06 15:17:16');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('88', 4, 4, '764540', '1981-02-28 19:46:13', '1987-06-04 20:20:21', '2003-06-01 12:20:07', '2003-06-07 00:44:21');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('89', 5, 5, '888194000', '2011-10-25 13:22:54', '1973-06-29 13:52:43', '1973-04-03 08:28:15', '1994-02-21 23:07:48');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('90', 6, 6, '653556', '2006-08-29 11:14:30', '2014-07-14 16:04:33', '1978-01-25 10:01:49', '1990-06-23 15:14:23');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('91', 1, 7, '0', '2006-09-12 14:34:54', '1972-10-29 18:59:50', '2019-10-13 18:56:28', '1970-06-27 09:28:53');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('92', 2, 1, '18020', '2014-10-07 09:44:46', '1988-08-26 05:40:51', '1973-03-02 22:21:59', '1977-09-26 20:19:37');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('93', 3, 2, '71', '2018-06-02 12:00:05', '1994-01-11 18:37:49', '1990-09-22 05:17:24', '1982-08-04 20:59:07');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('94', 4, 3, '0', '2014-03-22 20:56:45', '1981-08-19 00:53:17', '2010-08-23 13:22:15', '2016-07-19 23:43:08');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('95', 5, 4, '2720', '1985-12-31 04:16:52', '1993-06-05 08:01:28', '2005-05-09 00:56:48', '2008-11-10 22:25:05');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('96', 6, 5, '28788', '1996-05-02 14:05:11', '2018-02-27 12:25:28', '2001-01-27 19:04:53', '2016-08-07 15:10:49');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('97', 1, 6, '27288400', '1999-04-18 08:33:36', '2016-11-07 04:38:29', '2015-01-03 06:13:43', '2006-03-04 12:38:01');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('98', 2, 7, '913', '1997-01-02 01:09:29', '2006-05-21 23:01:23', '1987-08-18 02:14:15', '1971-02-09 19:45:44');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('99', 3, 1, '290', '2004-08-05 05:21:50', '1991-12-27 22:38:12', '2007-12-31 05:36:06', '2001-01-05 20:35:38');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('100', 4, 2, '75810', '1979-07-04 17:28:40', '1974-03-26 03:58:53', '1973-07-26 11:52:21', '2004-01-03 20:32:11');


#
# TABLE STRUCTURE FOR: orders
#

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`)
) COMMENT='Заказы';

INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('1', 1, '1996-07-20 14:00:48', '2003-04-09 09:08:17');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('2', 2, '2020-10-30 13:03:13', '1971-02-05 18:31:03');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('3', 3, '2008-11-23 16:26:16', '1988-03-27 01:34:08');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('4', 4, '1979-02-01 10:34:40', '2007-07-05 16:39:47');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('5', 5, '2000-04-30 12:43:29', '1985-04-29 14:31:17');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('6', 6, '1983-10-19 00:04:52', '1990-09-19 04:07:26');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('7', 1, '2012-03-03 03:07:51', '1998-07-03 06:20:21');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('8', 2, '1983-08-15 21:38:35', '2013-07-31 22:56:51');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('9', 3, '2013-05-21 05:50:01', '1976-06-04 13:38:23');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('10', 4, '1979-02-26 01:15:22', '1987-03-29 06:37:48');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('11', 5, '1985-11-20 07:48:37', '1970-07-23 20:52:38');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('12', 6, '2007-09-22 06:01:26', '1974-05-15 01:35:52');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('13', 1, '2018-02-20 19:15:18', '2015-04-24 17:09:08');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('14', 2, '1973-12-13 08:03:59', '1973-11-15 12:26:19');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('15', 3, '1996-03-08 15:33:36', '1996-04-06 19:16:17');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('16', 4, '1997-03-14 14:18:27', '2005-08-08 17:27:11');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('17', 5, '2012-12-06 03:02:59', '1995-06-08 02:01:48');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('18', 6, '2006-06-04 14:17:33', '2012-12-11 20:24:06');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('19', 1, '1990-06-15 15:14:59', '1988-01-24 16:03:40');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('20', 2, '2014-03-24 08:05:47', '2009-09-26 14:46:18');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('21', 3, '1993-09-27 19:52:18', '1979-09-28 23:14:57');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('22', 4, '1971-03-13 15:31:59', '1995-04-26 05:57:34');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('23', 5, '2002-05-28 14:03:08', '1995-01-14 13:01:59');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('24', 6, '1994-11-01 05:16:43', '1986-03-29 03:41:39');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('25', 1, '1974-01-21 09:15:30', '1987-05-08 02:23:58');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('26', 2, '2009-10-11 13:45:50', '2004-07-27 08:47:53');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('27', 3, '1981-08-23 16:44:04', '1993-03-08 06:29:21');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('28', 4, '1972-12-02 07:07:58', '1994-10-27 14:46:23');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('29', 5, '2021-03-21 06:17:47', '1997-12-05 23:01:07');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('30', 6, '1996-06-11 16:04:22', '2013-10-13 08:41:01');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('31', 1, '1970-09-20 20:22:33', '1970-06-12 14:10:20');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('32', 2, '2006-01-06 12:45:27', '1976-02-26 14:46:40');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('33', 3, '2014-01-07 04:11:12', '1979-09-05 02:23:41');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('34', 4, '1971-08-03 09:30:09', '2021-01-14 18:19:44');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('35', 5, '1983-12-10 02:29:09', '1987-01-08 09:10:52');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('36', 6, '1994-08-10 19:27:25', '2018-01-02 12:54:37');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('37', 1, '2008-05-22 10:07:56', '1989-11-01 02:22:40');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('38', 2, '2004-09-29 19:47:00', '1981-08-06 17:43:41');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('39', 3, '1982-02-11 22:06:00', '2002-11-27 10:13:08');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('40', 4, '2005-02-21 15:14:48', '1994-09-05 12:51:39');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('41', 5, '1982-08-08 05:16:08', '1995-07-09 18:05:26');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('42', 6, '1972-06-03 15:30:00', '2007-01-14 05:15:35');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('43', 1, '1995-03-02 08:15:03', '1985-03-03 03:59:13');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('44', 2, '1972-08-09 11:30:10', '1988-01-21 23:37:46');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('45', 3, '1972-01-27 12:22:37', '2013-05-21 13:36:09');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('46', 4, '1985-02-13 23:24:23', '2007-08-21 09:04:55');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('47', 5, '2020-07-10 06:17:01', '2009-01-07 19:09:49');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('48', 6, '2000-10-25 07:38:46', '2004-10-12 12:54:29');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('49', 1, '1993-02-21 23:05:58', '1988-06-09 04:20:34');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('50', 2, '1989-04-16 16:38:09', '1990-08-23 00:09:34');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('51', 3, '1970-06-24 03:47:46', '1995-02-04 04:43:20');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('52', 4, '1976-06-04 08:27:42', '2007-04-22 16:33:43');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('53', 5, '1984-01-11 21:19:16', '2006-01-19 12:54:37');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('54', 6, '1991-06-16 18:25:44', '2002-08-07 04:18:27');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('55', 1, '1994-09-21 09:44:24', '1986-06-03 06:49:10');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('56', 2, '1981-01-20 06:55:06', '1997-05-20 07:40:10');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('57', 3, '2013-12-14 14:37:20', '2013-08-26 11:48:58');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('58', 4, '1975-11-14 22:49:25', '2005-06-08 08:05:48');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('59', 5, '2010-02-03 17:56:52', '1983-05-26 04:42:07');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('60', 6, '2003-03-24 17:47:42', '2002-05-11 18:10:20');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('61', 1, '2011-02-17 15:22:11', '2014-03-16 10:47:44');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('62', 2, '1985-10-21 17:41:58', '1988-12-16 08:55:29');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('63', 3, '1983-04-22 04:32:51', '2007-03-16 03:38:38');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('64', 4, '2013-03-25 22:39:47', '2004-05-29 22:17:53');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('65', 5, '1972-06-06 10:52:30', '2008-04-23 01:27:53');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('66', 6, '2021-05-27 00:01:44', '2006-05-29 12:55:25');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('67', 1, '2017-11-12 09:53:25', '1982-05-06 02:06:07');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('68', 2, '2010-03-18 15:33:44', '1993-05-22 21:48:09');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('69', 3, '2019-06-05 20:57:21', '1986-04-01 06:24:37');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('70', 4, '2001-09-24 22:42:10', '1996-10-18 10:40:45');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('71', 5, '1987-10-13 20:42:57', '1971-07-04 07:38:17');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('72', 6, '1997-10-01 05:16:39', '2008-08-10 21:32:31');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('73', 1, '2004-10-26 17:32:45', '2008-04-26 06:52:54');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('74', 2, '1991-09-22 02:38:41', '2020-03-31 03:06:26');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('75', 3, '2015-11-28 06:45:50', '2010-04-02 23:46:42');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('76', 4, '1977-07-15 14:31:54', '2005-04-16 08:41:47');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('77', 5, '1975-10-24 16:22:11', '2003-04-29 15:52:38');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('78', 6, '1991-10-18 13:21:29', '1989-11-27 23:19:21');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('79', 1, '2007-03-25 02:25:03', '2019-10-29 01:16:17');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('80', 2, '2000-06-17 09:35:28', '1999-08-05 14:34:12');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('81', 3, '2011-04-03 01:42:34', '1995-08-31 10:23:51');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('82', 4, '1991-07-26 02:51:06', '2019-01-26 05:53:24');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('83', 5, '1994-10-20 01:31:59', '1991-08-01 07:12:37');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('84', 6, '2009-03-27 16:41:18', '1992-06-27 10:18:00');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('85', 1, '2009-06-01 22:03:52', '2012-03-24 07:29:58');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('86', 2, '2004-05-07 22:40:55', '2007-01-19 02:29:00');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('87', 3, '2008-10-22 23:42:07', '1973-11-28 06:51:47');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('88', 4, '1976-04-20 23:27:49', '1971-07-23 01:48:53');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('89', 5, '1992-03-30 13:49:23', '2006-10-05 08:11:09');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('90', 6, '1989-11-07 01:32:01', '2008-09-13 11:05:19');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('91', 1, '1972-08-07 06:29:00', '1994-04-09 08:05:02');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('92', 2, '2001-08-03 08:25:57', '2017-06-15 10:02:03');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('93', 3, '2012-12-05 12:49:03', '1973-09-21 10:11:38');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('94', 4, '2016-04-27 01:01:34', '2021-02-05 13:14:51');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('95', 5, '2004-05-01 09:39:28', '1973-09-16 23:02:58');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('96', 6, '2003-04-29 14:18:50', '2015-08-28 14:33:46');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('97', 1, '2019-09-20 10:59:18', '1989-05-28 01:21:16');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('98', 2, '2011-06-28 11:46:38', '2008-02-01 21:52:59');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('99', 3, '1994-11-09 06:20:01', '2018-12-12 15:11:03');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('100', 4, '1985-10-02 09:44:49', '1988-05-22 11:15:33');


#
# TABLE STRUCTURE FOR: orders_products
#

DROP TABLE IF EXISTS `orders_products`;

CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) COMMENT='Состав заказа';

INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('1', 1, 1, 4, '2008-01-13 06:49:35', '2005-03-12 04:47:09');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('2', 2, 2, 9, '1976-08-12 00:31:45', '1977-01-08 21:49:46');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('3', 3, 3, 3, '1983-05-13 12:41:28', '2021-02-06 09:17:01');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('4', 4, 4, 5, '1987-05-21 15:37:08', '2016-05-28 15:27:33');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('5', 5, 5, 9, '2006-01-07 20:03:26', '1971-03-30 21:10:08');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('6', 6, 6, 8, '1978-08-05 10:38:40', '2004-02-28 07:58:24');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('7', 7, 7, 2, '2004-07-15 02:29:44', '1987-08-06 06:01:19');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('8', 8, 1, 6, '1990-10-31 09:29:45', '2011-04-19 16:14:38');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('9', 9, 2, 6, '1993-05-18 16:08:17', '2019-04-09 01:55:31');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('10', 10, 3, 5, '2020-06-08 00:01:51', '2015-01-02 18:19:40');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('11', 11, 4, 8, '2009-06-02 19:26:10', '1971-04-12 01:27:50');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('12', 12, 5, 1, '1978-04-06 20:53:19', '2019-05-26 05:50:27');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('13', 13, 6, 5, '1981-05-15 04:12:52', '2005-09-17 04:13:16');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('14', 14, 7, 5, '1998-10-03 04:20:04', '1995-12-16 22:54:29');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('15', 15, 1, 1, '1988-08-05 09:24:50', '2001-04-07 04:11:39');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('16', 16, 2, 4, '1985-07-08 05:46:22', '1986-02-18 05:47:37');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('17', 17, 3, 9, '2010-10-24 16:32:29', '1999-05-23 16:44:17');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('18', 18, 4, 0, '2015-12-02 15:19:11', '1972-04-12 22:31:15');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('19', 19, 5, 0, '1973-09-14 19:54:52', '2008-03-01 23:09:19');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('20', 20, 6, 8, '1984-11-01 18:53:40', '2009-10-24 02:05:27');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('21', 21, 7, 0, '1974-05-31 08:03:32', '2019-04-08 10:31:26');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('22', 22, 1, 0, '1994-02-07 04:37:13', '2000-06-01 06:15:03');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('23', 23, 2, 6, '1999-12-02 02:05:52', '1980-06-26 11:39:38');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('24', 24, 3, 5, '1997-02-27 17:10:03', '2017-09-05 14:32:15');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('25', 25, 4, 4, '1977-07-02 16:11:48', '1982-09-20 16:22:16');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('26', 26, 5, 9, '1999-11-01 06:07:29', '2015-05-09 13:19:07');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('27', 27, 6, 7, '2020-12-08 22:47:15', '1997-08-06 02:49:33');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('28', 28, 7, 8, '1972-04-04 21:27:16', '2007-05-26 12:41:43');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('29', 29, 1, 9, '1982-09-16 15:44:47', '2001-02-19 07:47:56');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('30', 30, 2, 7, '1972-05-15 18:50:25', '2014-07-13 19:56:54');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('31', 31, 3, 3, '1992-03-27 05:51:30', '1981-07-02 16:38:31');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('32', 32, 4, 5, '2000-11-08 23:08:53', '2005-10-01 20:48:15');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('33', 33, 5, 4, '2012-10-08 03:45:44', '1979-09-03 16:29:46');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('34', 34, 6, 2, '1995-08-10 04:20:53', '1987-09-27 08:06:30');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('35', 35, 7, 3, '1990-05-13 07:30:17', '1989-08-22 00:25:51');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('36', 36, 1, 6, '2006-06-01 06:42:24', '1997-10-18 12:13:59');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('37', 37, 2, 5, '1999-08-17 19:39:29', '1991-11-07 16:28:02');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('38', 38, 3, 7, '1982-02-18 20:47:43', '1996-05-14 15:32:14');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('39', 39, 4, 0, '1984-03-06 17:44:46', '1987-09-19 14:53:22');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('40', 40, 5, 7, '1976-12-13 20:28:02', '1984-11-24 02:13:15');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('41', 41, 6, 8, '2011-06-12 07:25:59', '1973-01-09 00:16:08');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('42', 42, 7, 8, '1983-02-17 19:56:57', '1996-10-16 10:53:22');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('43', 43, 1, 7, '1982-12-26 09:39:33', '1989-03-20 03:42:22');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('44', 44, 2, 6, '2001-10-10 10:11:31', '2007-02-28 04:12:17');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('45', 45, 3, 3, '2012-09-10 17:32:12', '1991-12-09 05:37:53');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('46', 46, 4, 5, '1993-09-23 16:32:46', '2003-02-09 07:22:21');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('47', 47, 5, 8, '1976-10-27 22:38:16', '1989-05-14 23:55:41');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('48', 48, 6, 9, '1982-04-03 14:40:32', '2016-11-11 20:52:39');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('49', 49, 7, 0, '1990-05-07 12:47:23', '2021-02-03 23:38:01');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('50', 50, 1, 8, '1979-06-07 03:27:52', '1987-07-29 15:26:51');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('51', 51, 2, 1, '2007-05-05 20:53:40', '1979-05-29 12:35:33');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('52', 52, 3, 5, '1992-11-20 00:03:20', '2015-11-08 19:55:45');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('53', 53, 4, 9, '1973-08-25 02:14:00', '1992-01-10 15:00:49');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('54', 54, 5, 0, '1978-01-21 02:58:00', '1972-05-07 00:29:00');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('55', 55, 6, 8, '1996-02-20 01:17:16', '1978-02-02 07:16:34');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('56', 56, 7, 6, '1994-09-26 17:28:47', '1971-06-06 00:07:49');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('57', 57, 1, 1, '2002-11-01 03:31:19', '1974-12-05 00:41:04');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('58', 58, 2, 6, '2013-08-11 06:23:03', '2017-04-02 13:03:26');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('59', 59, 3, 9, '2006-06-27 20:33:54', '1970-05-18 07:09:21');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('60', 60, 4, 3, '1986-06-24 09:54:19', '1975-03-29 17:11:41');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('61', 61, 5, 4, '2001-09-30 12:37:49', '2017-10-16 22:30:31');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('62', 62, 6, 5, '1993-01-09 08:19:09', '1971-06-10 05:25:17');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('63', 63, 7, 9, '1970-01-06 21:08:10', '1991-03-17 00:15:43');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('64', 64, 1, 7, '1985-07-18 04:06:43', '1977-12-15 07:56:07');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('65', 65, 2, 7, '1975-06-22 09:19:45', '2001-03-29 06:08:41');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('66', 66, 3, 9, '1987-04-16 17:12:22', '1999-08-01 08:55:20');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('67', 67, 4, 1, '2017-12-23 04:57:06', '1986-01-29 05:55:15');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('68', 68, 5, 5, '1992-07-01 09:33:27', '2011-02-24 21:41:14');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('69', 69, 6, 5, '2016-09-13 16:24:52', '1976-11-03 10:12:31');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('70', 70, 7, 9, '1995-03-15 06:57:22', '1972-07-14 06:44:29');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('71', 71, 1, 4, '2018-07-26 17:26:30', '2001-05-24 05:48:36');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('72', 72, 2, 5, '1993-12-01 04:47:33', '1973-01-15 21:32:26');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('73', 73, 3, 1, '1973-12-12 02:26:34', '1999-05-05 11:52:49');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('74', 74, 4, 2, '1982-10-10 17:04:21', '1997-06-19 02:23:01');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('75', 75, 5, 6, '2006-04-27 12:09:50', '1971-11-30 02:34:20');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('76', 76, 6, 9, '2020-08-02 10:14:24', '1980-09-04 23:46:23');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('77', 77, 7, 1, '2015-12-21 14:59:34', '1973-08-01 23:17:06');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('78', 78, 1, 0, '1977-11-20 20:18:46', '1983-03-12 03:55:07');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('79', 79, 2, 1, '2000-12-03 15:39:07', '1984-02-03 10:21:00');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('80', 80, 3, 3, '1989-04-16 20:45:05', '1970-02-07 08:01:16');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('81', 81, 4, 0, '2018-03-07 06:17:21', '2004-03-19 08:08:51');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('82', 82, 5, 8, '1981-10-03 09:07:43', '2019-10-02 09:46:58');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('83', 83, 6, 3, '2019-04-03 05:40:56', '1977-10-03 23:13:25');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('84', 84, 7, 3, '2020-04-09 01:21:41', '2015-08-05 00:13:26');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('85', 85, 1, 7, '1981-11-21 08:32:02', '2020-11-27 14:40:23');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('86', 86, 2, 7, '1985-12-10 08:10:49', '2013-08-04 10:57:14');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('87', 87, 3, 9, '2020-01-29 06:44:49', '1980-04-29 10:18:42');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('88', 88, 4, 8, '1991-04-07 01:26:38', '2019-12-20 16:18:59');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('89', 89, 5, 1, '2016-01-20 15:30:16', '1989-02-10 00:56:25');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('90', 90, 6, 5, '1994-06-02 11:06:00', '2006-06-15 20:00:00');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('91', 91, 7, 8, '1971-10-28 01:27:21', '1992-12-23 20:57:57');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('92', 92, 1, 2, '1995-02-27 21:31:25', '2004-07-02 06:34:06');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('93', 93, 2, 4, '2002-05-12 17:06:41', '1991-04-23 10:12:09');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('94', 94, 3, 3, '2020-11-17 06:57:24', '2012-01-24 11:18:05');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('95', 95, 4, 9, '1990-08-08 17:57:14', '1985-11-25 09:50:48');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('96', 96, 5, 2, '1991-05-28 15:03:30', '2007-12-21 17:23:24');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('97', 97, 6, 4, '1976-10-05 09:18:07', '2013-12-28 05:59:06');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('98', 98, 7, 7, '2001-05-27 12:23:58', '1983-11-22 16:52:45');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('99', 99, 1, 4, '1994-02-28 13:33:27', '1991-07-28 23:19:01');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('100', 100, 2, 9, '1972-05-15 23:38:35', '1986-05-26 19:11:29');


#
# TABLE STRUCTURE FOR: products
#

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `description` text DEFAULT NULL COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_catalog_id` (`catalog_id`)
) COMMENT='Товарные позиции';

INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('1', 'Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '7890.00', 1, '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('2', 'Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '12700.00', 1, '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('3', 'AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '4780.00', 1, '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('4', 'AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '7120.00', 1, '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('5', 'ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', '19310.00', 2, '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('6', 'Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', '4790.00', 2, '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('7', 'MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', '5060.00', 2, '2021-09-20 18:18:53', '2021-09-20 18:18:53');


#
# TABLE STRUCTURE FOR: rubrics
#

DROP TABLE IF EXISTS `rubrics`;

CREATE TABLE `rubrics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`)
) COMMENT='Разделы интернет-магазина';

INSERT INTO `rubrics` (`id`, `name`) VALUES ('1', 'Видеокарты');
INSERT INTO `rubrics` (`id`, `name`) VALUES ('2', 'Память');


#
# TABLE STRUCTURE FOR: storehouses
#

DROP TABLE IF EXISTS `storehouses`;

CREATE TABLE `storehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) COMMENT='Склады';

INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'suscipit', '1971-11-11 12:46:17', '1996-09-26 04:44:28');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'qui', '2012-04-03 09:44:01', '1983-12-01 14:42:29');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'tempora', '1979-07-14 10:59:38', '1979-06-26 21:27:30');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('4', 'sunt', '1997-03-14 20:49:47', '1986-04-27 20:14:41');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('5', 'quam', '1977-04-03 00:58:30', '2018-03-21 03:10:27');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('6', 'aut', '1984-02-02 14:24:47', '2008-09-24 23:11:06');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('7', 'nobis', '2003-11-04 05:49:23', '2019-10-07 14:13:10');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('8', 'doloremque', '1983-07-06 09:12:57', '1989-04-12 21:47:27');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('9', 'sequi', '2012-07-31 10:07:03', '2000-06-15 19:27:35');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('10', 'temporibus', '2018-07-30 22:15:11', '2009-11-07 15:14:45');


#
# TABLE STRUCTURE FOR: storehouses_products
#

DROP TABLE IF EXISTS `storehouses_products`;

CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) COMMENT='Запасы на складе';

INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('1', 1, 1, 0, '1989-05-31 17:33:05', '1987-05-24 22:56:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('2', 2, 2, 1, '1980-11-25 05:41:29', '1996-04-21 14:29:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('3', 3, 3, 5, '1987-08-23 11:32:57', '1981-03-07 02:52:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('4', 4, 4, 1, '1986-09-14 10:03:57', '1993-07-28 15:41:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('5', 5, 5, 7, '2015-05-11 14:54:04', '2017-01-05 21:05:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('6', 6, 6, 2, '1987-05-21 02:44:19', '1976-01-23 20:02:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('7', 7, 7, 7, '2017-07-14 15:05:40', '1993-06-13 06:41:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('8', 8, 1, 1, '2007-02-27 20:07:03', '1988-03-14 09:32:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('9', 9, 2, 6, '2003-02-06 03:53:33', '1973-01-27 03:34:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('10', 10, 3, 5, '1997-12-10 10:09:58', '2010-05-23 12:28:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('11', 1, 4, 9, '1994-06-14 23:13:24', '2008-08-02 05:59:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('12', 2, 5, 3, '2010-07-09 16:06:42', '2018-10-11 19:45:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('13', 3, 6, 1, '1994-06-22 19:25:59', '2015-06-30 13:26:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('14', 4, 7, 0, '2009-02-03 00:02:10', '2016-07-05 10:44:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('15', 5, 1, 6, '1993-04-11 15:27:58', '1995-12-08 13:23:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('16', 6, 2, 2, '2006-01-20 09:22:12', '1990-10-14 19:18:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('17', 7, 3, 1, '2009-12-09 03:53:33', '2010-07-04 17:36:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('18', 8, 4, 5, '2016-09-26 15:19:22', '1996-03-23 13:23:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('19', 9, 5, 4, '2000-01-28 09:33:59', '1983-11-20 22:10:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('20', 10, 6, 0, '2000-03-08 23:39:28', '1987-05-30 17:15:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('21', 1, 7, 4, '2011-06-13 01:38:07', '1980-09-08 19:27:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('22', 2, 1, 5, '1987-07-20 19:39:03', '2007-05-20 05:31:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('23', 3, 2, 9, '2017-03-21 13:57:41', '2016-05-09 15:11:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('24', 4, 3, 6, '2002-11-16 07:19:41', '1988-03-26 17:55:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('25', 5, 4, 3, '1973-03-06 13:51:22', '1994-05-04 14:28:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('26', 6, 5, 9, '2003-09-16 12:21:13', '1984-05-26 00:01:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('27', 7, 6, 1, '1978-01-18 09:58:56', '2020-02-10 12:15:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('28', 8, 7, 2, '1970-03-17 20:56:12', '1979-02-28 02:44:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('29', 9, 1, 2, '2020-11-23 22:20:47', '2008-10-22 06:25:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('30', 10, 2, 5, '1980-01-14 19:58:56', '1994-07-08 16:12:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('31', 1, 3, 3, '1990-05-04 02:26:55', '2000-03-01 23:02:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('32', 2, 4, 5, '2010-05-20 09:06:21', '2012-11-07 06:33:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('33', 3, 5, 8, '2001-03-25 04:28:22', '1984-05-31 08:44:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('34', 4, 6, 8, '2020-06-06 05:59:49', '1970-10-15 06:01:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('35', 5, 7, 2, '2010-01-09 06:23:43', '1999-01-12 09:09:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('36', 6, 1, 5, '2000-06-01 00:09:57', '1979-05-22 09:08:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('37', 7, 2, 0, '2013-04-04 12:30:04', '2006-04-02 03:33:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('38', 8, 3, 5, '2003-05-06 13:49:01', '2008-10-21 21:04:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('39', 9, 4, 0, '2006-04-03 02:27:09', '1974-06-11 04:32:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('40', 10, 5, 4, '2007-12-29 13:52:59', '2018-10-13 18:04:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('41', 1, 6, 6, '1983-02-12 02:06:57', '2016-09-15 05:25:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('42', 2, 7, 3, '1992-01-26 15:19:04', '2004-11-09 09:19:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('43', 3, 1, 0, '1970-07-08 02:38:37', '2012-12-13 02:28:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('44', 4, 2, 8, '1991-11-23 12:14:13', '2015-11-20 23:33:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('45', 5, 3, 7, '2019-09-05 01:01:19', '2015-03-11 19:59:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('46', 6, 4, 4, '1997-10-17 02:49:49', '1989-06-11 07:17:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('47', 7, 5, 8, '2017-07-31 19:34:01', '1981-09-17 01:29:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('48', 8, 6, 3, '2010-09-19 23:48:26', '2006-01-31 23:48:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('49', 9, 7, 1, '1999-04-28 10:15:03', '2017-10-26 06:54:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('50', 10, 1, 9, '1977-12-26 06:20:54', '1990-04-03 04:44:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('51', 1, 2, 6, '1975-09-22 17:59:03', '1997-02-03 04:51:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('52', 2, 3, 2, '2013-05-17 03:32:29', '1990-10-30 01:03:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('53', 3, 4, 6, '1973-04-23 02:47:47', '2004-04-23 01:54:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('54', 4, 5, 2, '1992-07-13 13:24:12', '2016-12-05 06:34:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('55', 5, 6, 9, '2008-03-13 04:46:39', '1970-11-12 18:40:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('56', 6, 7, 2, '1980-04-25 18:50:54', '1986-10-21 18:09:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('57', 7, 1, 3, '1996-04-11 10:37:01', '1989-07-15 14:43:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('58', 8, 2, 8, '1975-11-29 11:04:49', '2012-04-17 17:44:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('59', 9, 3, 4, '2004-02-12 20:24:17', '2007-05-13 07:19:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('60', 10, 4, 6, '2012-02-02 21:55:30', '1970-08-30 14:35:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('61', 1, 5, 8, '1973-12-29 15:35:21', '2000-07-27 08:32:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('62', 2, 6, 7, '2005-02-26 09:55:24', '2006-11-11 20:32:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('63', 3, 7, 7, '1978-11-24 01:00:43', '2016-08-29 07:53:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('64', 4, 1, 4, '1989-08-15 04:13:15', '1981-01-20 19:47:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('65', 5, 2, 7, '2012-08-07 07:10:02', '1996-06-03 18:54:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('66', 6, 3, 8, '1973-12-23 17:00:35', '2011-12-19 14:14:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('67', 7, 4, 6, '1984-04-30 19:26:00', '1989-10-17 05:54:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('68', 8, 5, 4, '2013-05-06 01:53:54', '1981-11-25 14:05:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('69', 9, 6, 8, '2017-11-12 18:57:38', '1990-05-09 02:15:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('70', 10, 7, 2, '1989-04-01 04:11:54', '2019-11-07 15:23:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('71', 1, 1, 5, '1980-10-19 04:22:35', '2000-06-20 06:47:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('72', 2, 2, 5, '1991-06-10 10:36:17', '1993-03-06 13:03:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('73', 3, 3, 1, '1984-10-03 01:30:19', '1993-11-14 18:02:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('74', 4, 4, 6, '2003-05-24 06:04:14', '1991-04-17 23:29:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('75', 5, 5, 3, '2006-12-19 21:33:35', '1984-03-11 21:37:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('76', 6, 6, 5, '1999-06-25 10:44:30', '1999-03-08 06:04:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('77', 7, 7, 1, '1998-06-14 09:33:49', '1971-04-22 08:56:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('78', 8, 1, 4, '1998-06-01 02:40:58', '1971-04-23 07:09:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('79', 9, 2, 7, '1974-04-25 15:45:58', '1970-12-26 05:50:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('80', 10, 3, 9, '2015-09-15 08:24:13', '2016-08-30 23:01:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('81', 1, 4, 4, '1998-11-07 13:03:01', '1983-03-08 14:02:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('82', 2, 5, 8, '1975-10-17 12:27:02', '1982-12-08 15:50:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('83', 3, 6, 2, '1986-09-19 23:36:11', '2020-07-20 07:11:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('84', 4, 7, 0, '2019-02-11 06:51:32', '2005-12-07 21:14:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('85', 5, 1, 0, '2018-03-04 07:33:51', '2014-07-10 13:53:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('86', 6, 2, 9, '2004-06-21 11:37:40', '2008-12-11 08:21:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('87', 7, 3, 3, '2019-06-18 01:28:28', '2014-11-02 17:50:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('88', 8, 4, 3, '1982-06-09 09:49:07', '1994-06-01 20:28:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('89', 9, 5, 4, '1987-06-30 14:37:06', '1993-02-03 06:05:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('90', 10, 6, 1, '1996-10-17 08:21:30', '1986-02-04 10:17:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('91', 1, 7, 9, '2019-04-26 04:09:39', '2015-06-26 19:48:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('92', 2, 1, 3, '1974-05-08 02:52:01', '1975-02-01 18:35:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('93', 3, 2, 0, '2020-05-25 09:49:33', '2017-06-24 13:24:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('94', 4, 3, 0, '2018-02-10 00:09:17', '2017-05-22 10:33:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('95', 5, 4, 2, '1972-09-08 05:21:55', '1983-07-01 07:18:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('96', 6, 5, 1, '1989-12-18 17:38:48', '2007-03-14 10:36:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('97', 7, 6, 2, '1978-09-10 10:08:13', '1993-06-10 21:09:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('98', 8, 7, 0, '2013-06-13 17:55:30', '2008-10-10 09:44:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('99', 9, 1, 6, '1981-01-08 22:05:18', '2000-01-08 04:01:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('100', 10, 2, 3, '2016-04-25 14:00:46', '1986-09-04 05:46:57');


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) COMMENT='Покупатели';

INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('1', 'Геннадий', '1990-10-05', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('2', 'Наталья', '1984-11-12', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('3', 'Александр', '1985-05-20', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('4', 'Сергей', '1988-02-14', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('5', 'Иван', '1998-01-12', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('6', 'Мария', '1992-08-29', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('7', 'Максим', '1977-10-15', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('8', 'Петр', '1954-12-02', '2021-09-20 18:18:53', '2021-09-20 18:18:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('9', 'Кирилл', '1995-04-22', '2021-09-20 18:18:53', '2021-09-20 18:18:53');


