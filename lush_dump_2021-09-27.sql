-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: lush
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор статьи',
  `head` varchar(255) NOT NULL COMMENT 'Заголовок статьи',
  `body` text NOT NULL COMMENT 'Текст статьи',
  `catalog_id` int unsigned DEFAULT NULL COMMENT 'Ссылка на раздел каталога, в котором будет видна статья',
  `product_id` int unsigned DEFAULT NULL COMMENT 'Ссылка на продукт, в карточке которого будет статья',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`),
  KEY `articles_catalog_id` (`catalog_id`),
  KEY `articles_product_id` (`product_id`),
  CONSTRAINT `articles_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`),
  CONSTRAINT `articles_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица статей о продуктах, отображаемых в разделах и карточках продуктов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'Пять бестселлеров против пластика в вашей ванной','Как избавиться от ненужной упаковки с продуктами naked care',2,NULL,'2021-09-27 21:47:58','2021-09-27 21:47:58'),(2,'Путешествуйте налегке','Твёрдые самоконсервирующиеся продукты могут стать движением в правильном направлении',6,7,'2021-09-27 21:47:58','2021-09-27 21:47:58'),(3,'Хна','Хна является отличной альтернативой синтетическим краскам для волос',5,NULL,'2021-09-27 21:47:58','2021-09-27 21:47:58'),(4,'Тональная основа','Как выбрать свой идеальный оттенок тональной основы',9,6,'2021-09-27 21:47:58','2021-09-27 21:47:58'),(5,'Твердый гель для душа','Твердые гели для душа не содержат мыльной основы',4,NULL,'2021-09-27 21:47:58','2021-09-27 21:47:58');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_tree`
--

DROP TABLE IF EXISTS `catalog_tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalog_tree` (
  `catalog_id` int unsigned NOT NULL COMMENT 'Ссылка на раздел',
  `parent_id` int unsigned NOT NULL COMMENT 'Ссылка на родительский раздел',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`catalog_id`,`parent_id`) COMMENT 'Составной первичный ключ',
  KEY `catalog_tree_parent_id` (`parent_id`),
  CONSTRAINT `catalog_tree_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`),
  CONSTRAINT `catalog_tree_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `catalogs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Дерево разделов каталога';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_tree`
--

