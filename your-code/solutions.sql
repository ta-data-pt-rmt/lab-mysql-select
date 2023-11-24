/* Challenge 1 - Who Have Published What At Where?*/
USE publications;
SELECT * FROM authors LIMIT 5;
SELECT * FROM discounts LIMIT 5;
SELECT * FROM employee LIMIT 5;
SELECT * FROM jobs LIMIT 5;
SELECT * FROM pub_info LIMIT 5;
SELECT * FROM publishers LIMIT 5;
SELECT * FROM roysched LIMIT 5;
SELECT * FROM sales LIMIT 5;
SELECT * FROM stores LIMIT 5;
SELECT * FROM titleauthor LIMIT 5;
SELECT * FROM titles LIMIT 5;
/* From the information in each table, we know that author data(author id, first name and last name) are in table authors;
publishers contains publisher id and publisher name;
titleauthor contains author id and title id;
titles contains title id, title and publisher id;
Therefore, we can join table titles and table titleauthor, then table author and table publishers. */

DROP TABLE IF EXISTS title_name;
CREATE TEMPORARY TABLE title_name
SELECT titleauthor.au_id, titleauthor.title_id, titles.title, titles.pub_id
FROM titleauthor JOIN titles
ON titleauthor.title_id = titles.title_id;

SELECT * FROM title_name;

DROP TABLE IF EXISTS au_title_name;
CREATE TEMPORARY TABLE au_title_name
SELECT authors.au_id, authors.au_lname, authors.au_fname, title_name.title_id, title_name.title, title_name.pub_id
FROM authors RIGHT JOIN title_name
ON authors.au_id = title_name.au_id;

SELECT * FROM au_title_name;

DROP TABLE IF EXISTS au_title_pub;
CREATE TEMPORARY TABLE au_title_pub
SELECT au_title_name.au_id AS "AUTHOR ID", 
au_title_name.au_lname AS "LAST NAME", 
au_title_name.au_fname AS "FIRST NAME",
au_title_name.title AS "TITLE", 
publishers.pub_name AS PUBLISHER
FROM au_title_name LEFT JOIN publishers
ON au_title_name.pub_id = publishers.pub_id;

SELECT * FROM au_title_pub;

/* Challenge 2 - Who Have Published How Many At Where? 
In table au_title_pub, we can count how many records are from the same au_id*/

DROP TABLE IF EXISTS au_title_count;
CREATE TEMPORARY TABLE au_title_count
SELECT 
    `AUTHOR ID`,  -- Backticks used for column alias with spaces
    `LAST NAME`,  
    `FIRST NAME`, 
    `PUBLISHER`,
    COUNT(TITLE) AS TITLE_COUNT 
FROM 
    au_title_pub 
GROUP BY 
    `AUTHOR ID`, 
    `LAST NAME`, 
    `FIRST NAME`, 
    `PUBLISHER`;

SELECT * FROM au_title_count;

/* Challenge 3 - Best Selling Authors */
DROP TABLE IF EXISTS au_tile_sales;
CREATE TEMPORARY TABLE au_tile_sales
SELECT au_title_name.au_id AS "AUTHOR ID", 
au_title_name.au_lname AS "LAST NAME", 
au_title_name.au_fname AS "FIRST NAME",
SUM(sales.qty) AS TOTAL
FROM au_title_name LEFT JOIN sales
ON au_title_name.title_id = sales.title_id
GROUP BY
	`AUTHOR ID`,
    `LAST NAME`,
    `FIRST NAME`;
SELECT * FROM au_tile_sales ORDER BY TOTAL DESC LIMIT 3;

/* Challenge 4 - Best Selling Authors Ranking*/
SELECT au_title_name.au_id AS "AUTHOR ID", 
au_title_name.au_lname AS "LAST NAME", 
au_title_name.au_fname AS "FIRST NAME",
SUM(sales.qty) AS TOTAL
FROM au_title_name LEFT JOIN sales
ON au_title_name.title_id = sales.title_id
GROUP BY
	`AUTHOR ID`,
    `LAST NAME`,
    `FIRST NAME`;
SELECT * FROM au_tile_sales ORDER BY TOTAL DESC;
