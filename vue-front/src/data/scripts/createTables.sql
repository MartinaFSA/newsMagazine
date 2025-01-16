-- Create the database schema (use backticks for identifiers)
CREATE SCHEMA IF NOT EXISTS `newsPortal`;

DROP TABLE IF EXISTS `articles_active`;
CREATE TABLE `articles_active` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `type` varchar(100) NOT NULL,
  `category` varchar(45) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `summary` text NOT NULL,
  `body` text NOT NULL,
  `authors` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coverImg` varchar(200) NOT NULL,
  `artist` varchar(200) NOT NULL,
  `route` varchar(200) NOT NULL,
  `isOutstanding` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Create the 'outstanding_articles' table
DROP TABLE IF EXISTS `outstanding_articles`;
CREATE TABLE `outstanding_articles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `type` varchar(100) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `summary` text NOT NULL,
  `body` text NOT NULL,
  `authors` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coverImg` varchar(200) NOT NULL,
  `artist` varchar(200) NOT NULL,
  `route` varchar(200) NOT NULL,
  `isOutstanding` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

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

DROP TABLE IF EXISTS `articles_archive`;
CREATE TABLE `articles_archive` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `type` varchar(100) NOT NULL,
  `tags` varchar(200) NOT NULL,
  `summary` text NOT NULL,
  `body` text NOT NULL,
  `authors` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coverImg` varchar(200) NOT NULL,
  `artist` varchar(200) NOT NULL,
  `route` varchar(200) NOT NULL,
  `isOutstanding` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
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