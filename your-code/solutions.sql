SELECT * FROM authors;
SELECT * FROM discounts;
SELECT * FROM jobs;
SELECT * FROM pub_info;
SELECT * FROM publishers;
SELECT * FROM roysched;
SELECT * FROM sales;
SELECT * FROM stores;
SELECT * FROM titleauthor;
SELECT * FROM titles;

/* Challenge 1 - Who Have Published What At Where? */

CREATE TEMPORARY TABLE table1
SELECT authors.au_id, authors.au_lname, authors.au_fname, 
		titleauthor.title_id, titleauthor.au_ord
FROM titleauthor
LEFT JOIN authors 
ON titleauthor.au_id = authors.au_id;

CREATE TEMPORARY TABLE table2
SELECT titles.title_id, titles.title, publishers.pub_name
FROM titles
LEFT JOIN publishers 
ON titles.pub_id = publishers.pub_id;

CREATE TEMPORARY TABLE table3
SELECT  table1.au_id, table1.au_lname, table1.au_fname, table1.title_id, table1.au_ord, 
		table2.title, table2.pub_name
FROM table1
LEFT JOIN table2 
ON table1.title_id = table2.title_id;


/* Challenge 2 - Who Have Published How Many At Where? */

SELECT au_id, au_lname, au_fname,pub_name, COUNT(title)
FROM table3
GROUP BY table3.au_id, table3.pub_name;

/* Challenge 3 - Best Selling Authors */
/* Who are the top 3 authors who have sold the highest number of titles? Write a query to find out. */

CREATE TEMPORARY TABLE table4
SELECT title_id, SUM(qty) as Total_Sales
FROM sales 
GROUP BY sales.title_id;

CREATE TEMPORARY TABLE table5
SELECT  table1.au_id, table1.au_lname, table1.au_fname, table1.title_id, table1.au_ord, 
		table4.Total_Sales
FROM table4 
LEFT JOIN table1 
ON table1.title_id = table4.title_id;

SELECT au_id, au_lname, au_fname, title_id, au_ord, SUM(Total_Sales) AS Tot_Sales_Author
FROM table5
GROUP BY table5.au_id
ORDER BY Tot_Sales_Author DESC
LIMIT 3;

/* Challenge 4 - Best Selling Authors Ranking */

SELECT au_id, au_lname, au_fname, title_id, au_ord, SUM(Total_Sales) AS Tot_Sales_Author
FROM table5
GROUP BY table5.au_id
ORDER BY Tot_Sales_Author DESC
LIMIT 23;
