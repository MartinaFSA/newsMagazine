DELIMITER $$
CREATE DEFINER="avnadmin"@"%" PROCEDURE "CopyOutstandingArticles"(IN articleIDparam INT)
BEGIN
-- Declare variables to hold values from "articles" table
    DECLARE articleId INT;
    DECLARE articleTitle VARCHAR(255);
    DECLARE articleType VARCHAR(50);
    DECLARE articleCategory VARCHAR(200);
    DECLARE articleTags VARCHAR(255);
    DECLARE articleSummary TEXT;
    DECLARE articleBody TEXT;
    DECLARE articleAuthors VARCHAR(255);
    DECLARE articleDate DATE;
    DECLARE articleCoverImg VARCHAR(255);
    DECLARE articleArtist VARCHAR(100);
    DECLARE isOutstandingValue BOOLEAN;
    DECLARE outstandingCount INT;
    
-- Declare a cursor for iterating through "articles" table
    DECLARE articleCursor CURSOR FOR
        SELECT * FROM `articles_active`.articles WHERE isOutstanding = 1 AND id = articleIDparam;

    DROP TEMPORARY TABLE IF EXISTS articleToCopy;
	CREATE TEMPORARY TABLE IF NOT EXISTS articleToCopy  (
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
	  "isOutstanding" tinyint(1) NOT NULL,
	  PRIMARY KEY ("id")
	);
    OPEN articleCursor;
    
-- If there are 6 or more outstanding articles, delete the one with the earliest date
    SELECT COUNT(*) INTO outstandingCount FROM `articles_active`.outstandingArticles;
	IF outstandingCount >= 6
		THEN DELETE FROM `articles_active`.outstandingArticles ORDER BY date ASC LIMIT 1;
	END IF;
	FETCH articleCursor INTO articleId, articleTitle, articleType, articleCategory, articleTags, articleSummary,
	articleBody, articleAuthors, articleDate, articleCoverImg, articleArtist, isOutstandingValue;
        
-- Insert the row into "outstandingArticles" table
	INSERT INTO articleToCopy VALUES (articleId, articleTitle, articleType, articleCategory, articleTags, articleSummary, articleBody, articleAuthors, articleDate, articleCoverImg, articleArtist, isOutstandingValue);
	INSERT INTO `articles_active`.outstandingArticles SELECT * FROM articleToCopy;

    CLOSE articleCursor;
END$$
DELIMITER ;
SELECT * FROM articles_active.articles;