
USE `publications`;


/* ###################
   ##  Challenge 1  ##
   ################### */

/* Who have published what at where? */

SELECT titleauthor.au_id AS `AUTHOR ID`, au_lname AS `LAST NAME`, au_fname AS `FIRST NAME`, title AS TITLE, pub_name AS PUBLISHER
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id;


/* ###################
   ##  Challenge 2  ##
   ################### */

/* Who have published how many at where? */

SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, PUBLISHER, COUNT(TITLE) AS `TITLE COUNT` FROM
(SELECT titleauthor.au_id AS `AUTHOR ID`, au_lname AS `LAST NAME`, au_fname AS `FIRST NAME`, title AS TITLE, pub_name AS PUBLISHER
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id) who_what_where
GROUP BY `AUTHOR ID`, PUBLISHER;


/* ###################
   ##  Challenge 3  ##
   ################### */

/* Best selling authors */

SELECT * FROM (
SELECT authors.au_id AS `AUTHOR ID`, au_lname AS `LAST NAME`, au_fname AS `FIRST NAME`, SUM(qty) AS TOTAL, RANK() OVER(ORDER BY SUM(qty) DESC) AS `RANK`
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY `AUTHOR ID`
ORDER BY TOTAL DESC) author_sales
WHERE `RANK` <= 3;

/* 'LIMIT = 3' is insufficient here since several authors with the exact sales figures are ranked 3rd. */


/* ###################
   ##  Challenge 4  ##
   ################### */

/* Best selling authors ranking */

SELECT authors.au_id AS `AUTHOR ID`, au_lname AS `LAST NAME`, au_fname AS `FIRST NAME`, COALESCE(SUM(qty), 0) AS TOTAL
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY `AUTHOR ID`
ORDER BY TOTAL DESC;
