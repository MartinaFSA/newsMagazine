-- Create the database schema (use backticks for identifiers)
CREATE DATABASE IF NOT EXISTS `newsPortal`;
USE `newsPortal`;

DROP TABLE IF EXISTS `articles_active`;
CREATE TABLE `articles_active` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `type` int NOT NULL,
  `tags` varchar(200) NOT NULL,
  `summary` text NOT NULL,
  `body` text NOT NULL,
  `authors` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coverImg` varchar(200) NOT NULL,
  `artist` int NOT NULL,
  `isOutstanding` tinyint(1) NOT NULL DEFAULT '0',
  `category` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_artist_idx` (`artist`),
  KEY `fk_articleType_idx` (`type`),
  KEY `fk_articleCategory_idx` (`category`),
  CONSTRAINT `fk_articleArtist` FOREIGN KEY (`artist`) REFERENCES `professions` (`id`),
  CONSTRAINT `fk_articleCategory` FOREIGN KEY (`category`) REFERENCES `categories` (`id`),
  CONSTRAINT `fk_articleType` FOREIGN KEY (`type`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Create the 'outstanding_articles' table
DROP TABLE IF EXISTS `outstanding_articles`;
CREATE TABLE `outstanding_articles` (
  `id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `type` int NOT NULL,
  `tags` varchar(200) NOT NULL,
  `summary` text NOT NULL,
  `body` text NOT NULL,
  `authors` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coverImg` varchar(200) NOT NULL,
  `artist` int NOT NULL,
  `isOutstanding` tinyint(1) NOT NULL DEFAULT '0',
  `category` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Create the 'drafts' table
CREATE TABLE `newsPortal`.`drafts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `type` VARCHAR(100) NULL,
  `category` VARCHAR(200) NULL,
  `tags` VARCHAR(200) NULL,
  `summary` TEXT NULL,
  `body` TEXT NULL,
  `authors` VARCHAR(200) NOT NULL,
  `date` DATE NULL,
  `coverImg` VARCHAR(200) NULL,
  `artist` VARCHAR(200) NULL,
  `isOutstanding` TINYINT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE DATABASE  IF NOT EXISTS `articles_active`;
USE `articles_active`;

DROP TABLE IF EXISTS `articles_archive`;
CREATE TABLE `articles_archive` (
  `id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `type` int NOT NULL,
  `tags` varchar(200) NOT NULL,
  `summary` text NOT NULL,
  `body` text NOT NULL,
  `authors` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coverImg` varchar(200) NOT NULL,
  `artist` int NOT NULL,
  `isOutstanding` tinyint(1) NOT NULL DEFAULT '0',
  `category` int NOT NULL,
  PRIMARY KEY (`id`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Create the 'userRoles' table
DROP TABLE IF EXISTS `userprivileges`;
CREATE TABLE `userprivileges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `permission` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Create the 'user' tablenewsPortal
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `privilege` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `bio` text NOT NULL,
  `socialMedia` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(155) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `collaborators` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `profession` int NOT NULL,
  `bio` longtext NOT NULL,
  `socialmedia` varchar(255) DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_collaborator_idx` (`profession`),
  CONSTRAINT `fk_collaborator` FOREIGN KEY (`profession`) REFERENCES `professions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `professions`;
CREATE TABLE `professions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profession` varchar(155) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `id` int NOT NULL,
  `name` varchar(155) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `userprivileges`;
CREATE TABLE `userprivileges` (
  `id` int DEFAULT NULL,
  `name` text,
  `permission` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;