LOCK TABLES `catalog_tree` WRITE;
/*!40000 ALTER TABLE `catalog_tree` DISABLE KEYS */;
INSERT INTO `catalog_tree` VALUES (1,1,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(2,1,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(3,1,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(4,1,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(5,5,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(6,5,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(7,5,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(8,5,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(9,9,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(10,9,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(11,9,'2021-09-26 22:28:53','2021-09-26 22:28:53'),(12,9,'2021-09-26 22:28:53','2021-09-26 22:28:53');
/*!40000 ALTER TABLE `catalog_tree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор раздела',
  `name` varchar(150) NOT NULL COMMENT 'Наименование раздела',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица разделов каталога';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Ванна и душ','2021-09-26 22:28:12','2021-09-26 22:28:12'),(2,'Бомбы для ванны','2021-09-26 22:28:12','2021-09-26 22:28:12'),(3,'Пены для ванны','2021-09-26 22:28:12','2021-09-26 22:28:12'),(4,'Гели для душа','2021-09-26 22:28:12','2021-09-26 22:28:12'),(5,'Волосы','2021-09-26 22:28:12','2021-09-26 22:28:12'),(6,'Шампуни','2021-09-26 22:28:12','2021-09-26 22:28:12'),(7,'Кондиционеры для волос','2021-09-26 22:28:12','2021-09-26 22:28:12'),(8,'Маски, кремы и масло для волос','2021-09-26 22:28:12','2021-09-26 22:28:12'),(9,'Лицо','2021-09-26 22:28:12','2021-09-26 22:28:12'),(10,'Маски для лица','2021-09-26 22:28:12','2021-09-26 22:28:12'),(11,'Очищающие средства','2021-09-26 22:28:12','2021-09-26 22:28:12'),(12,'Кремы','2021-09-26 22:28:12','2021-09-26 22:28:12');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `product_id` int unsigned NOT NULL COMMENT 'Ссылка на продукт',
  `rating` enum('1','2','3','4','5') DEFAULT NULL COMMENT 'Оценка по 5-балльной шкале',
  `comment_text` text NOT NULL COMMENT 'Текст отзыва',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`user_id`,`product_id`) COMMENT 'Составной первичный ключ',
  KEY `comments_product_id` (`product_id`),
  CONSTRAINT `comments_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `comments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица отзывов о продуктах';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,'2','Плохой продукт - не оправдал ожиданий','2021-09-27 22:13:33','2021-09-27 22:13:33'),(2,10,'5','Отличный продукт - очень понравился','2021-09-27 22:13:33','2021-09-27 22:13:33'),(3,1,'4','хороший','2021-09-27 22:13:33','2021-09-27 22:13:33'),(4,8,'3','Так себе','2021-09-27 22:13:33','2021-09-27 22:13:33'),(5,7,'2','Совершенно не годится','2021-09-27 22:13:33','2021-09-27 22:13:33'),(6,2,'5','Прекрасное средство','2021-09-27 22:13:33','2021-09-27 22:13:33'),(7,4,'5','Очень помогло','2021-09-27 22:13:33','2021-09-27 22:13:33'),(8,3,'2','Стало только хуже','2021-09-27 22:13:33','2021-09-27 22:13:33'),(9,3,'3','Ни рыба ни мясо','2021-09-27 22:13:33','2021-09-27 22:13:33'),(10,6,'4','Не идеален но хорош','2021-09-27 22:13:33','2021-09-27 22:13:33');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `product_id` int unsigned NOT NULL COMMENT 'Ссылка на продукт',
  `is_favorite` bit(1) DEFAULT NULL COMMENT 'Статус отметки избранным продуктом - либо выбран, либо выбор снят',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`user_id`,`product_id`) COMMENT 'Составной первичный ключ',
  KEY `favorites_product_id` (`product_id`),
  CONSTRAINT `favorites_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `favorites_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица избранных продуктов пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,2,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01'),(1,5,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01'),(2,4,_binary '\0','2021-09-27 21:59:01','2021-09-27 21:59:01'),(3,1,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01'),(4,9,_binary '\0','2021-09-27 21:59:01','2021-09-27 21:59:01'),(5,2,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01'),(6,5,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01'),(7,1,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01'),(8,7,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01'),(9,10,_binary '\0','2021-09-27 21:59:01','2021-09-27 21:59:01'),(10,2,_binary '','2021-09-27 21:59:01','2021-09-27 21:59:01');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_usage`
--

DROP TABLE IF EXISTS `image_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image_usage` (
  `image_id` int unsigned NOT NULL COMMENT 'Ссылка на изображение',
  `target_id` int unsigned NOT NULL COMMENT 'Ссылка на id объекта, к которому относится изображение',
  `target_type_id` int unsigned NOT NULL COMMENT 'Ссылка на тип объекта, к которому относится изображение',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`image_id`,`target_id`,`target_type_id`) COMMENT 'Составной первичный ключ',
  KEY `image_usage_target_type_id` (`target_type_id`),
  CONSTRAINT `image_usage_image_id` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  CONSTRAINT `image_usage_target_type_id` FOREIGN KEY (`target_type_id`) REFERENCES `target_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица ссылок на картинки в разделах, статьях и карточках продуктов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_usage`
--

LOCK TABLES `image_usage` WRITE;
/*!40000 ALTER TABLE `image_usage` DISABLE KEYS */;
INSERT INTO `image_usage` VALUES (1,1,2,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(2,10,3,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(3,1,1,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(4,8,1,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(5,7,2,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(6,2,3,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(7,4,1,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(8,3,2,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(9,3,3,'2021-09-27 22:08:56','2021-09-27 22:08:56'),(10,6,2,'2021-09-27 22:08:56','2021-09-27 22:08:56');
/*!40000 ALTER TABLE `image_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `filename` varchar(255) NOT NULL COMMENT 'Полный путь к файлу',
  `metadata` json NOT NULL COMMENT 'Метаданные файла (дополнительные параметры картинки)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица изображений';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'https://www.some_server.com/some_directory/7d82745d67','{\"size\": 631270, \"extension\": \"png\", \"resolution\": \"253x972\"}','2021-09-26 23:44:39','2021-09-26 23:44:39'),(2,'https://www.some_server.com/some_directory/fc0e2d2153','{\"size\": 898174, \"extension\": \"png\", \"resolution\": \"881x311\"}','2021-09-26 23:44:40','2021-09-26 23:44:40'),(3,'https://www.some_server.com/some_directory/24face1c5f','{\"size\": 940765, \"extension\": \"png\", \"resolution\": \"658x1068\"}','2021-09-26 23:44:42','2021-09-26 23:44:42'),(4,'https://www.some_server.com/some_directory/a1035bfe3b','{\"size\": 930123, \"extension\": \"png\", \"resolution\": \"249x1057\"}','2021-09-26 23:44:43','2021-09-26 23:44:43'),(5,'https://www.some_server.com/some_directory/7de80b734c','{\"size\": 830017, \"extension\": \"png\", \"resolution\": \"227x248\"}','2021-09-26 23:44:44','2021-09-26 23:44:44'),(6,'https://www.some_server.com/some_directory/91e4d9108f','{\"size\": 355658, \"extension\": \"png\", \"resolution\": \"797x518\"}','2021-09-26 23:44:45','2021-09-26 23:44:45'),(7,'https://www.some_server.com/some_directory/8b15fd65ed','{\"size\": 759381, \"extension\": \"png\", \"resolution\": \"887x757\"}','2021-09-26 23:44:46','2021-09-26 23:44:46'),(8,'https://www.some_server.com/some_directory/84a6b4c52d','{\"size\": 659311, \"extension\": \"png\", \"resolution\": \"617x708\"}','2021-09-26 23:44:47','2021-09-26 23:44:47'),(9,'https://www.some_server.com/some_directory/3b19bbed8c','{\"size\": 633548, \"extension\": \"png\", \"resolution\": \"791x658\"}','2021-09-26 23:44:48','2021-09-26 23:44:48'),(10,'https://www.some_server.com/some_directory/8a4b52b053','{\"size\": 902807, \"extension\": \"png\", \"resolution\": \"467x230\"}','2021-09-26 23:44:49','2021-09-26 23:44:49'),(11,'https://www.some_server.com/some_directory/3fbf3f4516','{\"size\": 73679, \"extension\": \"png\", \"resolution\": \"315x958\"}','2021-09-27 22:15:35','2021-09-27 22:15:35');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор заказа',
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `summa` decimal(11,2) DEFAULT NULL COMMENT 'Сумма заказа',
  `ord_status` enum('Created','In progress','Completed','Cancelled') DEFAULT NULL COMMENT 'Статус заказа',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`),
  KEY `orders_user_id` (`user_id`),
  CONSTRAINT `orders_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица интернет-заказов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,5383.00,'Created','2021-09-27 21:53:10','2021-09-27 21:53:10'),(2,4,1225.00,'In progress','2021-09-27 21:53:10','2021-09-27 21:53:10'),(3,1,12950.00,'Completed','2021-09-27 21:53:10','2021-09-27 21:53:10'),(4,9,4678.00,'Cancelled','2021-09-27 21:53:10','2021-09-27 21:53:10'),(5,2,2999.00,'In progress','2021-09-27 21:53:10','2021-09-27 21:53:10'),(6,5,4625.00,'Created','2021-09-27 21:53:10','2021-09-27 21:53:10'),(7,1,3900.00,'Completed','2021-09-27 21:53:10','2021-09-27 21:53:10'),(8,7,7600.00,'Created','2021-09-27 21:53:10','2021-09-27 21:53:10'),(9,10,8432.00,'Created','2021-09-27 21:53:10','2021-09-27 21:53:10'),(10,2,4530.00,'Completed','2021-09-27 21:53:10','2021-09-27 21:53:10');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_products` (
  `order_id` int unsigned NOT NULL COMMENT 'Ссылка на заказ',
  `product_id` int unsigned NOT NULL COMMENT 'Ссылка на продукт',
  `quantity` int unsigned NOT NULL DEFAULT '1' COMMENT 'Количество заказанных продуктов',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`order_id`,`product_id`) COMMENT 'Составной первичный ключ',
  KEY `orders_products_product_id` (`product_id`),
  CONSTRAINT `orders_products_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `orders_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица продуктов в заказах';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (1,2,1,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(1,5,1,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(2,4,2,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(3,1,1,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(4,9,2,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(5,2,1,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(6,5,1,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(7,1,3,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(8,7,1,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(9,10,4,'2021-09-27 21:56:54','2021-09-27 21:56:54'),(10,2,2,'2021-09-27 21:56:54','2021-09-27 21:56:54');
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор продукта',
  `name` varchar(255) DEFAULT NULL COMMENT 'Название продукта',
  `description` text COMMENT 'Описание продукта',
  `volume` int DEFAULT NULL COMMENT 'Объем или вес единицы продукта',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена продукта',
  `catalog_id` int unsigned NOT NULL COMMENT 'Ссылка на раздел каталога',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  `rating` decimal(5,1) unsigned DEFAULT NULL COMMENT 'Рейтинг продукта',
  PRIMARY KEY (`id`),
  KEY `products_catalog_id` (`catalog_id`),
  CONSTRAINT `products_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица продуктов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Бродяга','Гель для душа с ароматом леса',250,1100.00,4,'2021-09-26 23:37:07','2021-09-26 23:37:07',4.7),(2,'Авокадо','Смягчающее средство для ко-вошинга',100,1000.00,7,'2021-09-26 23:37:07','2021-09-26 23:37:07',4.3),(3,'Пиво для Синтии','Шампунь с пивом',500,1900.00,6,'2021-09-26 23:37:07','2021-09-26 23:37:07',3.9),(4,'Божественное увлажнение','Крем для чувствительной кожи лица',50,2360.00,12,'2021-09-26 23:37:07','2021-09-26 23:37:07',4.5),(5,'Аиша','Свежая маска с антиоксидантами',75,700.00,12,'2021-09-26 23:37:07','2021-09-26 23:37:07',4.5),(6,'Амазонка','Маска для проблемной кожи лица',75,700.00,12,'2021-09-26 23:37:07','2021-09-26 23:37:07',3.5),(7,'Новинка','Твердый шампунь для роста волос',1,750.00,6,'2021-09-26 23:37:07','2021-09-26 23:37:07',4.4),(8,'Основа основ','Маска для волос и кожи головы',225,1400.00,8,'2021-09-26 23:37:07','2021-09-26 23:37:07',5.0),(9,'Coal face','Мягкое очищающее средство',1,800.00,11,'2021-09-26 23:37:07','2021-09-26 23:37:07',5.0),(10,'Беспечная любовь','Бомба для ванны с маслами бергамота и иланг-иланга',1,720.00,2,'2021-09-26 23:37:07','2021-09-26 23:37:07',4.5);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `login_email` varchar(50) DEFAULT NULL COMMENT 'Email для входа',
  `login_phone` varchar(50) DEFAULT NULL COMMENT 'Телефон для входа',
  `passw` varchar(20) NOT NULL COMMENT 'Пароль пользователя',
  `country` varchar(100) DEFAULT NULL COMMENT 'Страна проживания',
  `city` varchar(100) DEFAULT NULL COMMENT 'Город проживания',
  `street` varchar(100) NOT NULL COMMENT 'Улица',
  `house` int NOT NULL COMMENT 'Дом',
  `corp` int DEFAULT NULL COMMENT 'Корпус/строение',
  `apartment` int DEFAULT NULL COMMENT 'Квартира',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица профилей пользователей с адресами доставки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'val_serg@mail.ru','+79267834566','tetge757','Россия','Москва','Ленинский проспект',23,1,115,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(2,'lena345@yandex.ru','+79857009090','08363636','Россия','Санкт-Петербург','Невский проспект',98,NULL,87,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(3,'irina.1985@mail.ru','+79030901123','TrTr_*&7Q','Россия','Воронеж','Лизюкова',5,2,34,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(4,'catalina_ma@me.com','+79254343434','123456','Россия','Москва','Уланский переулок',26,NULL,NULL,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(5,'natapav@yandex.ru','+79061154567','Qwerty123','Россия','Санкт-Петербург','Малая Морская',12,NULL,45,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(6,'4951329087@gmail.com','+79057771124','01011980','Россия','Воронеж','Ленина',2,1,10,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(7,'dmitrieva.mv@mail.ru','+79104535432','Nhjv,jwbg5','Россия','Кронштадт','Коммунистическая',30,NULL,NULL,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(8,'sofi_le@mail.ru','+79110906543','Sonya_2305','Россия','Псков','Барская',3,NULL,30,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(9,'sergey_savitky@bk.ru','+79129066723','RgnThm678','Россия','Самара','Цветочная',76,3,18,'2021-09-26 23:03:04','2021-09-26 23:03:04'),(10,'petrova_olga@gmail.com','+79161090909','LushRussia1','Россия','Москва','1905 года',7,1,NULL,'2021-09-26 23:03:04','2021-09-26 23:03:04');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouses`
--

DROP TABLE IF EXISTS `storehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storehouses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор склада',
  `name` varchar(255) DEFAULT NULL COMMENT 'Название склада',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица складов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses`
--

LOCK TABLES `storehouses` WRITE;
/*!40000 ALTER TABLE `storehouses` DISABLE KEYS */;
INSERT INTO `storehouses` VALUES (1,'Склад Москва','1971-11-11 12:46:17','1996-09-26 04:44:28'),(2,'Склад Нахабино','2012-04-03 09:44:01','1983-12-01 14:42:29'),(3,'Склад Подольск','1979-07-14 10:59:38','1979-06-26 21:27:30');
/*!40000 ALTER TABLE `storehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouses_products`
--

DROP TABLE IF EXISTS `storehouses_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storehouses_products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор позиции',
  `storehouse_id` int unsigned NOT NULL COMMENT 'Ссылка на склад',
  `product_id` int unsigned NOT NULL COMMENT 'Ссылка на продукт',
  `value` int unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`),
  KEY `storehouses_products_storehouse_id` (`storehouse_id`),
  KEY `storehouses_products_product_id` (`product_id`),
  CONSTRAINT `storehouses_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `storehouses_products_storehouse_id` FOREIGN KEY (`storehouse_id`) REFERENCES `storehouses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица запасов продуктов на складе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses_products`
--

LOCK TABLES `storehouses_products` WRITE;
/*!40000 ALTER TABLE `storehouses_products` DISABLE KEYS */;
INSERT INTO `storehouses_products` VALUES (1,1,2,10,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(2,1,5,15,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(3,1,4,20,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(4,1,1,12,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(5,2,9,10,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(6,2,2,7,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(7,2,5,19,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(8,3,1,1,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(9,3,7,16,'2021-09-27 22:04:32','2021-09-27 22:04:32'),(10,3,2,8,'2021-09-27 22:04:32','2021-09-27 22:04:32');
/*!40000 ALTER TABLE `storehouses_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_types`
--

DROP TABLE IF EXISTS `target_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор типа объекта',
  `name` varchar(10) NOT NULL COMMENT 'Наименование типа объекта',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица типов сущностей, где могут использоваться изображения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_types`
--

LOCK TABLES `target_types` WRITE;
/*!40000 ALTER TABLE `target_types` DISABLE KEYS */;
INSERT INTO `target_types` VALUES (1,'catalogs','2021-09-26 23:54:28','2021-09-26 23:54:28'),(2,'products','2021-09-26 23:54:28','2021-09-26 23:54:28'),(3,'articles','2021-09-26 23:54:28','2021-09-26 23:54:28');
/*!40000 ALTER TABLE `target_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор пользователя',
  `first_name` varchar(100) NOT NULL COMMENT 'Имя пользователя',
  `last_name` varchar(100) NOT NULL COMMENT 'Фамилия пользователя',
  `email` varchar(100) NOT NULL COMMENT 'Email пользователя',
  `phone` varchar(12) NOT NULL COMMENT 'Номер телефона пользователя',
  `city` varchar(50) NOT NULL COMMENT 'Город',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Валентина','Сергеева','val_serg@mail.ru','+79267834566','Москва','2021-09-26 22:44:22','2021-09-26 22:44:22'),(2,'Елена','Козлова','lena345@yandex.ru','+79857009090','Санкт-Петербург','2021-09-26 22:44:22','2021-09-26 22:44:22'),(3,'Ирина','Ярцева','irina.1985@mail.ru','+79030901123','Воронеж','2021-09-26 22:44:22','2021-09-26 22:44:22'),(4,'Катерина','Мальгина','catalina_ma@me.com','+79254343434','Москва','2021-09-26 22:44:22','2021-09-26 22:44:22'),(5,'Наталья','Павлова','natapav@yandex.ru','+79061154567','Санкт-Петербург','2021-09-26 22:44:22','2021-09-26 22:44:22'),(6,'Александр','Синицын','4951329087@gmail.com','+79057771124','Воронеж','2021-09-26 22:44:22','2021-09-26 22:44:22'),(7,'Мария','Дмитриева','dmitrieva.mv@mail.ru','+79104535432','Псков','2021-09-26 22:44:22','2021-09-26 22:44:22'),(8,'София','Лебедева','sofi_le@mail.ru','+79110906543','Псков','2021-09-26 22:44:22','2021-09-26 22:44:22'),(9,'Сергей','Савицкий','sergey_savitky@bk.ru','+79129066723','Самара','2021-09-26 22:44:22','2021-09-26 22:44:22'),(10,'Ольга','Петрова','petrova_olga@gmail.com','+79161090909','Москва','2021-09-26 22:44:22','2021-09-26 22:44:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-27 22:16:51
