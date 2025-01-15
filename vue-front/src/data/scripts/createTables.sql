-- Create the database schema (use backticks for identifiers)
CREATE SCHEMA IF NOT EXISTS `freedb_newsPortal_db`;

-- Create the 'articles_active' table
CREATE TABLE `freedb_newsPortal_db`.`articles_active` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `type` VARCHAR(100) NOT NULL,
  `category` VARCHAR(200) NOT NULL,
  `tags` VARCHAR(200) NOT NULL,
  `summary` TEXT NOT NULL,
  `body` TEXT NOT NULL,
  `authors` VARCHAR(200) NOT NULL,
  `date` DATE NOT NULL,
  `coverImg` VARCHAR(200) NOT NULL,
  `artist` VARCHAR(200) NOT NULL,
  `isOutstanding` BOOLEAN NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create the 'outstandingArticles' table with a correct foreign key reference
CREATE TABLE `freedb_newsPortal_db`.`outstandingArticles` (
  `id` INT NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `type` VARCHAR(100) NOT NULL,
  `tags` VARCHAR(200) NOT NULL,
  `category` VARCHAR(200) NOT NULL,
  `summary` TEXT NOT NULL,
  `body` TEXT NOT NULL,
  `authors` VARCHAR(200) NOT NULL,
  `date` DATE NOT NULL,
  `coverImg` VARCHAR(200) NOT NULL,
  `artist` VARCHAR(200) NOT NULL,
  `isOutstanding` BOOLEAN NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_ArticleID` FOREIGN KEY (`id`) REFERENCES `articles_active` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create the 'drafts' table
CREATE TABLE `freedb_newsPortal_db`.`drafts` (
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

-- Create the 'articles_archive' table with corrected foreign key reference
CREATE TABLE `freedb_newsPortal_db`.`articles_archive` (
  `id` INT NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `type` VARCHAR(100) NOT NULL,
  `tags` VARCHAR(200) NOT NULL,
  `category` VARCHAR(200) NOT NULL,
  `summary` TEXT NOT NULL,
  `body` TEXT NOT NULL,
  `authors` VARCHAR(200) NOT NULL,
  `date` DATE NOT NULL,
  `coverImg` VARCHAR(200) NOT NULL,
  `artist` VARCHAR(200) NOT NULL,
  `isOutstanding` BOOLEAN NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_ArticleID` FOREIGN KEY (`id`) REFERENCES `articles_active` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create the 'userRoles' table
CREATE TABLE `freedb_newsPortal_db`.`userRoles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(200) NOT NULL,
  `permission` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create the 'user' table with corrected foreign key reference
CREATE TABLE `freedb_newsPortal_db`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `roleId` INT NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `bio` TEXT NOT NULL,
  `socialMedia` VARCHAR(200) NOT NULL,
  `location` VARCHAR(200) NOT NULL,
  `profession` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_RoleID` FOREIGN KEY (`roleId`) REFERENCES `userRoles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
