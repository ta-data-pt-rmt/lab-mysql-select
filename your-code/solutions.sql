#Patricia Yañez Piqueras
USE publications;
/* 
Challenge 1 - Who Have Published What At Where?
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published 
*/

SELECT 
authors.au_id AS "AUTHOR ID", 
authors.au_lname AS "LAST NAME",
authors.au_fname AS "FIRST NAME",
titles.title AS "TITLE",
publishers.pub_name AS PUBLISHER
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id
;


/* 25 rows in my table, 25 rows titleauthor table */

/*
Challenge 2 - Who Have Published How Many At Where?
*/
SELECT 
authors.au_id AS "AUTHOR ID", 
authors.au_lname AS "LAST NAME",
authors.au_fname AS "FIRST NAME",
publishers.pub_name AS PUBLISHER,
COUNT(titles.title) AS "TITLE COUNT"
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id
;

/*Challenge 3 - Best Selling Authors
I´VE USED LIMIT 5 INSTEAD OF LIMIT 3 BECAUSE THERE ARE 3 AUTHORS WITH SAME TOTAL NUMBER OF SALES THAT ARE ACTUALLY IN PLACE NUMBER 3:
*/

SELECT 
authors.au_id AS "AUTHOR ID", 
authors.au_lname AS "LAST NAME",
authors.au_fname AS "FIRST NAME",
SUM(sales.qty) AS TOTAL
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
#INNER JOIN publishers
#ON titles.pub_id = publishers.pub_id
INNER JOIN sales
ON titles.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY TOTAL DESC
LIMIT 5 
;

/*
Challenge 4 - Best Selling Authors Ranking
*/

SELECT 
authors.au_id AS "AUTHOR ID", 
authors.au_lname AS "LAST NAME",
authors.au_fname AS "FIRST NAME",
IFNULL(SUM(sales.qty),0) AS TOTAL
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN sales
ON titles.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY TOTAL DESC
LIMIT 23
;