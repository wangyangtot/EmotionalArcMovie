/*
MySQL Backup
Database: heroku_91504066c035296
Backup Time: 2017-10-08 23:26:58
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`admin`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`adminlog`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`auth`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`comment`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`movie`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`moviecol`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`oplog`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`preview`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`role`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`tag`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`user`;
DROP TABLE IF EXISTS `heroku_91504066c035296`.`userlog`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `is_super` smallint(6) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `role_id` (`role_id`),
  KEY `ix_admin_addtime` (`addtime`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
CREATE TABLE `adminlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_adminlog_addtime` (`addtime`),
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
CREATE TABLE `auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`),
  KEY `ix_auth_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_comment_addtime` (`addtime`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
CREATE TABLE `movie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `title_without_year` varchar(255) DEFAULT NULL,
  `playnum` bigint(20) DEFAULT NULL,
  `commentnum` bigint(20) DEFAULT NULL,
  `youtubeId`  varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_movie_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
CREATE TABLE `moviecol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_moviecol_addtime` (`addtime`),
  CONSTRAINT `moviecol_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `moviecol_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8;
CREATE TABLE `oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `reason` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_oplog_addtime` (`addtime`),
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `auths` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_role_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `info` text,
  `face` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `face` (`face`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_user_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
CREATE TABLE `userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_userlog_addtime` (`addtime`),
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`admin` WRITE;
DELETE FROM `heroku_91504066c035296`.`admin`;
INSERT INTO `heroku_91504066c035296`.`admin` (`id`,`name`,`pwd`,`is_super`,`role_id`,`addtime`) VALUES (1, 'imoocmovie', 'pbkdf2:sha256:50000$Lxv6JZ3o$bd85235be0ca5d89e386a84b5c09bddfd77d32e64ded8e618298fcea6aa0184c', 0, 1, '2017-09-27 08:21:22'),(2, 'imoocmovie1', 'pbkdf2:sha256:50000$Qv7oHY7r$731573923e91957301b19e5af9ffb4e9aedeffa88c8cefe51f99b3f748aa1dbe', 0, 1, '2017-09-27 16:27:45'),(3, 'imoocmovie2', 'pbkdf2:sha256:50000$GAZMCwaL$72354149e89112350323ed58f016c9fe47d545dad11906998dad13cedf3c488a', NULL, 2, '2017-10-04 22:26:58');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`adminlog` WRITE;
DELETE FROM `heroku_91504066c035296`.`adminlog`;
INSERT INTO `heroku_91504066c035296`.`adminlog` (`id`,`admin_id`,`ip`,`addtime`) VALUES (108, 1, '127.0.0.1', '2017-10-07 18:10:26'),(109, 1, '127.0.0.1', '2017-10-08 17:21:51'),(110, 1, '127.0.0.1', '2017-10-08 17:34:52'),(111, 1, '127.0.0.1', '2017-10-08 17:36:21'),(112, 1, '127.0.0.1', '2017-10-08 17:38:46');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`auth` WRITE;
DELETE FROM `heroku_91504066c035296`.`auth`;
INSERT INTO `heroku_91504066c035296`.`auth` (`id`,`name`,`url`,`addtime`) VALUES (1, 'add movies', '/admin/movie/add/', '2017-10-04 11:45:09'),(2,'movie list', '/admin/movie/list/<int:page>/', '2017-10-04 15:44:35');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`comment` WRITE;
DELETE FROM `heroku_91504066c035296`.`comment`;
INSERT INTO `heroku_91504066c035296`.`comment` (`id`,`content`,`movie_id`,`user_id`,`addtime`) VALUES (13, '好看', 7, 1, '2017-10-02 22:55:05'),(14, '不错', 7, 2, '2017-10-02 22:55:05'),(15, '经典', 7, 3, '2017-10-02 22:55:05'),(17, '难看', NULL, 5, '2017-10-02 22:55:05'),(18, '无聊', NULL, 6, '2017-10-02 22:55:05'),(19, '乏味', NULL, 7, '2017-10-02 22:55:05'),(20, '无感', NULL, 8, '2017-10-02 22:55:05'),(22, '不错', 7, 16, '2017-10-02 22:55:24'),(25, '难看', NULL, 5, '2017-10-02 22:55:24'),(26, '无聊', NULL, 6, '2017-10-02 22:55:24'),(27, '乏味', NULL, 7, '2017-10-02 22:55:24'),(34, '好看', 7, 1, '2017-10-02 23:10:36'),(36, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0013.gif\"/></p>', 7, 16, '2017-10-07 13:52:34'),(37, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0013.gif\"/></p>', 7, 16, '2017-10-07 13:52:42'),(38, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0013.gif\"/></p>', 7, 16, '2017-10-07 13:52:53'),(39, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0013.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0004.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0008.gif\"/></p>', 7, 16, '2017-10-07 13:53:09'),(40, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0035.gif\"/></p>', 9, 16, '2017-10-07 13:56:01'),(41, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0001.gif\"/></p>', 10, 16, '2017-10-07 13:57:19'),(42, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/></p>', 10, 14, '2017-10-07 14:44:36'),(43, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0008.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/></p>', 10, 14, '2017-10-07 14:44:41'),(44, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0007.gif\"/></p>', 10, 13, '2017-10-07 14:44:59'),(45, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0008.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/></p>', 10, 14, '2017-10-07 14:45:06'),(46, '<p><img src=\"http://img.baidu.com/hi/jx2/j_0008.gif\"/><img src=\"http://img.baidu.com/hi/jx2/j_0003.gif\"/></p>', 10, 14, '2017-10-07 14:45:17'),(47, '<p>哈哈</p><p><br/></p>', 10, 16, '2017-10-07 17:12:59'),(48, '<p>哈哈</p><p><br/></p>', 10, 16, '2017-10-07 17:13:13'),(49, '<p>nimzde<br/></p>', 9, 16, '2017-10-07 17:16:14'),(50, '<p>nimzde<br/></p>', 9, 16, '2017-10-07 17:22:01');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`movie` WRITE;
DELETE FROM `heroku_91504066c035296`.`movie`;
INSERT INTO `heroku_91504066c035296`.`movie` (`id`,`title`,`title_without_year`,`playnum`,`commentnum`,`youtubeId`,`addtime`) VALUES (1, 'Toy Story (1995)', 'Toy Story', 0, 0, 'K26_sDKnvMU', '2018-09-21'), (2, 'Jumanji (1995)', 'Jumanji', 0, 0, '3LPANjHlPxo', '2018-09-21'), (3, 'Grumpier Old Men (1995)', 'Grumpier Old Men', 0, 0, 'rEnOoWs3FuA', '2018-09-21'), (6, 'Heat (1995)', 'Heat', 0, 0, '2GfZl4kuVNI', '2018-09-21');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`moviecol` WRITE;
DELETE FROM `heroku_91504066c035296`.`moviecol`;
INSERT INTO `heroku_91504066c035296`.`moviecol` (`id`,`movie_id`,`user_id`,`addtime`) VALUES (5, NULL, 5, '2017-10-03 09:33:09'),(6, NULL, 6, '2017-10-03 09:33:09'),(7, NULL, 7, '2017-10-03 09:33:09'),(8, NULL, 8, '2017-10-03 09:33:09'),(13, NULL, 5, '2017-10-03 10:10:48'),(14, NULL, 6, '2017-10-03 10:10:48'),(15, NULL, 7, '2017-10-03 10:10:48'),(16, NULL, 8, '2017-10-03 10:10:48'),(17, 7, 1, '2017-10-03 10:11:01'),(18, 7, 2, '2017-10-03 10:11:01'),(19, 7, 3, '2017-10-03 10:11:01'),(20, 7, 4, '2017-10-03 10:11:02'),(21, NULL, 5, '2017-10-03 10:11:02'),(22, NULL, 6, '2017-10-03 10:11:02'),(23, NULL, 7, '2017-10-03 10:11:02'),(24, NULL, 8, '2017-10-03 10:11:02'),(25, 7, 1, '2017-10-03 10:11:02'),(26, 7, 2, '2017-10-03 10:11:02'),(27, 7, 3, '2017-10-03 10:11:02'),(28, 7, 4, '2017-10-03 10:11:02'),(29, NULL, 5, '2017-10-03 10:11:02'),(32, NULL, 8, '2017-10-03 10:11:02'),(33, 7, 1, '2017-10-03 13:39:05'),(34, 7, 2, '2017-10-03 13:39:06'),(35, 7, 3, '2017-10-03 13:39:06'),(36, 7, 4, '2017-10-03 13:39:06'),(37, NULL, 5, '2017-10-03 13:39:06'),(38, NULL, 6, '2017-10-03 13:39:06'),(39, NULL, 7, '2017-10-03 13:39:06'),(40, NULL, 8, '2017-10-03 13:39:06'),(41, 7, 1, '2017-10-03 13:39:06'),(42, 7, 2, '2017-10-03 13:39:06'),(43, 7, 3, '2017-10-03 13:39:06'),(44, 7, 4, '2017-10-03 13:39:06'),(45, NULL, 5, '2017-10-03 13:39:06'),(46, NULL, 6, '2017-10-03 13:39:06'),(47, NULL, 7, '2017-10-03 13:39:06'),(48, NULL, 8, '2017-10-03 13:39:07'),(49, 7, 1, '2017-10-03 13:39:07'),(50, 7, 2, '2017-10-03 13:39:07'),(51, 7, 3, '2017-10-03 13:39:07'),(52, 7, 4, '2017-10-03 13:39:07'),(53, NULL, 5, '2017-10-03 13:39:07'),(54, NULL, 6, '2017-10-03 13:39:07'),(55, NULL, 7, '2017-10-03 13:39:07'),(56, NULL, 8, '2017-10-03 13:39:07'),(57, 7, 1, '2017-10-03 13:39:08'),(58, 7, 2, '2017-10-03 13:39:08'),(59, 7, 3, '2017-10-03 13:39:08'),(60, 7, 4, '2017-10-03 13:39:08'),(61, NULL, 5, '2017-10-03 13:39:08'),(62, NULL, 6, '2017-10-03 13:39:08'),(63, NULL, 7, '2017-10-03 13:39:08'),(64, NULL, 8, '2017-10-03 13:39:08'),(65, 7, 1, '2017-10-03 13:39:08'),(66, 7, 2, '2017-10-03 13:39:09'),(67, 7, 3, '2017-10-03 13:39:09'),(68, 7, 4, '2017-10-03 13:39:09'),(69, NULL, 5, '2017-10-03 13:39:09'),(70, NULL, 6, '2017-10-03 13:39:09'),(71, NULL, 7, '2017-10-03 13:39:09'),(72, NULL, 8, '2017-10-03 13:39:09'),(73, 7, 1, '2017-10-03 13:39:09'),(74, 7, 2, '2017-10-03 13:39:09'),(75, 7, 3, '2017-10-03 13:39:09'),(76, 7, 4, '2017-10-03 13:39:09'),(77, NULL, 5, '2017-10-03 13:39:09'),(78, NULL, 6, '2017-10-03 13:39:09'),(79, NULL, 7, '2017-10-03 13:39:09'),(80, NULL, 8, '2017-10-03 13:39:09'),(81, 7, 1, '2017-10-03 13:39:10'),(82, 7, 2, '2017-10-03 13:39:10'),(83, 7, 3, '2017-10-03 13:39:10'),(84, 7, 4, '2017-10-03 13:39:10'),(85, NULL, 5, '2017-10-03 13:39:10'),(86, NULL, 6, '2017-10-03 13:39:10'),(87, NULL, 7, '2017-10-03 13:39:10'),(88, NULL, 8, '2017-10-03 13:39:10'),(89, 7, 1, '2017-10-03 13:39:10'),(90, 7, 2, '2017-10-03 13:39:10'),(91, 7, 3, '2017-10-03 13:39:10'),(92, 7, 4, '2017-10-03 13:39:10'),(93, NULL, 5, '2017-10-03 13:39:10'),(94, NULL, 6, '2017-10-03 13:39:10'),(95, NULL, 7, '2017-10-03 13:39:10'),(96, NULL, 8, '2017-10-03 13:39:10'),(97, 7, 1, '2017-10-03 13:39:11'),(98, 7, 2, '2017-10-03 13:39:11'),(99, 7, 3, '2017-10-03 13:39:11'),(100, 7, 4, '2017-10-03 13:39:11'),(101, NULL, 5, '2017-10-03 13:39:11'),(102, NULL, 6, '2017-10-03 13:39:11'),(103, NULL, 7, '2017-10-03 13:39:11'),(104, NULL, 8, '2017-10-03 13:39:11'),(105, 7, 1, '2017-10-03 13:39:11'),(106, 7, 2, '2017-10-03 13:39:11'),(107, 7, 3, '2017-10-03 13:39:11'),(108, 7, 4, '2017-10-03 13:39:11'),(109, NULL, 5, '2017-10-03 13:39:11'),(110, NULL, 6, '2017-10-03 13:39:11'),(111, NULL, 7, '2017-10-03 13:39:11'),(112, NULL, 8, '2017-10-03 13:39:11'),(113, 7, 1, '2017-10-03 13:39:12'),(114, 7, 2, '2017-10-03 13:39:12'),(115, 7, 3, '2017-10-03 13:39:12'),(116, 7, 4, '2017-10-03 13:39:12'),(117, NULL, 5, '2017-10-03 13:39:12'),(118, NULL, 6, '2017-10-03 13:39:12'),(119, NULL, 7, '2017-10-03 13:39:12'),(120, NULL, 8, '2017-10-03 13:39:12'),(121, 7, 1, '2017-10-03 13:39:12'),(122, 7, 2, '2017-10-03 13:39:12'),(123, 7, 3, '2017-10-03 13:39:12'),(124, 7, 4, '2017-10-03 13:39:12'),(125, NULL, 5, '2017-10-03 13:39:12'),(126, NULL, 6, '2017-10-03 13:39:12'),(127, NULL, 7, '2017-10-03 13:39:12'),(128, NULL, 8, '2017-10-03 13:39:12'),(129, 7, 1, '2017-10-03 13:39:13'),(130, 7, 2, '2017-10-03 13:39:13'),(131, 7, 3, '2017-10-03 13:39:13'),(132, 7, 4, '2017-10-03 13:39:13'),(133, NULL, 5, '2017-10-03 13:39:13'),(134, NULL, 6, '2017-10-03 13:39:13'),(135, NULL, 7, '2017-10-03 13:39:13'),(136, NULL, 8, '2017-10-03 13:39:13'),(137, 7, 1, '2017-10-03 13:39:13'),(138, 7, 2, '2017-10-03 13:39:13'),(139, 7, 3, '2017-10-03 13:39:13'),(140, 7, 4, '2017-10-03 13:39:13'),(141, NULL, 5, '2017-10-03 13:39:13'),(142, NULL, 6, '2017-10-03 13:39:13'),(143, NULL, 7, '2017-10-03 13:39:13'),(144, NULL, 8, '2017-10-03 13:39:13'),(145, 7, 1, '2017-10-03 13:39:14'),(146, 7, 2, '2017-10-03 13:39:14'),(147, 7, 3, '2017-10-03 13:39:14'),(148, 7, 4, '2017-10-03 13:39:14'),(149, NULL, 5, '2017-10-03 13:39:14'),(150, NULL, 6, '2017-10-03 13:39:14'),(151, NULL, 7, '2017-10-03 13:39:14'),(152, NULL, 8, '2017-10-03 13:39:14'),(153, 7, 1, '2017-10-03 13:39:14'),(154, 7, 2, '2017-10-03 13:39:14'),(155, 7, 3, '2017-10-03 13:39:14'),(156, 7, 4, '2017-10-03 13:39:14'),(157, NULL, 5, '2017-10-03 13:39:14'),(158, NULL, 6, '2017-10-03 13:39:14'),(159, NULL, 7, '2017-10-03 13:39:14'),(160, NULL, 8, '2017-10-03 13:39:14'),(161, 7, 1, '2017-10-03 13:39:15'),(162, 7, 2, '2017-10-03 13:39:15'),(163, 7, 3, '2017-10-03 13:39:15'),(164, 7, 4, '2017-10-03 13:39:15'),(165, NULL, 5, '2017-10-03 13:39:15'),(166, NULL, 6, '2017-10-03 13:39:15'),(167, NULL, 7, '2017-10-03 13:39:15'),(168, NULL, 8, '2017-10-03 13:39:15'),(169, 7, 1, '2017-10-03 13:39:15'),(170, 7, 2, '2017-10-03 13:39:15'),(171, 7, 3, '2017-10-03 13:39:15'),(172, 7, 4, '2017-10-03 13:39:15'),(173, NULL, 5, '2017-10-03 13:39:15'),(174, NULL, 6, '2017-10-03 13:39:15'),(175, NULL, 7, '2017-10-03 13:39:15'),(176, NULL, 8, '2017-10-03 13:39:15'),(177, 7, 1, '2017-10-03 13:39:16'),(178, 7, 2, '2017-10-03 13:39:16'),(179, 7, 3, '2017-10-03 13:39:16'),(180, 7, 4, '2017-10-03 13:39:16'),(181, NULL, 5, '2017-10-03 13:39:16'),(182, NULL, 6, '2017-10-03 13:39:16'),(183, NULL, 7, '2017-10-03 13:39:16'),(184, NULL, 8, '2017-10-03 13:39:16'),(185, 7, 1, '2017-10-03 13:39:16'),(186, 7, 2, '2017-10-03 13:39:16'),(187, 7, 3, '2017-10-03 13:39:16'),(188, 7, 4, '2017-10-03 13:39:16'),(189, NULL, 5, '2017-10-03 13:39:16'),(190, NULL, 6, '2017-10-03 13:39:16'),(191, NULL, 7, '2017-10-03 13:39:16'),(192, NULL, 8, '2017-10-03 13:39:16'),(193, 7, 1, '2017-10-03 13:39:17'),(194, 7, 2, '2017-10-03 13:39:17'),(195, 7, 3, '2017-10-03 13:39:17'),(196, 7, 4, '2017-10-03 13:39:17'),(197, NULL, 5, '2017-10-03 13:39:17'),(198, NULL, 6, '2017-10-03 13:39:17'),(199, NULL, 7, '2017-10-03 13:39:17'),(200, NULL, 8, '2017-10-03 13:39:17'),(201, 7, 1, '2017-10-03 13:39:17'),(202, 7, 2, '2017-10-03 13:39:17'),(203, 7, 3, '2017-10-03 13:39:17'),(204, 7, 4, '2017-10-03 13:39:17'),(205, NULL, 5, '2017-10-03 13:39:17'),(206, NULL, 6, '2017-10-03 13:39:17'),(207, NULL, 7, '2017-10-03 13:39:17'),(208, NULL, 8, '2017-10-03 13:39:17'),(209, 7, 1, '2017-10-03 13:39:17'),(210, 7, 2, '2017-10-03 13:39:17'),(211, 7, 3, '2017-10-03 13:39:17'),(212, 7, 4, '2017-10-03 13:39:17'),(213, NULL, 5, '2017-10-03 13:39:17'),(214, NULL, 6, '2017-10-03 13:39:17'),(215, NULL, 7, '2017-10-03 13:39:17'),(216, NULL, 8, '2017-10-03 13:39:17'),(217, 7, 1, '2017-10-03 13:39:18'),(218, 7, 2, '2017-10-03 13:39:18'),(219, 7, 3, '2017-10-03 13:39:18'),(220, 7, 4, '2017-10-03 13:39:18'),(221, NULL, 5, '2017-10-03 13:39:18'),(222, NULL, 6, '2017-10-03 13:39:18'),(224, NULL, 8, '2017-10-03 13:39:18'),(225, 7, 1, '2017-10-03 13:39:18'),(226, 7, 2, '2017-10-03 13:39:18'),(227, 7, 3, '2017-10-03 13:39:18'),(228, 7, 4, '2017-10-03 13:39:18'),(229, NULL, 5, '2017-10-03 13:39:18'),(230, NULL, 6, '2017-10-03 13:39:18'),(231, NULL, 7, '2017-10-03 13:39:18'),(232, NULL, 8, '2017-10-03 13:39:18'),(233, 7, 1, '2017-10-03 13:39:18'),(234, 7, 2, '2017-10-03 13:39:18'),(235, 7, 3, '2017-10-03 13:39:18'),(236, 7, 4, '2017-10-03 13:39:18'),(237, NULL, 5, '2017-10-03 13:39:18'),(238, NULL, 6, '2017-10-03 13:39:18'),(239, NULL, 7, '2017-10-03 13:39:18'),(240, NULL, 8, '2017-10-03 13:39:18'),(281, 7, 1, '2017-10-03 13:39:21'),(283, 7, 3, '2017-10-03 13:39:21'),(284, 7, 4, '2017-10-03 13:39:21'),(286, NULL, 6, '2017-10-03 13:39:21'),(288, NULL, 8, '2017-10-03 13:39:21'),(290, 7, 2, '2017-10-03 13:39:21'),(291, 7, 3, '2017-10-03 13:39:21'),(293, NULL, 5, '2017-10-03 13:39:21'),(294, NULL, 6, '2017-10-03 13:39:21'),(295, NULL, 7, '2017-10-03 13:39:21'),(297, 7, 1, '2017-10-03 13:39:22'),(298, 7, 2, '2017-10-03 13:39:22'),(300, 7, 4, '2017-10-03 13:39:22'),(301, NULL, 5, '2017-10-03 13:39:22'),(302, NULL, 6, '2017-10-03 13:39:22'),(303, NULL, 7, '2017-10-03 13:39:22'),(304, NULL, 8, '2017-10-03 13:39:22'),(309, 10, 16, '2017-10-07 17:01:03'),(311, 7, 16, '2017-10-07 17:14:26'),(312, 9, 16, '2017-10-07 17:14:35'),(313, 7, 14, '2017-10-07 19:34:17'),(314, 10, 14, '2017-10-07 19:34:24'),(315, 9, 14, '2017-10-07 19:34:27');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`oplog` WRITE;
DELETE FROM `heroku_91504066c035296`.`oplog`;
INSERT INTO `heroku_91504066c035296`.`oplog` (`id`,`admin_id`,`ip`,`reason`,`addtime`) VALUES (1, 1, '127.0.0.1', '添加一个标签：异界', '2017-10-03 19:45:50'),(2, 1, '127.0.0.1', '添加一个标签：治愈', '2017-10-03 19:58:58'),(3, 1, '127.0.0.1', '修改标签“异界”为“神界”', '2017-10-03 21:18:57'),(4, 1, '127.0.0.1', '修改了密码', '2017-10-03 21:19:58'),(5, 1, '127.0.0.1', '删除标签：神界', '2017-10-03 21:23:51'),(6, 1, '127.0.0.1', '添加一部电影：天空之城1', '2017-10-03 21:28:58'),(7, 1, '127.0.0.1', '修改电影：天空之城1（原 天空之城）', '2017-10-03 21:35:53'),(8, 1, '127.0.0.1', '修改电影：天空之城（原名：天空之城）', '2017-10-03 21:36:37'),(9, 1, '127.0.0.1', '删除电影：环太平洋1', '2017-10-03 21:38:10'),(10, 1, '127.0.0.1', '删除用户 鼠 在 环太平洋 的评论：好看', '2017-10-03 22:06:26'),(11, 1, '127.0.0.1', '删除用户「虎」在「环太平洋」的评论：经典', '2017-10-03 22:09:35'),(12, 1, '127.0.0.1', '删除用户「兔(4)」在「环太平洋」的评论：给力', '2017-10-03 22:11:13'),(13, 1, '127.0.0.1', '删除会员「虎(3)」对电影《环太平洋》的收藏', '2017-10-03 22:18:25'),(14, 1, '127.0.0.1', '删除会员「兔(4)」在《环太平洋》的评论：给力', '2017-10-03 22:18:45'),(15, 1, '127.0.0.1', '修改电影预告：赛车预告（原名：赛车预告）', '2017-10-03 22:20:47'),(16, 1, '127.0.0.1', '删除会员「虎(3)」对电影《环太平洋》的收藏', '2017-10-03 22:21:40'),(17, 1, '127.0.0.1', '添加新权限：添加标签', '2017-10-04 11:41:55'),(18, 1, '127.0.0.1', '添加新权限：添加电影', '2017-10-04 11:45:09'),(19, 1, '127.0.0.1', '修改权限：添加电影1（原名：添加电影）', '2017-10-04 12:23:34'),(20, 1, '127.0.0.1', '修改权限：添加电影（原名：添加电影1）', '2017-10-04 12:24:22'),(21, 1, '127.0.0.1', '修改权限：添加电影1（原名：添加电影）', '2017-10-04 12:27:47'),(22, 1, '127.0.0.1', '修改权限：添加电影（原名：添加电影1）', '2017-10-04 12:28:01'),(23, 1, '127.0.0.1', '添加新权限：标签列表', '2017-10-04 15:44:10'),(24, 1, '127.0.0.1', '添加新权限：电影列表', '2017-10-04 15:44:35'),(25, 1, '127.0.0.1', '添加新权限：编辑标签', '2017-10-04 15:45:36'),(26, 1, '127.0.0.1', '添加新权限：删除标签', '2017-10-04 15:46:17'),(27, 1, '127.0.0.1', '删除标签：二次元', '2017-10-04 15:59:12'),(28, 1, '127.0.0.1', '添加新标签：自然', '2017-10-04 16:01:39'),(29, 1, '127.0.0.1', '添加新标签：小清新', '2017-10-04 16:04:50'),(30, 1, '127.0.0.1', '添加新角色：test角色', '2017-10-04 16:39:48'),(31, 1, '127.0.0.1', '修改权限：编辑标签1（原名：编辑标签）', '2017-10-04 17:16:10'),(32, 1, '127.0.0.1', '修改权限：编辑标签（原名：编辑标签1）', '2017-10-04 17:16:47'),(33, 1, '127.0.0.1', '修改电影：天空之城（原名：天空之城）', '2017-10-04 17:44:35'),(34, 1, '127.0.0.1', '添加新角色：test角色1', '2017-10-04 18:21:44'),(35, 1, '127.0.0.1', '修改角色：test角色1（原名：test角色1）', '2017-10-04 18:21:55'),(36, 1, '127.0.0.1', '修改角色：test角色1（原名：test角色1）', '2017-10-04 18:23:24'),(37, 1, '127.0.0.1', '修改角色：test角色2（原名：test角色1）', '2017-10-04 18:39:08'),(38, 1, '127.0.0.1', '添加新角色：test角色1', '2017-10-04 18:39:18'),(39, 1, '127.0.0.1', '删除角色：test角色1', '2017-10-04 18:43:43'),(40, 1, '127.0.0.1', '删除角色：test角色2', '2017-10-04 18:43:45'),(41, 1, '127.0.0.1', '修改角色：test角色（原名：test角色）', '2017-10-04 18:44:54'),(42, 1, '127.0.0.1', '修改角色：超级管理员（原名：超级管理员）', '2017-10-04 18:58:59'),(43, 1, '127.0.0.1', '添加新权限：qqq', '2017-10-04 18:59:24'),(44, 1, '127.0.0.1', '修改角色：超级管理员（原名：超级管理员）', '2017-10-04 19:00:12'),(45, 1, '127.0.0.1', '删除权限：qqq', '2017-10-04 19:03:10'),(46, 1, '127.0.0.1', '修改角色：超级管理员（原名：超级管理员）', '2017-10-04 19:03:43'),(47, 1, '127.0.0.1', '修改角色：test角色（原名：test角色）', '2017-10-04 19:06:32'),(48, 1, '127.0.0.1', '添加新管理员：imoocmovie2', '2017-10-04 22:26:58'),(49, 2, '127.0.0.1', '删除标签：历史', '2017-10-04 22:54:17'),(50, 2, '127.0.0.1', '删除标签：恐怖', '2017-10-04 22:54:21'),(51, 1, '127.0.0.1', '添加新电影预告：标题有了', '2017-10-06 12:36:32'),(52, 1, '127.0.0.1', '添加新电影预告：标题有了1', '2017-10-06 12:36:42'),(53, 1, '127.0.0.1', '添加新电影预告：标题有了2', '2017-10-06 12:36:50'),(54, 1, '127.0.0.1', '添加新电影预告：标题有了3', '2017-10-06 12:36:58'),(55, 1, '127.0.0.1', '添加新电影预告：标题有了4', '2017-10-06 12:37:04'),(56, 1, '127.0.0.1', '删除电影预告：环太平洋', '2017-10-06 16:16:29'),(57, 1, '127.0.0.1', '删除电影预告：赛车预告', '2017-10-06 16:16:31'),(58, 1, '127.0.0.1', '修改电影预告：标题有了5（原名：标题有了）', '2017-10-06 16:16:47'),(59, 1, '127.0.0.1', '添加新电影：空战', '2017-10-06 16:56:56'),(60, 1, '127.0.0.1', '修改电影：空战1（原名：空战1）', '2017-10-07 19:38:04'),(61, 1, '127.0.0.1', '添加新标签：搞笑', '2017-10-08 17:22:21'),(62, 1, '127.0.0.1', '添加新标签：新鲜', '2017-10-08 17:22:58'),(63, 1, '127.0.0.1', '修改了密码', '2017-10-08 17:35:01'),(64, 1, '127.0.0.1', '修改了密码', '2017-10-08 17:36:41');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`role` WRITE;
DELETE FROM `heroku_91504066c035296`.`role`;
INSERT INTO `heroku_91504066c035296`.`role` (`id`,`name`,`auths`,`addtime`) VALUES (1, '超级管理员', '3', '2017-09-27 08:13:05'),(2, 'test角色', '2,4,6', '2017-10-04 16:39:48');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`user` WRITE;
DELETE FROM `heroku_91504066c035296`.`user`;
INSERT INTO `heroku_91504066c035296`.`user` (`id`,`name`,`pwd`,`email`,`info`,`face`,`addtime`,`uuid`) VALUES (1, '鼠', '1231', '1231@123.com', '鼠', '1f401.png', '2017-10-02 21:52:08', 'd32a72bdac524478b7e4f6dfc8394fc0'),(2, '牛', '1232', '1232@123.com', '牛', '1f402.png', '2017-10-02 21:52:11', 'd32a72bdac524478b7e4f6dfc8394fc1'),(3, '虎', '1233', '1233@123.com', '虎', '1f405.png', '2017-10-02 21:52:15', 'd32a72bdac524478b7e4f6dfc8394fc2'),(4, '兔', '1234', '1234@123.com', '兔', '1f407.png', '2017-10-02 21:52:19', 'd32a72bdac524478b7e4f6dfc8394fc3'),(5, '龙', '1235', '1235@123.com', '龙', '1f409.png', '2017-10-02 21:52:23', 'd32a72bdac524478b7e4f6dfc8394fc4'),(6, '蛇', '1236', '1236@123.com', '蛇', '1f40d.png', '2017-10-02 21:52:27', 'd32a72bdac524478b7e4f6dfc8394fc5'),(7, '马', '1237', '1237@123.com', '马', '1f434.png', '2017-10-02 21:52:30', 'd32a72bdac524478b7e4f6dfc8394fc6'),(8, '羊', '1238', '1238@123.com', '羊', '1f411.png', '2017-10-02 21:52:33', 'd32a72bdac524478b7e4f6dfc8394fc7'),(9, '猴', '1239', '1239@123.com', '猴', '1f412.png', '2017-10-02 21:52:37', 'd32a72bdac524478b7e4f6dfc8394fc8'),(10, '鸡', '1240', '1240@123.com', '鸡', '1f413.png', '2017-10-02 21:52:41', 'd32a72bdac524478b7e4f6dfc8394fc9'),(11, '狗', '1241', '1241@123.com', '狗', '1f415.png', '2017-10-02 21:52:44', 'd32a72bdac524478b7e4f6dfc8394fd0'),(12, '猪', '1242', '1242@123.com', '猪', '1f416.png', '2017-10-02 21:52:48', 'd32a72bdac524478b7e4f6dfc8394fd1'),(13, 'test1', 'pbkdf2:sha256:50000$8jQUmDqI$66dc64caa21fb8aa51888f182e80a11268f845acecfccd445191fade375f10b1', 'aaaa@aa.com', NULL, NULL, '2017-10-05 17:43:23', '5a3f9ba58d7b4963b1e650bed0415357'),(14, 'test2', 'pbkdf2:sha256:50000$cbHh0s9q$220cc61f1e9d068da32720a928fbc33d03ebebd3f96e69e52436566806212eeb', 'bbbb@bb.com', '11111', '20171007144621_01ae00f91fc74a0eb43e4cee627c5f73.png', '2017-10-05 17:50:03', '279ece2eb77342c09326eace9a323600'),(15, 'test3', 'pbkdf2:sha256:50000$vDNT3ZV7$c60039aea5a3213d179d4733f2d35e4049d39610e5245ea0b79a93e70aaf3e14', 'cccc@aa.com', NULL, NULL, '2017-10-05 18:06:47', 'a0fa5c4e29a34a0f8ddbedb3236e706f'),(16, 'imoocmovie', 'pbkdf2:sha256:50000$YO1NBdr8$000d02efb4175bb723d69e38fc3474c621694f4ee2cf78c91edd678055bf0499', 'movie@qq.com', 'abcddd', '20171006011044_12827bea66f941e791ae31dfc98bd996.png', '2017-10-05 21:30:20', 'd1a3fccb51b7480a9de6013df1603c5e');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `heroku_91504066c035296`.`userlog` WRITE;
DELETE FROM `heroku_91504066c035296`.`userlog`;
INSERT INTO `heroku_91504066c035296`.`userlog` (`id`,`user_id`,`ip`,`addtime`) VALUES (1, 1, '192.168.4.1', '2017-10-03 20:26:06'),(2, 2, '192.168.4.2', '2017-10-03 20:26:06'),(3, 3, '192.168.4.3', '2017-10-03 20:26:06'),(4, 4, '192.168.4.4', '2017-10-03 20:26:06'),(5, 5, '192.168.4.5', '2017-10-03 20:26:06'),(6, 6, '192.168.4.6', '2017-10-03 20:26:06'),(7, 7, '192.168.4.7', '2017-10-03 20:26:06'),(8, 8, '192.168.4.8', '2017-10-03 20:26:06'),(9, 9, '192.168.4.9', '2017-10-03 20:26:06'),(10, 1, '192.168.4.1', '2017-10-03 20:26:10'),(11, 2, '192.168.4.2', '2017-10-03 20:26:10'),(12, 3, '192.168.4.3', '2017-10-03 20:26:10'),(13, 4, '192.168.4.4', '2017-10-03 20:26:10'),(14, 5, '192.168.4.5', '2017-10-03 20:26:10'),(15, 6, '192.168.4.6', '2017-10-03 20:26:10'),(16, 7, '192.168.4.7', '2017-10-03 20:26:10'),(17, 8, '192.168.4.8', '2017-10-03 20:26:10'),(18, 9, '192.168.4.9', '2017-10-03 20:26:10'),(19, 1, '192.168.4.1', '2017-10-03 20:26:11'),(20, 2, '192.168.4.2', '2017-10-03 20:26:11'),(21, 3, '192.168.4.3', '2017-10-03 20:26:11'),(22, 4, '192.168.4.4', '2017-10-03 20:26:11'),(23, 5, '192.168.4.5', '2017-10-03 20:26:11'),(24, 6, '192.168.4.6', '2017-10-03 20:26:11'),(25, 7, '192.168.4.7', '2017-10-03 20:26:11'),(26, 8, '192.168.4.8', '2017-10-03 20:26:11'),(27, 9, '192.168.4.9', '2017-10-03 20:26:11'),(28, 1, '192.168.4.1', '2017-10-03 20:26:12'),(29, 2, '192.168.4.2', '2017-10-03 20:26:12'),(30, 3, '192.168.4.3', '2017-10-03 20:26:12'),(31, 4, '192.168.4.4', '2017-10-03 20:26:12'),(32, 5, '192.168.4.5', '2017-10-03 20:26:12'),(33, 6, '192.168.4.6', '2017-10-03 20:26:12'),(34, 7, '192.168.4.7', '2017-10-03 20:26:12'),(35, 8, '192.168.4.8', '2017-10-03 20:26:12'),(36, 9, '192.168.4.9', '2017-10-03 20:26:12'),(37, 13, '127.0.0.1', '2017-10-05 20:51:50'),(38, 16, '127.0.0.1', '2017-10-05 21:30:23'),(39, 16, '127.0.0.1', '2017-10-05 23:18:58'),(40, 16, '127.0.0.1', '2017-10-06 11:07:57'),(41, 16, '127.0.0.1', '2017-10-06 11:10:29'),(42, 16, '127.0.0.1', '2017-10-06 11:41:33'),(43, 16, '127.0.0.1', '2017-10-06 11:41:35'),(44, 16, '127.0.0.1', '2017-10-06 11:41:36'),(45, 16, '127.0.0.1', '2017-10-06 11:41:38'),(46, 16, '127.0.0.1', '2017-10-06 11:41:40'),(47, 16, '127.0.0.1', '2017-10-06 11:41:41'),(48, 16, '127.0.0.1', '2017-10-06 11:41:43'),(49, 16, '127.0.0.1', '2017-10-06 11:41:58'),(50, 16, '127.0.0.1', '2017-10-06 11:42:01'),(51, 16, '127.0.0.1', '2017-10-06 21:52:44'),(52, 16, '127.0.0.1', '2017-10-07 11:17:16'),(53, 16, '127.0.0.1', '2017-10-07 11:33:39'),(54, 16, '127.0.0.1', '2017-10-07 13:27:17'),(55, 16, '127.0.0.1', '2017-10-07 13:27:34'),(56, 16, '127.0.0.1', '2017-10-07 14:43:04'),(57, 13, '127.0.0.1', '2017-10-07 14:43:50'),(58, 14, '127.0.0.1', '2017-10-07 14:44:23'),(59, 16, '127.0.0.1', '2017-10-07 14:47:21'),(60, 16, '127.0.0.1', '2017-10-07 17:13:33'),(61, 16, '127.0.0.1', '2017-10-07 17:22:17'),(62, 16, '127.0.0.1', '2017-10-07 17:23:15'),(63, 16, '127.0.0.1', '2017-10-07 17:23:21'),(64, 16, '127.0.0.1', '2017-10-07 18:44:11'),(65, 16, '127.0.0.1', '2017-10-07 19:33:20');
UNLOCK TABLES;
COMMIT;