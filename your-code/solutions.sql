/*CHALLENGE 1*/
/*What titles each author has published at which publishers.*/
USE lab_mysql_2;

/*Match titles with publishers*/
(SELECT titles.title AS TITLE, publishers.pub_name AS PUBLISHER, titles.title_id
FROM titles
INNER JOIN publishers
ON publishers.pub_id = titles.pub_id);

/*Match with author_id*/
SELECT titleauthor.au_id AS AUTHOR_ID, TITLE, PUBLISHER
FROM titleauthor
JOIN (SELECT titles.title AS TITLE, publishers.pub_name AS PUBLISHER, titles.title_id
FROM titles
INNER JOIN publishers
ON publishers.pub_id = titles.pub_id)
AS publisher_title
ON publisher_title.title_id = titleauthor.title_id;

/*Enrich with Last and First Name*/
SELECT AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME,TITLE, PUBLISHER
FROM authors
JOIN(SELECT titleauthor.au_id AS AUTHOR_ID, TITLE, PUBLISHER
FROM titleauthor
JOIN (SELECT titles.title AS TITLE, publishers.pub_name AS PUBLISHER, titles.title_id
FROM titles
INNER JOIN publishers
ON publishers.pub_id = titles.pub_id)
AS publisher_title
ON publisher_title.title_id = titleauthor.title_id)
AS author_title_publisher
ON author_title_publisher.AUTHOR_ID = authors.au_id;


/*CHALLENGE 2*/
/*Who Have Published How Many At Where?.*/

CREATE TEMPORARY TABLE lab_mysql_2.author_published
SELECT AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME,TITLE, PUBLISHER
FROM authors
JOIN(SELECT titleauthor.au_id AS AUTHOR_ID, TITLE, PUBLISHER
FROM titleauthor
JOIN (SELECT titles.title AS TITLE, publishers.pub_name AS PUBLISHER, titles.title_id
FROM titles
INNER JOIN publishers
ON publishers.pub_id = titles.pub_id)
AS publisher_title
ON publisher_title.title_id = titleauthor.title_id)
AS author_title_publisher
ON author_title_publisher.AUTHOR_ID = authors.au_id;

SELECT AUTHOR_ID,LAST_NAME,FIRST_NAME,TITLE,PUBLISHER, COUNT(*) AS TITLE_COUNT FROM author_published GROUP BY AUTHOR_ID;


/*CHALLENGE 3*/
/*Best Selling Authors.*/

CREATE TEMPORARY TABLE lab_mysql_2.sales_author
SELECT AUTHOR_ID,LAST_NAME,FIRST_NAME,TITLE,sales.qty AS QUANTITY
FROM sales
JOIN(SELECT AUTHOR_ID,LAST_NAME,FIRST_NAME,author_published.TITLE,PUBLISHER,titles.title_id
FROM titles
INNER JOIN author_published
ON titles.title = author_published.TITLE)
AS author_published_titleID
ON author_published_titleID.title_id = sales.title_id;

SELECT AUTHOR_ID,LAST_NAME,FIRST_NAME,SUM(QUANTITY)
FROM sales_author
GROUP BY AUTHOR_ID
ORDER BY SUM(QUANTITY) DESC
LIMIT 3;


/*CHALLENGE 4*/
/*Best Selling Authors Ranking.*/

CREATE TEMPORARY TABLE lab_mysql_2.sales_author_total
SELECT AUTHOR_ID,LAST_NAME,FIRST_NAME,TITLE,sales.qty AS QUANTITY
FROM sales
RIGHT JOIN(SELECT AUTHOR_ID,LAST_NAME,FIRST_NAME,author_published.TITLE,PUBLISHER,titles.title_id
FROM titles
INNER JOIN author_published
ON titles.title = author_published.TITLE)
AS author_published_titleID
ON author_published_titleID.title_id = sales.title_id;


SELECT AUTHOR_ID,LAST_NAME,FIRST_NAME,COALESCE(SUM(QUANTITY),0) AS TOTAL
FROM sales_author_total
GROUP BY AUTHOR_ID
ORDER BY SUM(QUANTITY) DESC;
