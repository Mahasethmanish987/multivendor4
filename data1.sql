

DROP TABLE IF EXISTS "accounts_user";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "accounts_user" (
  "id" bigint NOT NULL SERIAL,
  "password" varchar(128) NOT NULL,
  "first_name" varchar(50) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "username" varchar(50) NOT NULL,
  "email" varchar(100) NOT NULL,
  "phone_number" varchar(20) NOT NULL,
  "role" smallint unsigned DEFAULT NULL,
  "date_joined" datetime(6) NOT NULL,
  "last_login" datetime(6) NOT NULL,
  "modified_at" datetime(6) NOT NULL,
  "is_admin" SMALLINT(1) NOT NULL,
  "is_staff" SMALLINT(1) NOT NULL,
  "is_active" SMALLINT(1) NOT NULL,
  "is_superadmin" SMALLINT(1) NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "username" ("username"),
  UNIQUE KEY "email" ("email"),
  UNIQUE KEY "phone_number" ("phone_number"),
  CONSTRAINT "accounts_user_chk_1" CHECK (("role" >= 0))
)  SERIAL=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "accounts_user"
--

LOCK TABLES "accounts_user" WRITE;
/*!40000 ALTER TABLE "accounts_user" DISABLE KEYS */;
INSERT INTO "accounts_user" VALUES (1,'pbkdf2_sha256$870000$IFSyfiFDwGVuE4qZulZoUj$Tmt4OJ/UPk2RHA3XO3wvqZOvqgORS6ByPemvoqdQJBo=','Manish','Mahaseth','Manish','mahasethmanish63@gmail.com','9817680523',NULL,'2024-11-03 12:32:27.966044','2024-11-11 15:37:07.042560','2024-11-04 17:40:38.149271',1,1,1,1),(11,'pbkdf2_sha256$870000$7HFeG4SYbUvLDX1TtcVGlg$mFZtLdWOA13Y6OAGmbuYHrJRxYlXweNmhrU/S/pc6vQ=','Manish','Mahaseh','Manish Mahaseth','mnshmahaseth@gmail.com','54563453453',1,'2024-11-05 04:51:22.829394','2024-11-11 06:44:31.377127','2024-11-07 01:50:53.878130',0,1,1,0),(14,'pbkdf2_sha256$870000$8BIlVPbZUdhPYWyP0iMMdQ$P1rf3xGzNZLrHuab09nvLsW00i06sONvZDp4gPNfouA=','Kajal','Mahaseth','Kajal Mahaseth','mahasethkajal004@gmail.com','4234245343254',1,'2024-11-07 14:21:46.125955','2024-11-10 11:58:03.170150','2024-11-07 14:23:16.492125',0,0,1,0),(16,'pbkdf2_sha256$870000$Z0hm4hP00z4m8GVTxAy0Av$tFspOodyVe0MYQj45eqHr5G5doy6ba0aNtlTMB6ywnY=','Aashik','Mahaseth','Aashik','aashik@gmail.com','5432134254',1,'2024-11-11 14:36:17.714167','2024-11-11 14:48:48.835511','2024-11-11 14:40:48.128955',0,0,1,0),(17,'pbkdf2_sha256$870000$B1YRDkJX4rfadVVYCTVcqX$S9o2TAmGnogap6DZjrLYJAbMpFhc03r4CwYdTiYCqrQ=','Aayansh','Mahaseth','aayansh','aayansh@gmail.com','534575375',1,'2024-11-11 14:37:47.476236','2024-11-11 14:50:22.119547','2024-11-11 14:40:48.137632',0,0,1,0),(18,'pbkdf2_sha256$870000$gF32aNJ89RE93cYWJoME3b$Iz8LoqCsLVmjfpXaulbt03k9G04IgZXBcw7rnAlVw3c=','aakriti','mahaseth','aakriti','aakriti@gmail.com','43524204520',1,'2024-11-11 14:39:50.505641','2024-11-11 14:59:18.020921','2024-11-11 14:40:48.140218',0,0,1,0);
/*!40000 ALTER TABLE "accounts_user" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "accounts_userprofile"
--

DROP TABLE IF EXISTS "accounts_userprofile";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "accounts_userprofile" (
  "id" bigint NOT NULL SERIAL,
  "profile_picture" varchar(100) DEFAULT NULL,
  "cover_photo" varchar(100) DEFAULT NULL,
  "address" varchar(100) DEFAULT NULL,
  "country" varchar(50) DEFAULT NULL,
  "state" varchar(50) DEFAULT NULL,
  "pin_code" varchar(50) DEFAULT NULL,
  "longitude" varchar(50) DEFAULT NULL,
  "latitude" varchar(50) DEFAULT NULL,
  "created_at" datetime(6) NOT NULL,
  "modified_at" datetime(6) NOT NULL,
  "user_id" bigint NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "user_id" ("user_id"),
  CONSTRAINT "accounts_userprofile_user_id_92240672_fk_accounts_user_id" FOREIGN KEY ("user_id") REFERENCES "accounts_user" ("id")
)  SERIAL=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "accounts_userprofile"
--

LOCK TABLES "accounts_userprofile" WRITE;
/*!40000 ALTER TABLE "accounts_userprofile" DISABLE KEYS */;
INSERT INTO "accounts_userprofile" VALUES (1,'','',NULL,NULL,NULL,NULL,NULL,NULL,'2024-11-04 09:24:04.178438','2024-11-11 15:37:07.044651',1),(12,'users/profile_picture/bking.png','users/cover_photo/blogs-food-bakery-08-180x135.jpg','Kathmandu, Nepal','Nepal','Bagmati Province','44600','85.3221634','27.7103145','2024-11-05 04:51:22.841485','2024-11-11 06:47:00.890668',11),(14,'users/profile_picture/fb-restaurant-12.png','users/cover_photo/bg-image1.jpg','Nepal Eye Hospital., Kathmandu, Nepal',NULL,NULL,NULL,NULL,NULL,'2024-11-07 14:21:46.141516','2024-11-10 11:58:03.175766',14),(16,'users/profile_picture/food-icon-02-1.png','users/cover_photo/fb-restaurant-06.jpg','Seto Pool, Kathmandu, Nepal','Nepal','Bagmati Province','44600','85.3358073','27.703005','2024-11-11 14:36:17.726170','2024-11-11 14:49:59.896693',16),(17,'users/profile_picture/coffee-1.png','users/cover_photo/logo.png','Dillibazar Pipal Bot, Kathmandu, Nepal','Nepal','Bagmati Province','44605','85.32927130000002','27.7049971','2024-11-11 14:37:47.487938','2024-11-11 14:50:22.121746',17),(18,'users/profile_picture/2_QQOIqD0.png','users/cover_photo/fb-restaurant-13.png','Kathmandu Fun Park, Pradarshani Marg, Kathmandu, Nepal','Nepal','Bagmati Province','44600','85.32039809999999','27.701377','2024-11-11 14:39:50.517094','2024-11-11 15:04:14.301417',18);
/*!40000 ALTER TABLE "accounts_userprofile" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "auth_group"
--

DROP TABLE IF EXISTS "auth_group";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "auth_group" (
  "id" int NOT NULL SERIAL,
  "name" varchar(150) NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "name" ("name")
)  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "auth_group"
--

LOCK TABLES "auth_group" WRITE;
/*!40000 ALTER TABLE "auth_group" DISABLE KEYS */;
/*!40000 ALTER TABLE "auth_group" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "auth_group_permissions"
--

DROP TABLE IF EXISTS "auth_group_permissions";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "auth_group_permissions" (
  "id" bigint NOT NULL SERIAL,
  "group_id" int NOT NULL,
  "permission_id" int NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ("group_id","permission_id"),
  KEY "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" ("permission_id"),
  CONSTRAINT "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id"),
  CONSTRAINT "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id")
)  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "auth_group_permissions"
--

LOCK TABLES "auth_group_permissions" WRITE;
/*!40000 ALTER TABLE "auth_group_permissions" DISABLE KEYS */;
/*!40000 ALTER TABLE "auth_group_permissions" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "auth_permission"
--

DROP TABLE IF EXISTS "auth_permission";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "auth_permission" (
  "id" int NOT NULL SERIAL,
  "name" varchar(255) NOT NULL,
  "content_type_id" int NOT NULL,
  "codename" varchar(100) NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "auth_permission_content_type_id_codename_01ab375a_uniq" ("content_type_id","codename"),
  CONSTRAINT "auth_permission_content_type_id_2f476e4b_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id")
)  SERIAL=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "auth_permission"
--

LOCK TABLES "auth_permission" WRITE;
/*!40000 ALTER TABLE "auth_permission" DISABLE KEYS */;
INSERT INTO "auth_permission" VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add user profile',7,'add_userprofile'),(26,'Can change user profile',7,'change_userprofile'),(27,'Can delete user profile',7,'delete_userprofile'),(28,'Can view user profile',7,'view_userprofile'),(29,'Can add vendor',8,'add_vendor'),(30,'Can change vendor',8,'change_vendor'),(31,'Can delete vendor',8,'delete_vendor'),(32,'Can view vendor',8,'view_vendor'),(33,'Can add food item',9,'add_fooditem'),(34,'Can change food item',9,'change_fooditem'),(35,'Can delete food item',9,'delete_fooditem'),(36,'Can view food item',9,'view_fooditem'),(37,'Can add category',10,'add_category'),(38,'Can change category',10,'change_category'),(39,'Can delete category',10,'delete_category'),(40,'Can view category',10,'view_category'),(41,'Can add cart',11,'add_cart'),(42,'Can change cart',11,'change_cart'),(43,'Can delete cart',11,'delete_cart'),(44,'Can view cart',11,'view_cart');
/*!40000 ALTER TABLE "auth_permission" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "django_admin_log"
--

DROP TABLE IF EXISTS "django_admin_log";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "django_admin_log" (
  "id" int NOT NULL SERIAL,
  "action_time" datetime(6) NOT NULL,
  "object_id" longtext,
  "object_repr" varchar(200) NOT NULL,
  "action_flag" smallint unsigned NOT NULL,
  "change_message" longtext NOT NULL,
  "content_type_id" int DEFAULT NULL,
  "user_id" bigint NOT NULL,
  PRIMARY KEY ("id"),
  KEY "django_admin_log_content_type_id_c4bce8eb_fk_django_co" ("content_type_id"),
  KEY "django_admin_log_user_id_c564eba6_fk_accounts_user_id" ("user_id"),
  CONSTRAINT "django_admin_log_content_type_id_c4bce8eb_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id"),
  CONSTRAINT "django_admin_log_user_id_c564eba6_fk_accounts_user_id" FOREIGN KEY ("user_id") REFERENCES "accounts_user" ("id"),
  CONSTRAINT "django_admin_log_chk_1" CHECK (("action_flag" >= 0))
)  SERIAL=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "django_admin_log"
--

LOCK TABLES "django_admin_log" WRITE;
/*!40000 ALTER TABLE "django_admin_log" DISABLE KEYS */;
INSERT INTO "django_admin_log" VALUES (1,'2024-11-03 12:46:09.395608','1','mahasethmanish63@gmail.com',2,'[{\"changed\": {\"fields\": [\"First name\"]}}]',6,1),(2,'2024-11-03 12:46:42.300028','1','mahasethmanish63@gmail.com',2,'[{\"changed\": {\"fields\": [\"First name\"]}}]',6,1),(3,'2024-11-03 12:47:10.377690','1','mahasethmanish63@gmail.com',2,'[{\"changed\": {\"fields\": [\"First name\"]}}]',6,1),(4,'2024-11-03 13:08:34.314841','1','mahasethmanish63@gmail.com',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,1),(5,'2024-11-03 13:13:26.945561','1','mahasethmanish63@gmail.com',2,'[{\"changed\": {\"fields\": [\"First name\"]}}]',6,1),(6,'2024-11-04 07:16:58.723436','2','mahasethkajal004@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',6,1),(7,'2024-11-04 09:24:17.345628','2','mahasethkajal004@gmail.com',2,'[]',6,1),(8,'2024-11-04 09:25:09.878082','2','mahasethkajal004@gmail.com',3,'',7,1),(9,'2024-11-04 09:25:15.680982','2','mahasethkajal004@gmail.com',2,'[]',6,1),(10,'2024-11-04 09:47:17.729813','3','mahasethkajal004@gmail.com',2,'[{\"changed\": {\"fields\": [\"Profile picture\"]}}]',7,1),(11,'2024-11-04 13:12:06.749831','4','mnshmahaseth004@gmail.com',2,'[{\"changed\": {\"fields\": [\"First name\"]}}]',6,1),(12,'2024-11-04 13:14:14.183554','4','mnshmahaseth004@gmail.com',2,'[{\"changed\": {\"fields\": [\"Phone number\"]}}]',6,1),(13,'2024-11-04 13:16:39.805334','4','mnshmahaseth004@gmail.com',2,'[]',6,1),(14,'2024-11-04 13:21:32.467980','4','mnshmahaseth004@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',6,1),(15,'2024-11-04 15:45:26.687871','2','mahasethkajal004@gmail.com',3,'',6,1),(16,'2024-11-04 15:45:26.687871','3','mnshmahaseth@gmail.com',3,'',6,1),(17,'2024-11-04 15:45:26.687871','4','mnshmahaseth004@gmail.com',3,'',6,1),(18,'2024-11-04 15:47:08.926211','5','mahasethkajal004@gmail.com',3,'',6,1),(19,'2024-11-05 02:48:26.533174','6','mahasethkajal004@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',6,1),(20,'2024-11-05 02:49:14.329599','6','mahasethkajal004@gmail.com',3,'',6,1),(21,'2024-11-05 02:49:14.329599','7','mnshmahaseth@gmail.com',3,'',6,1),(22,'2024-11-05 03:09:44.538669','9','mnshmahaseth@gmail.com',3,'',6,1),(23,'2024-11-05 04:47:19.110114','10','mnshmahaseth@gmail.com',3,'',6,1),(24,'2024-11-05 08:40:18.130510','9','mahasethkajal004@gmail.com',2,'[{\"changed\": {\"fields\": [\"Profile picture\"]}}]',7,1),(25,'2024-11-05 14:42:21.260244','9','mahasethkajal004@gmail.com',2,'[{\"changed\": {\"fields\": [\"Cover photo\"]}}]',7,1),(26,'2024-11-05 15:01:22.458979','3','Manish Restaurant',2,'[]',8,1),(27,'2024-11-05 15:59:51.169273','3','Manish Restaurant',2,'[{\"changed\": {\"fields\": [\"Is approved\"]}}]',8,1),(28,'2024-11-05 16:01:38.159605','3','Manish Restaurant',2,'[{\"changed\": {\"fields\": [\"Is approved\"]}}]',8,1),(29,'2024-11-06 10:38:51.031150','12','mnshmahaseth@gmail.com',2,'[{\"changed\": {\"fields\": [\"Address\"]}}]',7,1),(30,'2024-11-06 14:58:50.330363','1','Biryani',1,'[{\"added\": {}}]',10,1),(31,'2024-11-07 01:50:53.879918','11','mnshmahaseth@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is staff\"]}}]',6,1),(32,'2024-11-07 09:01:31.572688','3','Manish Restaurant',2,'[{\"changed\": {\"fields\": [\"Is approved\"]}}]',8,1),(33,'2024-11-07 13:58:43.553836','8','mahasethkajal004@gmail.com',3,'',6,1),(34,'2024-11-07 14:20:24.619838','12','mahasethkajal004@gmail.com',3,'',6,1),(35,'2024-11-07 14:47:44.076297','4','Pizza King',2,'[{\"changed\": {\"fields\": [\"Is approved\"]}}]',8,1),(36,'2024-11-10 11:57:02.369707','7','Cart object (7)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',11,1),(37,'2024-11-10 11:57:07.988877','6','Cart object (6)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',11,1),(38,'2024-11-10 11:57:13.864053','1','Cart object (1)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',11,1),(39,'2024-11-10 12:03:19.156342','7','Cart object (7)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',11,1),(40,'2024-11-10 12:03:24.865285','6','Cart object (6)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',11,1),(41,'2024-11-10 12:03:30.590822','5','Cart object (5)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',11,1),(42,'2024-11-10 12:03:35.651667','4','Cart object (4)',2,'[{\"changed\": {\"fields\": [\"Quantity\"]}}]',11,1),(43,'2024-11-10 12:07:24.468315','7','Cart object (7)',3,'',11,1),(44,'2024-11-10 12:07:24.468315','6','Cart object (6)',3,'',11,1),(45,'2024-11-10 12:07:24.468315','5','Cart object (5)',3,'',11,1),(46,'2024-11-10 12:07:24.468315','4','Cart object (4)',3,'',11,1),(47,'2024-11-10 12:07:24.468315','3','Cart object (3)',3,'',11,1),(48,'2024-11-10 12:07:24.468315','2','Cart object (2)',3,'',11,1),(49,'2024-11-10 12:07:24.468315','1','Cart object (1)',3,'',11,1),(50,'2024-11-11 00:43:50.467016','14','Cart object (14)',3,'',11,1),(51,'2024-11-11 00:43:50.467016','12','Cart object (12)',3,'',11,1),(52,'2024-11-11 00:43:50.467016','11','Cart object (11)',3,'',11,1),(53,'2024-11-11 14:15:06.588148','15','aashik@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',6,1),(54,'2024-11-11 14:17:43.058881','15','aashik@gmail.com',3,'',6,1),(55,'2024-11-11 14:40:48.136315','16','aashik@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',6,1),(56,'2024-11-11 14:40:48.139646','17','aayansh@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',6,1),(57,'2024-11-11 14:40:48.144264','18','aakriti@gmail.com',2,'[{\"changed\": {\"fields\": [\"Is active\"]}}]',6,1),(58,'2024-11-11 14:41:04.029073','7','aakriti restaurant',2,'[{\"changed\": {\"fields\": [\"Is approved\"]}}]',8,1),(59,'2024-11-11 14:41:08.200206','6','aayansh restaurant',2,'[{\"changed\": {\"fields\": [\"Is approved\"]}}]',8,1),(60,'2024-11-11 14:41:12.446656','5','Aashik Restaurant',2,'[{\"changed\": {\"fields\": [\"Is approved\"]}}]',8,1);
/*!40000 ALTER TABLE "django_admin_log" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "django_content_type"
--

DROP TABLE IF EXISTS "django_content_type";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "django_content_type" (
  "id" int NOT NULL SERIAL,
  "app_label" varchar(100) NOT NULL,
  "model" varchar(100) NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "django_content_type_app_label_model_76bd3d3b_uniq" ("app_label","model")
)  SERIAL=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "django_content_type"
--

LOCK TABLES "django_content_type" WRITE;
/*!40000 ALTER TABLE "django_content_type" DISABLE KEYS */;
INSERT INTO "django_content_type" VALUES (6,'accounts','user'),(7,'accounts','userprofile'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(11,'marketplace','cart'),(10,'menu','category'),(9,'menu','fooditem'),(5,'sessions','session'),(8,'vendor','vendor');
/*!40000 ALTER TABLE "django_content_type" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "django_migrations"
--

DROP TABLE IF EXISTS "django_migrations";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "django_migrations" (
  "id" bigint NOT NULL SERIAL,
  "app" varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL,
  "applied" datetime(6) NOT NULL,
  PRIMARY KEY ("id")
)  SERIAL=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "django_migrations"
--

LOCK TABLES "django_migrations" WRITE;
/*!40000 ALTER TABLE "django_migrations" DISABLE KEYS */;
INSERT INTO "django_migrations" VALUES (1,'accounts','0001_initial','2024-11-03 12:29:06.586632'),(2,'contenttypes','0001_initial','2024-11-03 12:29:06.628640'),(3,'admin','0001_initial','2024-11-03 12:29:06.746016'),(4,'admin','0002_logentry_remove_auto_add','2024-11-03 12:29:06.746016'),(5,'admin','0003_logentry_add_action_flag_choices','2024-11-03 12:29:06.755782'),(6,'contenttypes','0002_remove_content_type_name','2024-11-03 12:29:06.814069'),(7,'auth','0001_initial','2024-11-03 12:29:07.008696'),(8,'auth','0002_alter_permission_name_max_length','2024-11-03 12:29:07.051451'),(9,'auth','0003_alter_user_email_max_length','2024-11-03 12:29:07.066609'),(10,'auth','0004_alter_user_username_opts','2024-11-03 12:29:07.073447'),(11,'auth','0005_alter_user_last_login_null','2024-11-03 12:29:07.076629'),(12,'auth','0006_require_contenttypes_0002','2024-11-03 12:29:07.076629'),(13,'auth','0007_alter_validators_add_error_messages','2024-11-03 12:29:07.081029'),(14,'auth','0008_alter_user_username_max_length','2024-11-03 12:29:07.087370'),(15,'auth','0009_alter_user_last_name_max_length','2024-11-03 12:29:07.089132'),(16,'auth','0010_alter_group_name_max_length','2024-11-03 12:29:07.102631'),(17,'auth','0011_update_proxy_permissions','2024-11-03 12:29:07.109476'),(18,'auth','0012_alter_user_first_name_max_length','2024-11-03 12:29:07.115075'),(19,'sessions','0001_initial','2024-11-03 12:29:07.150324'),(20,'accounts','0002_userprofile','2024-11-04 09:19:18.586239'),(21,'vendor','0001_initial','2024-11-04 10:22:52.794689'),(22,'menu','0001_initial','2024-11-06 11:11:11.239825'),(23,'menu','0002_alter_category_category_name','2024-11-06 11:12:06.694747'),(24,'menu','0003_fooditem_price','2024-11-06 14:57:44.622485'),(25,'marketplace','0001_initial','2024-11-07 03:10:19.538772'),(26,'menu','0004_alter_category_category_name_alter_category_slug','2024-11-07 14:30:23.234522'),(27,'marketplace','0002_cart_created_at_alter_cart_updated_at','2024-11-11 03:19:16.810578'),(28,'menu','0005_alter_fooditem_category','2024-11-11 03:19:16.822335'),(29,'accounts','0003_alter_userprofile_address','2024-11-11 15:03:15.229488');
/*!40000 ALTER TABLE "django_migrations" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "django_session"
--

DROP TABLE IF EXISTS "django_session";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "django_session" (
  "session_key" varchar(40) NOT NULL,
  "session_data" longtext NOT NULL,
  "expire_date" datetime(6) NOT NULL,
  PRIMARY KEY ("session_key"),
  KEY "django_session_expire_date_a5c62663" ("expire_date")
)  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "django_session"
--

LOCK TABLES "django_session" WRITE;
/*!40000 ALTER TABLE "django_session" DISABLE KEYS */;
INSERT INTO "django_session" VALUES ('557u6ilrx566sfy6vz21ojzmmb98abkn','.eJxVjMsOwiAQRf-FtSEMjyl16d5vIAMMUjU0Ke3K-O_apAvd3nPOfYlA21rD1nkJUxZnAeL0u0VKD247yHdqt1mmua3LFOWuyIN2eZ0zPy-H-3dQqddvbQgsGesHh8mV4qPjyB7Ra58gASlAVRywTgqViWgdejdq0kqPZsgg3h_J9Tao:1t8yOA:4hZKAezoHUEgqAkWObDHWhbDOIkzK18VMkdB53LdcPE','2024-11-21 09:01:14.198519'),('7gqil1z94khbaqjawo3nw8nzuy8sc41f','.eJxVjMsOwiAQRf-FtSEMjyl16d5vIAMMUjU0Ke3K-O_apAvd3nPOfYlA21rD1nkJUxZnAeL0u0VKD247yHdqt1mmua3LFOWuyIN2eZ0zPy-H-3dQqddvbQgsGesHh8mV4qPjyB7Ra58gASlAVRywTgqViWgdejdq0kqPZsgg3h_J9Tao:1tAWTT:xSrXu_O1gJYZekvjbdhr0JsGohpT1bpLexb22PN2pRM','2024-11-25 15:37:07.051005'),('nwllwe9p607re8n1li18pjlilpzt9y7m','.eJxVjEEOgjAQRe_StWmm1MLg0j1nINPOjEVNSSisjHdXEha6_e-9_zIjbWsetyrLOLG5GOfM6XeMlB5SdsJ3KrfZprmsyxTtrtiDVjvMLM_r4f4dZKr5W3sC7lrfhuBDJxCwD0kVooI64UQRmoDYsyiqoLrWNckDMXYkMeLZvD8HNzic:1t8MDu:eR96YTtaBu99yhXqLwOhEFQCH2AeqDr4q9Z1TF-sySc','2024-11-19 16:16:06.431471'),('p6r9q4fgf8t393s07s1edcl6omr8mcy9','e30:1t7uKJ:h9gDVDYUZOshA6escqUExxoS365cg_xuqH_yuEtPo5s','2024-11-18 10:28:51.453725'),('u7wb5390y6dqllh6rsnvnzoqi7s5qjr8','.eJxVjMsOwiAQRf-FtSEMjyl16d5vIAMMUjU0Ke3K-O_apAvd3nPOfYlA21rD1nkJUxZnAeL0u0VKD247yHdqt1mmua3LFOWuyIN2eZ0zPy-H-3dQqddvbQgsGesHh8mV4qPjyB7Ra58gASlAVRywTgqViWgdejdq0kqPZsgg3h_J9Tao:1t9zh7:PP_MFX_YexNCDsjSBJrwir5p9Tf1BUyl9hnS4foLJ_E','2024-11-24 04:37:01.154956'),('x3txrfp1ngdqro7o8ac15co1b1pb50as','.eJxVjEEOgjAQRe_StWmm1MLg0j1nINPOjEVNSSisjHdXEha6_e-9_zIjbWsetyrLOLG5GOfM6XeMlB5SdsJ3KrfZprmsyxTtrtiDVjvMLM_r4f4dZKr5W3sC7lrfhuBDJxCwD0kVooI64UQRmoDYsyiqoLrWNckDMXYkMeLZvD8HNzic:1t949C:-pyMGL4mDZUp_hfq6mLTTKAkmthGiWXKHoH8AaR1fts','2024-11-21 15:10:10.304162');
/*!40000 ALTER TABLE "django_session" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "marketplace_cart"
--

DROP TABLE IF EXISTS "marketplace_cart";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "marketplace_cart" (
  "id" bigint NOT NULL SERIAL,
  "quantity" int unsigned NOT NULL,
  "updated_at" datetime(6) NOT NULL,
  "fooditem_id" bigint NOT NULL,
  "user_id" bigint NOT NULL,
  "created_at" datetime(6) NOT NULL,
  PRIMARY KEY ("id"),
  KEY "marketplace_cart_fooditem_id_350555bd_fk_menu_fooditem_id" ("fooditem_id"),
  KEY "marketplace_cart_user_id_2963f0ea_fk_accounts_user_id" ("user_id"),
  CONSTRAINT "marketplace_cart_fooditem_id_350555bd_fk_menu_fooditem_id" FOREIGN KEY ("fooditem_id") REFERENCES "menu_fooditem" ("id"),
  CONSTRAINT "marketplace_cart_user_id_2963f0ea_fk_accounts_user_id" FOREIGN KEY ("user_id") REFERENCES "accounts_user" ("id"),
  CONSTRAINT "marketplace_cart_chk_1" CHECK (("quantity" >= 0))
)  SERIAL=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "marketplace_cart"
--

LOCK TABLES "marketplace_cart" WRITE;
/*!40000 ALTER TABLE "marketplace_cart" DISABLE KEYS */;
/*!40000 ALTER TABLE "marketplace_cart" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "menu_category"
--

DROP TABLE IF EXISTS "menu_category";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "menu_category" (
  "id" bigint NOT NULL SERIAL,
  "category_name" varchar(50) NOT NULL,
  "slug" varchar(100) NOT NULL,
  "description" longtext NOT NULL,
  "created_at" datetime(6) NOT NULL,
  "updated_at" datetime(6) NOT NULL,
  "vendor_id" bigint NOT NULL,
  PRIMARY KEY ("id"),
  KEY "menu_category_vendor_id_1b7acda7_fk_vendor_vendor_id" ("vendor_id"),
  KEY "menu_category_slug_9da38891" ("slug"),
  CONSTRAINT "menu_category_vendor_id_1b7acda7_fk_vendor_vendor_id" FOREIGN KEY ("vendor_id") REFERENCES "vendor_vendor" ("id")
)  SERIAL=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "menu_category"
--

LOCK TABLES "menu_category" WRITE;
/*!40000 ALTER TABLE "menu_category" DISABLE KEYS */;
INSERT INTO "menu_category" VALUES (4,'Biryani','biryani','Biryani is a ver good food.','2024-11-07 02:18:24.655651','2024-11-07 02:18:24.655651',3),(5,'Biryani','biryani','Biryani is a very good food.','2024-11-07 14:31:46.638426','2024-11-07 14:31:46.638426',4),(6,'Burger','burger','Bureger is a very good food.','2024-11-07 15:10:48.245956','2024-11-07 15:10:48.245956',3),(7,'Pizza','pizza','Pizza is a very good food.','2024-11-07 15:27:38.777464','2024-11-07 15:27:38.777464',3),(8,'Biryani','biryani','Biryani is a very good food.','2024-11-11 14:42:31.803083','2024-11-11 14:42:31.803083',6),(9,'Burger','burger','Burger is a very good food.','2024-11-11 14:42:55.830640','2024-11-11 14:42:55.830640',6);
/*!40000 ALTER TABLE "menu_category" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "menu_fooditem"
--

DROP TABLE IF EXISTS "menu_fooditem";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "menu_fooditem" (
  "id" bigint NOT NULL SERIAL,
  "food_title" varchar(50) NOT NULL,
  "slug" varchar(100) NOT NULL,
  "description" longtext NOT NULL,
  "image" varchar(100) NOT NULL,
  "is_available" SMALLINT(1) NOT NULL,
  "created_at" datetime(6) NOT NULL,
  "updated_at" datetime(6) NOT NULL,
  "category_id" bigint NOT NULL,
  "vendor_id" bigint NOT NULL,
  "price" decimal(10,2) NOT NULL,
  PRIMARY KEY ("id"),
  KEY "menu_fooditem_category_id_944b9a6c_fk_menu_category_id" ("category_id"),
  KEY "menu_fooditem_vendor_id_02ed1912_fk_vendor_vendor_id" ("vendor_id"),
  KEY "menu_fooditem_slug_d569736b" ("slug"),
  CONSTRAINT "menu_fooditem_category_id_944b9a6c_fk_menu_category_id" FOREIGN KEY ("category_id") REFERENCES "menu_category" ("id"),
  CONSTRAINT "menu_fooditem_vendor_id_02ed1912_fk_vendor_vendor_id" FOREIGN KEY ("vendor_id") REFERENCES "vendor_vendor" ("id")
)  SERIAL=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "menu_fooditem"
--

LOCK TABLES "menu_fooditem" WRITE;
/*!40000 ALTER TABLE "menu_fooditem" DISABLE KEYS */;
INSERT INTO "menu_fooditem" VALUES (3,'Burger One','burger-one','Bureger one is a very good food.','foodimage/blogs-food-bakery-02-1-150x150.jpg',1,'2024-11-07 15:11:51.856654','2024-11-07 15:11:51.856654',6,3,10.00),(4,'Biryani One','biryani-one','Biryani one is a very good food.','foodimage/istockphoto-1294137593-612x612.jpg',1,'2024-11-07 15:12:52.992209','2024-11-07 15:22:44.581107',4,3,9.86),(5,'Biryani Two','biryani-two','Biryan Two is a very good food.','foodimage/istockphoto-867506712-612x612.jpg',1,'2024-11-07 15:22:30.323822','2024-11-07 15:22:30.323822',4,3,10.00),(6,'Biryani Three','biryani-three','Biryani Three is a very good food.','foodimage/istockphoto-1800405129-612x612.jpg',1,'2024-11-07 15:23:22.715219','2024-11-07 15:23:22.715219',4,3,10.00),(7,'Pizza One','pizza-one','Pizza one is a very good food.','foodimage/istockphoto-1042948900-612x612.jpg',1,'2024-11-07 15:29:52.103797','2024-11-07 15:29:52.103797',7,3,10.00),(8,'Pizza Two','pizza-two','Pizza Two is a very good food.','foodimage/istockphoto-1459715799-612x612.jpg',1,'2024-11-07 15:30:58.923834','2024-11-07 15:30:58.923834',7,3,10.00),(9,'Biryani One','biryani-one','Biryani one is a very good food.','foodimage/cover-photo22-150x150_y2ijyRp.jpg',1,'2024-11-11 14:43:43.509517','2024-11-11 14:43:43.509517',8,6,10.00);
/*!40000 ALTER TABLE "menu_fooditem" ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table "vendor_vendor"
--

DROP TABLE IF EXISTS "vendor_vendor";
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE "vendor_vendor" (
  "id" bigint NOT NULL SERIAL,
  "vendor_name" varchar(50) NOT NULL,
  "vendor_license" varchar(100) NOT NULL,
  "vendor_slug" varchar(100) NOT NULL,
  "is_approved" SMALLINT(1) NOT NULL,
  "created_at" datetime(6) NOT NULL,
  "modified_at" datetime(6) NOT NULL,
  "user_id" bigint NOT NULL,
  "user_profile_id" bigint NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE KEY "user_id" ("user_id"),
  UNIQUE KEY "user_profile_id" ("user_profile_id"),
  KEY "vendor_vendor_vendor_slug_d6cc64eb" ("vendor_slug"),
  CONSTRAINT "vendor_vendor_user_id_424f99f3_fk_accounts_user_id" FOREIGN KEY ("user_id") REFERENCES "accounts_user" ("id"),
  CONSTRAINT "vendor_vendor_user_profile_id_89f0f471_fk_accounts_" FOREIGN KEY ("user_profile_id") REFERENCES "accounts_userprofile" ("id")
)  SERIAL=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table "vendor_vendor"
--

LOCK TABLES "vendor_vendor" WRITE;
/*!40000 ALTER TABLE "vendor_vendor" DISABLE KEYS */;
INSERT INTO "vendor_vendor" VALUES (3,'Manish Restaurant','vendor/license/istockphoto-1389527253-612x612.jpg','manish-restaurant',1,'2024-11-05 04:51:27.916330','2024-11-11 06:47:00.895759',11,12),(4,'Pizza King','vendor/license/2.png','pizza-king-14',1,'2024-11-07 14:21:51.593847','2024-11-07 14:47:44.071804',14,14),(5,'Aashik Restaurant','vendor/license/Authorize.net_.png','aashik-restaurant-16',1,'2024-11-11 14:36:21.913890','2024-11-11 14:49:59.904829',16,16),(6,'aayansh restaurant','vendor/license/goldenchick.png','aayansh-restaurant-17',1,'2024-11-11 14:37:52.941249','2024-11-11 14:45:07.010121',17,17),(7,'aakriti restaurant','vendor/license/foodcourt-logo.png','aakriti-restaurant-18',1,'2024-11-11 14:39:55.036297','2024-11-11 15:04:14.308709',18,18);
/*!40000 ALTER TABLE "vendor_vendor" ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-12 19:23:51
