-- MySQL dump 10.13  Distrib 5.5.8, for solaris10 (sparc)
--
-- Host: ix    Database: cis451_final
-- ------------------------------------------------------
-- Server version	5.5.8

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `char_color`
--

DROP TABLE IF EXISTS `char_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_color` (
  `color_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(15) NOT NULL,
  `name` varchar(25) NOT NULL,
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`color_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_color`
--

LOCK TABLES `char_color` WRITE;
/*!40000 ALTER TABLE `char_color` DISABLE KEYS */;
INSERT INTO `char_color` VALUES (1,'white','White',0),(2,'gray','Gray',0),(3,'black','Black',0),(4,'blue','Blue',0),(5,'green','Green',0),(6,'yellow','Yellow',0),(7,'orange','Orange',0),(8,'brown','Brown',0),(9,'red','Red',0),(10,'pink','Pink',0),(11,'purple','Purple',0);
/*!40000 ALTER TABLE `char_color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_desc`
--

DROP TABLE IF EXISTS `char_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_desc` (
  `char_id` int(11) NOT NULL,
  `content` text,
  PRIMARY KEY (`char_id`),
  CONSTRAINT `char_desc_ref` FOREIGN KEY (`char_id`) REFERENCES `character` (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_desc`
--

LOCK TABLES `char_desc` WRITE;
/*!40000 ALTER TABLE `char_desc` DISABLE KEYS */;
INSERT INTO `char_desc` VALUES (2,'Tabby is a cat.');
/*!40000 ALTER TABLE `char_desc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_image`
--

DROP TABLE IF EXISTS `char_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_image` (
  `species_id` int(11) NOT NULL DEFAULT '0',
  `color_id` int(11) NOT NULL DEFAULT '0',
  `image` longblob,
  `thumb` longblob,
  PRIMARY KEY (`species_id`,`color_id`),
  KEY `image_color_ref` (`color_id`),
  CONSTRAINT `image_species_ref` FOREIGN KEY (`species_id`) REFERENCES `char_species` (`species_id`) ON DELETE CASCADE,
  CONSTRAINT `image_color_ref` FOREIGN KEY (`color_id`) REFERENCES `char_color` (`color_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_image`
--

LOCK TABLES `char_image` WRITE;
/*!40000 ALTER TABLE `char_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `char_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_page`
--

DROP TABLE IF EXISTS `char_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_page` (
  `char_id` int(11) NOT NULL,
  `content` longtext,
  PRIMARY KEY (`char_id`),
  CONSTRAINT `char_page_ref` FOREIGN KEY (`char_id`) REFERENCES `character` (`char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_page`
--

LOCK TABLES `char_page` WRITE;
/*!40000 ALTER TABLE `char_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `char_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `char_species`
--

DROP TABLE IF EXISTS `char_species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `char_species` (
  `species_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(15) NOT NULL,
  `name` varchar(25) NOT NULL DEFAULT '',
  `restricted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`species_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `char_species`
--

LOCK TABLES `char_species` WRITE;
/*!40000 ALTER TABLE `char_species` DISABLE KEYS */;
INSERT INTO `char_species` VALUES (1,'arcael','Arcael',0),(2,'pinava','Pinava',0),(3,'volk','Volk',0),(4,'cervinea','Cervinea',0),(5,'tahli','Tahli',0),(6,'kaladra','Kaladra',0);
/*!40000 ALTER TABLE `char_species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `character`
--

DROP TABLE IF EXISTS `character`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `character` (
  `char_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `species_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `owned_since` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`char_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `char_user_ref` (`user_id`),
  KEY `char_species_ref` (`species_id`),
  KEY `char_color_ref` (`color_id`),
  CONSTRAINT `char_color_ref` FOREIGN KEY (`color_id`) REFERENCES `char_color` (`color_id`) ON DELETE SET NULL,
  CONSTRAINT `char_species_ref` FOREIGN KEY (`species_id`) REFERENCES `char_species` (`species_id`) ON DELETE SET NULL,
  CONSTRAINT `char_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character`
--

LOCK TABLES `character` WRITE;
/*!40000 ALTER TABLE `character` DISABLE KEYS */;
INSERT INTO `character` VALUES (1,'Spunky',1,1,1,'2012-03-20 03:00:55','0000-00-00 00:00:00'),(2,'Tabby',2,5,6,'2012-03-20 03:00:55','0000-00-00 00:00:00'),(3,'Fluffball',1,2,3,'2012-03-20 03:00:55','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `character` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation`
--

DROP TABLE IF EXISTS `conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversation` (
  `convo_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`convo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `convo_message`
--

DROP TABLE IF EXISTS `convo_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `convo_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `convo_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` text,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  KEY `message_convo_ref` (`convo_id`),
  KEY `message_user_ref` (`user_id`),
  CONSTRAINT `message_convo_ref` FOREIGN KEY (`convo_id`) REFERENCES `conversation` (`convo_id`) ON DELETE CASCADE,
  CONSTRAINT `message_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convo_message`
--

LOCK TABLES `convo_message` WRITE;
/*!40000 ALTER TABLE `convo_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `convo_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `convo_user_rel`
--

DROP TABLE IF EXISTS `convo_user_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `convo_user_rel` (
  `convo_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`convo_id`,`user_id`),
  KEY `convo_user_rel1` (`user_id`),
  CONSTRAINT `convo_user_rel1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `convo_user_rel2` FOREIGN KEY (`convo_id`) REFERENCES `conversation` (`convo_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convo_user_rel`
--

LOCK TABLES `convo_user_rel` WRITE;
/*!40000 ALTER TABLE `convo_user_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `convo_user_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum`
--

DROP TABLE IF EXISTS `forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum` (
  `forum_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) NOT NULL,
  `slug` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`forum_id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `forum_cat_ref` (`cat_id`),
  CONSTRAINT `forum_cat_ref` FOREIGN KEY (`cat_id`) REFERENCES `forum_category` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum`
--

LOCK TABLES `forum` WRITE;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
INSERT INTO `forum` VALUES (1,1,'announcements','Announcements','Important announcements by administrators are sometimes posted here.',NULL),(2,2,'general','General Chat','Talk about whatever you want!',NULL),(3,2,'adult','Adult Chat','Talk about whatever you want, including dirty things!',NULL);
/*!40000 ALTER TABLE `forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_category`
--

DROP TABLE IF EXISTS `forum_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_category` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `order` (`order`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_category`
--

LOCK TABLES `forum_category` WRITE;
/*!40000 ALTER TABLE `forum_category` DISABLE KEYS */;
INSERT INTO `forum_category` VALUES (1,'Admin',0),(2,'Chat',1);
/*!40000 ALTER TABLE `forum_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_post`
--

DROP TABLE IF EXISTS `forum_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_post` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` text,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`),
  KEY `post_thread_ref` (`thread_id`),
  KEY `post_user_ref` (`user_id`),
  CONSTRAINT `post_thread_ref` FOREIGN KEY (`thread_id`) REFERENCES `forum_thread` (`thread_id`) ON DELETE CASCADE,
  CONSTRAINT `post_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_post`
--

LOCK TABLES `forum_post` WRITE;
/*!40000 ALTER TABLE `forum_post` DISABLE KEYS */;
INSERT INTO `forum_post` VALUES (1,1,1,'skladfja;lskdjfasdfj;asdf \n klasjdfkajsdf;sd fomg ','2012-03-19 05:05:59'),(2,1,2,'Hey, stop spamming so much.  Gosh!','2012-03-19 05:06:24'),(3,1,1,'no u','2012-03-19 05:06:34'),(4,1,2,':[','2012-03-19 05:06:40'),(5,1,1,'STOP BEING SO MEAN','2012-03-19 05:06:48'),(6,1,1,'AAHHHHHHHHHH','2012-03-19 05:06:59'),(7,1,2,'Okay okay, stop screaming.  I\'m going to go to my ','2012-03-19 05:07:13'),(8,4,2,'Hey, this is a totally new thread which was actually posted with the form.','2012-03-19 06:29:02'),(11,4,2,'oh man this is a reply\r\n\r\nit\'s a pretty sexy one, too.','2012-03-19 06:39:03'),(13,6,2,'this is a test post','2012-03-20 04:54:33'),(19,12,2,'oh man oh man!','2012-03-20 05:01:28'),(20,13,2,'...','2012-03-20 05:01:54'),(21,14,2,'HMMM?','2012-03-20 05:03:41'),(22,14,2,'Yes!','2012-03-20 05:04:03'),(25,1,2,'Let\'s overflow this to the next page!','2012-03-20 10:44:04'),(26,1,2,'How many posts does it take...','2012-03-20 10:44:15'),(27,1,2,'... to get to the center of the  ... wait... Nevermind.','2012-03-20 10:44:34'),(28,1,2,'Not yet.','2012-03-20 10:44:41'),(29,1,2,'Now?','2012-03-20 10:44:48'),(30,1,2,'Hmm...','2012-03-20 10:44:56'),(31,1,2,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eu ligula est, ut tristique nunc. Nullam gravida tempus enim, ac tincidunt ligula sodales ut. Proin non libero nulla. Praesent sit amet elit felis. Maecenas nisl eros, vehicula et viverra in, semper non orci. Etiam non mauris mi, a feugiat elit. Pellentesque enim massa, pulvinar et adipiscing ac, tristique quis leo. Vivamus vulputate sagittis egestas. Ut aliquet, urna sed posuere dapibus, urna quam auctor ante, at feugiat felis lacus ut enim. Curabitur varius, massa vitae auctor luctus, nisl mi viverra lectus, eu aliquet tellus turpis id lacus. Pellentesque suscipit fermentum orci, non vehicula lectus sollicitudin vel.\r\n\r\nInteger ac lobortis felis. Suspendisse vestibulum malesuada fringilla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean posuere ipsum commodo lorem tristique suscipit. In aliquet viverra sapien, lobortis eleifend est varius vel. Aenean id ultrices ipsum. Nulla porta lectus non turpis semper nec posuere odio vehicula. Donec a nisi malesuada tellus scelerisque rhoncus. Vivamus vitae tempus leo. Quisque felis nisl, cursus vitae eleifend sed, accumsan sed metus. Donec egestas, velit sed pretium elementum, nisi odio mattis est, nec interdum arcu nibh vitae mi. Morbi a auctor orci. Cras vitae mattis elit.\r\n\r\nVivamus id mollis elit. Maecenas id enim sollicitudin arcu euismod ullamcorper eget sed arcu. Sed ut neque lectus, non gravida nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut gravida gravida mi quis ultrices. Etiam nunc erat, porta in volutpat et, ullamcorper vitae turpis. Ut id suscipit arcu. Suspendisse potenti. Suspendisse condimentum, risus sit amet egestas bibendum, ipsum neque faucibus libero, nec mollis sapien dui sed justo. Nunc suscipit cursus elit non viverra. Sed sit amet risus nec dui cursus tristique vel eu erat. Nunc vestibulum tortor vitae nunc semper non pretium risus mollis. Vestibulum vitae nisl non purus pharetra venenatis. Aliquam eget ipsum ante.\r\n\r\nVestibulum ut tellus sapien, non cursus ipsum. Vivamus in ligula non leo fermentum ullamcorper quis ac sem. Ut lacinia tellus a neque pretium eget sollicitudin dui iaculis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vivamus pellentesque eleifend metus in dignissim. Maecenas vitae lacus quam, quis pellentesque tellus. Curabitur neque nulla, rutrum sed scelerisque ac, dignissim at magna. Maecenas cursus malesuada sem, in scelerisque sem vehicula convallis. Vivamus rutrum scelerisque orci, at pretium justo rutrum sit amet. In et velit lobortis elit dapibus tincidunt. Fusce vel tempor dui. Morbi sit amet libero lobortis ipsum mollis dapibus. Quisque sed mauris eu sapien scelerisque scelerisque non fermentum magna. Sed sed dui purus.\r\n\r\nNam eget bibendum nulla. Sed eget purus est, vel ullamcorper turpis. Aenean pretium suscipit nisi, at congue sapien tempus sed. Proin a felis sit amet nibh adipiscing cursus. Donec sit amet condimentum ipsum. Ut blandit tempor mollis. Integer nisl dolor, viverra eget eleifend nec, egestas quis massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In pulvinar vulputate leo, id aliquet magna fringilla quis. Aliquam posuere tristique urna, in tincidunt mi consectetur at. ','2012-03-20 10:45:19'),(32,1,2,'Pork chop pancetta ut, cow reprehenderit tri-tip jerky non aute est veniam in bacon nisi. Chicken bacon cillum tail. In pariatur dolore, cow tenderloin anim proident laborum nisi laboris ball tip. Salami capicola bacon tongue, incididunt magna sausage sunt shankle laboris.\r\n\r\nOfficia enim t-bone drumstick strip steak, non pork chop filet mignon esse shoulder brisket ullamco venison. Ut mollit jowl frankfurter, pork in velit excepteur speck beef ribs fatback consectetur officia dolore laborum. Pancetta pariatur chuck short ribs. Et ullamco cillum fugiat fatback drumstick strip steak laboris, tenderloin ribeye biltong boudin pork loin shankle.\r\n\r\nBall tip ex andouille ullamco kielbasa proident, pariatur sausage meatball pancetta ground round bacon. Shank sed rump, dolor in corned beef tempor pork chop deserunt veniam ut beef tri-tip frankfurter. Ex aliquip sunt bacon prosciutto, reprehenderit adipisicing chuck turducken flank andouille. Flank qui id jowl, speck capicola tempor ullamco boudin fatback sed. Short ribs eu ad meatloaf irure. Consectetur pariatur eiusmod, excepteur adipisicing short ribs tri-tip non.\r\n\r\nAliqua ham hock shankle andouille pastrami, ham tongue. Qui ex fatback chicken pork belly. Voluptate pork loin strip steak dolore hamburger adipisicing. Ut bresaola anim ham sint, biltong in shank turducken proident pariatur tenderloin nisi. In fugiat ribeye, andouille cupidatat aliquip ullamco nulla rump jerky. Short loin id flank, ad commodo short ribs t-bone boudin ullamco consectetur.\r\n\r\nChicken strip steak labore, reprehenderit consequat short loin ex non brisket ut et chuck swine biltong ham. Drumstick eiusmod swine, jowl dolor elit beef. Consequat flank filet mignon, sirloin nisi andouille ut pastrami. Corned beef sint shank, nostrud pastrami brisket non pariatur nisi.','2012-03-20 10:47:01'),(33,1,2,'AAaaand there!','2012-03-20 10:47:17');
/*!40000 ALTER TABLE `forum_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_thread`
--

DROP TABLE IF EXISTS `forum_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_thread` (
  `thread_id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`thread_id`),
  KEY `thread_forum_ref` (`forum_id`),
  KEY `thread_user_ref` (`user_id`),
  CONSTRAINT `thread_forum_ref` FOREIGN KEY (`forum_id`) REFERENCES `forum` (`forum_id`) ON DELETE CASCADE,
  CONSTRAINT `thread_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_thread`
--

LOCK TABLES `forum_thread` WRITE;
/*!40000 ALTER TABLE `forum_thread` DISABLE KEYS */;
INSERT INTO `forum_thread` VALUES (1,1,1,'The first thread ever'),(2,1,1,'The second thread ever'),(3,1,1,'Hey, this is totally a thread!'),(4,1,2,'New thread!'),(6,3,2,'test'),(12,3,2,'does it work?'),(13,3,2,'AAHHH!'),(14,3,2,'okay how about this time');
/*!40000 ALTER TABLE `forum_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_score`
--

DROP TABLE IF EXISTS `game_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_score` (
  `game_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`game_id`,`user_id`,`time`),
  KEY `game_score_user_ref` (`user_id`),
  CONSTRAINT `game_score_ref` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`),
  CONSTRAINT `game_score_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_score`
--

LOCK TABLES `game_score` WRITE;
/*!40000 ALTER TABLE `game_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_def_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `place_id` int(11) DEFAULT NULL,
  `place_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `item_def_ref` (`item_def_id`),
  KEY `item_user_ref` (`user_id`),
  CONSTRAINT `item_def_ref` FOREIGN KEY (`item_def_id`) REFERENCES `item_def` (`item_def_id`) ON DELETE CASCADE,
  CONSTRAINT `item_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_def`
--

DROP TABLE IF EXISTS `item_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_def` (
  `item_def_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`item_def_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_def`
--

LOCK TABLES `item_def` WRITE;
/*!40000 ALTER TABLE `item_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_def_type_rel`
--

DROP TABLE IF EXISTS `item_def_type_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_def_type_rel` (
  `item_def_id` int(11) NOT NULL DEFAULT '0',
  `item_type_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_def_id`,`item_type_id`),
  KEY `item_def_type_ref2` (`item_type_id`),
  CONSTRAINT `item_def_type_ref1` FOREIGN KEY (`item_def_id`) REFERENCES `item_def` (`item_def_id`) ON DELETE CASCADE,
  CONSTRAINT `item_def_type_ref2` FOREIGN KEY (`item_type_id`) REFERENCES `item_type` (`item_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_def_type_rel`
--

LOCK TABLES `item_def_type_rel` WRITE;
/*!40000 ALTER TABLE `item_def_type_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_def_type_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_type`
--

DROP TABLE IF EXISTS `item_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_type` (
  `item_type_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`item_type_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_type`
--

LOCK TABLES `item_type` WRITE;
/*!40000 ALTER TABLE `item_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` text,
  PRIMARY KEY (`news_id`),
  KEY `news_user_ref` (`user_id`),
  CONSTRAINT `news_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_online` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gold` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Admin',NULL,'Site Administrator','nikker@cs.uoregon.edu','other',NULL,'2012-03-19 00:07:33','0000-00-00 00:00:00',0),(2,'Guest',NULL,'Guest',NULL,'other',NULL,'2012-03-19 00:07:33','0000-00-00 00:00:00',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_alert`
--

DROP TABLE IF EXISTS `user_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_alert` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `alert_num` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`alert_num`,`user_id`),
  KEY `alert_user_ref` (`user_id`),
  CONSTRAINT `alert_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_alert`
--

LOCK TABLES `user_alert` WRITE;
/*!40000 ALTER TABLE `user_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_friend`
--

DROP TABLE IF EXISTS `user_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_friend` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `friend_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`friend_id`),
  KEY `friend_user_ref2` (`friend_id`),
  CONSTRAINT `friend_user_ref1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `friend_user_ref2` FOREIGN KEY (`friend_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_friend`
--

LOCK TABLES `user_friend` WRITE;
/*!40000 ALTER TABLE `user_friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile` (
  `user_id` int(11) NOT NULL,
  `content` text,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_profile_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO `user_profile` VALUES (2,'Hey!  This is a guest account.\r\n\r\nYou can edit the profile to say pretty much whatever you want.');
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (2,'admin'),(4,'guest'),(3,'moderator'),(1,'user');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role_rel`
--

DROP TABLE IF EXISTS `user_role_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role_rel` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_role_ref2` (`role_id`),
  CONSTRAINT `user_role_ref1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_role_ref2` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role_rel`
--

LOCK TABLES `user_role_rel` WRITE;
/*!40000 ALTER TABLE `user_role_rel` DISABLE KEYS */;
INSERT INTO `user_role_rel` VALUES (1,1),(1,2),(2,4);
/*!40000 ALTER TABLE `user_role_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_signature`
--

DROP TABLE IF EXISTS `user_signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_signature` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `sig_num` int(11) NOT NULL AUTO_INCREMENT,
  `before` text,
  `after` text,
  PRIMARY KEY (`sig_num`,`user_id`),
  KEY `sig_user_ref` (`user_id`),
  CONSTRAINT `sig_user_ref` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_signature`
--

LOCK TABLES `user_signature` WRITE;
/*!40000 ALTER TABLE `user_signature` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_signature` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-21  0:31:32
