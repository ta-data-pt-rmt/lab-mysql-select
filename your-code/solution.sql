USE Publications2;

-- Challenge 1 - Who Have Published What At Where?

CREATE VIEW AuthorTitlePublisher AS
-- create a view in MySQL to store the result of the query as a virtual table. 
-- This allows you to reference the view in subsequent queries
SELECT Authors.au_id AS 'AUTHOR ID',
       Authors.au_lname AS 'LAST NAME',
       Authors.au_fname AS 'FIRST NAME',
       Titles.title AS 'TITLE',
       Publishers.pub_name AS 'PUBLISHER'
FROM Authors
JOIN TitleAuthor ON Authors.au_id = TitleAuthor.au_id
JOIN Titles ON TitleAuthor.title_id = Titles.title_id
JOIN Publishers ON Titles.pub_id = Publishers.pub_id;

-- Count the total number of records in titleauthor
SELECT COUNT(*) AS 'Total TitleAuthor Records' FROM TitleAuthor;

-- Both have 25 rows.

-- Challenge 2 - Who Have Published How Many At Where?

CREATE VIEW AuthorTitlePublisherWithCount AS
SELECT Authors.au_id AS 'AUTHOR ID',
       Authors.au_lname AS 'LAST NAME',
       Authors.au_fname AS 'FIRST NAME',
       Publishers.pub_name AS 'PUBLISHER',
       COUNT(*) AS 'TITLE COUNT'
FROM Authors
JOIN TitleAuthor ON Authors.au_id = TitleAuthor.au_id
JOIN Titles ON TitleAuthor.title_id = Titles.title_id
JOIN Publishers ON Titles.pub_id = Publishers.pub_id
GROUP BY Authors.au_id, Titles.title, Publishers.pub_name;

SELECT * 
FROM AuthorTitlePublisherWithCount;

-- Calculate the total title count across all authors
SELECT SUM(`TITLE COUNT`) AS `TOTAL TITLE COUNT`
FROM AuthorTitlePublisherWithCount;

-- Both have 25 rows.

-- Challenge 3 - Best Selling Authors

CREATE VIEW BestSellingAuthors AS
SELECT
    Authors.au_id AS 'AUTHOR ID',
    Authors.au_lname AS 'LAST NAME',
    Authors.au_fname AS 'FIRST NAME',
    COUNT(*) AS 'TOTAL'
FROM
    Authors
JOIN
    TitleAuthor ON Authors.au_id = TitleAuthor.au_id
GROUP BY
    Authors.au_id, Authors.au_lname, Authors.au_fname
ORDER BY
    TOTAL DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking
SELECT
    Authors.au_id AS 'AUTHOR ID',
    Authors.au_lname AS 'LAST NAME',
    Authors.au_fname AS 'FIRST NAME',
    COUNT(TitleAuthor.title_id) AS 'TOTAL'
FROM
    Authors
LEFT JOIN 
-- LEFT JOIN to ensure that all authors from the Authors table are 
-- included, even if they haven't sold any titles
    TitleAuthor ON Authors.au_id = TitleAuthor.au_id
GROUP BY
    Authors.au_id, Authors.au_lname, Authors.au_fname
ORDER BY
    TOTAL DESC;



