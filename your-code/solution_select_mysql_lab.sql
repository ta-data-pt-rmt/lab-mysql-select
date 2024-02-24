/*Challenge 1: Who Have Published What At Where?*/
use austin_weather;

select * from authors;
select * from titles;
select * from publishers;
select * from titleauthor Limit 5;
select COUNT(au_id) from titleauthor;

/* We need the ID, au_fname, au_lname from authors table 
publisher_name from the publishers table 
title from titles table*/


DROP TABLE IF EXISTS aux_titles;
CREATE TEMPORARY TABLE aux_titles
SELECT titles.title_id, publishers.pub_name, titles.title
FROM titles RIGHT JOIN publishers
ON titles.pub_id = publishers.pub_id;

DROP TABLE IF EXISTS aux_authors;
CREATE TEMPORARY TABLE aux_authors
SELECT titleauthor.au_id, aux_titles.pub_name, aux_titles.title, aux_titles.title_id
FROM titleauthor RIGHT JOIN aux_titles
ON titleauthor.title_id = aux_titles.title_id;

SELECT * FROM aux_authors;

DROP TABLE IF EXISTS aux_table;
CREATE TEMPORARY TABLE aux_table
SELECT authors.au_id AS "AUTHOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME",
aux_authors.title AS "TITLE", aux_authors.pub_name AS "PUBLISHER", aux_authors.title_id
FROM authors RIGHT JOIN aux_authors
ON authors.au_id = aux_authors.au_id;

SELECT * FROM aux_table;

SELECT COUNT(authors.au_id) FROM aux_table;

/*Challenge 2: Who Have Published How Many At Where? */

SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`, COUNT(`TITLE`) AS "TITLE_COUNT"
FROM aux_table
GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`;

SELECT SUM(TITLE_COUNT) AS TOTAL_TITLE_COUNT
FROM (
    SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`, COUNT(`TITLE`) AS "TITLE_COUNT"
    FROM aux_table
    GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`
) AS subquery;

SELECT COUNT(au_id) FROM titleauthor;

/*Looks good*/

/* Challenge 3 - Best Selling Authors */
DROP TABLE IF EXISTS aux_sales;
CREATE TEMPORARY TABLE aux_sales
SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`,
SUM(sales.qty) AS TOTAL
FROM aux_table LEFT JOIN sales
ON aux_table.title_id = sales.title_id
GROUP BY
	`AUTHOR ID`,
    `LAST NAME`,
    `FIRST NAME`;
    
SELECT * FROM aux_sales ORDER BY TOTAL DESC LIMIT 3;