CREATE SCHEMA articles_active;
CREATE SCHEMA articles_archive;
CREATE SCHEMA general;

CREATE TABLE articles_active."articles" (
  "id" int NOT NULL AUTO_INCREMENT,
  "title" varchar(200) NOT NULL,
  "type" varchar(100) NOT NULL,
  "category" varchar(200) NOT NULL,
  "tags" varchar(200) NOT NULL,
  "summary" text NOT NULL,
  "body" text NOT NULL,
  "authors" varchar(200) NOT NULL,
  "date" date NOT NULL,
  "coverImg" varchar(200) NOT NULL,
  "artist" varchar(200) NOT NULL,
  "isOutstanding" BOOLEAN NOT NULL,
  PRIMARY KEY ("id")
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE articles_active."outstandingArticles" (
  "id" int NOT NULL,
  "title" varchar(200) NOT NULL,
  "type" varchar(100) NOT NULL,
  "tags" varchar(200) NOT NULL,
  "category" varchar(200) NOT NULL,
  "summary" text NOT NULL,
  "body" text NOT NULL,
  "authors" varchar(200) NOT NULL,
  "date" date NOT NULL,
  "coverImg" varchar(200) NOT NULL,
  "artist" varchar(200) NOT NULL,
  "isOutstanding" BOOLEAN NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_ArticleID" FOREIGN KEY ("id") REFERENCES "articles" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `articles_active`.`drafts` (
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
) ENGINE = InnoDB DEFAULT CHARACTER SET = latin1;

CREATE TABLE articles_archive."articles" (
  "id" int NOT NULL,
  "title" varchar(200) NOT NULL,
  "type" varchar(100) NOT NULL,
  "tags" varchar(200) NOT NULL,
  "category" varchar(200) NOT NULL,
  "summary" text NOT NULL,
  "body" text NOT NULL,
  "authors" varchar(200) NOT NULL,
  "date" date NOT NULL,
  "coverImg" varchar(200) NOT NULL,
  "artist" varchar(200) NOT NULL,
  "isOutstanding" BOOLEAN NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_ArticleID" FOREIGN KEY ("id") REFERENCES "articles" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE general."userRoles" (
  "id" int NOT NULL AUTO_INCREMENT,
  "roleName" varchar(200) NOT NULL,
  "permission" varchar(100) NOT NULL,
  PRIMARY KEY ("id")
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE general."user" (
  "id" int NOT NULL AUTO_INCREMENT,
  "name" varchar(200) NOT NULL,
  "roleId" int NOT NULL,
  "email" varchar(200) NOT NULL,
  "password" varchar(200) NOT NULL,
  "bio" text NOT NULL,
  "socialMedia" varchar(200) NOT NULL,
  "location" varchar(200) NOT NULL,
  "profession" varchar(200) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_RoleID" FOREIGN KEY ("id") REFERENCES "userRoles" ("id")
) ENGINE=InnoDB DEFAULT CHARSET=latin1;