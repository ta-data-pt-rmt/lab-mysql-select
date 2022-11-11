/* Challenge 1 - Who Have Published What At Where? */

SELECT au_id, au_lname,au_fname
FROM lab_mysql_select.authors;

SELECT au_id, title_id
FROM lab_mysql_select.titleauthor;

CREATE TEMPORARY TABLE lab_mysql_select.publications
SELECT DISTINCT authors.au_id, authors.au_lname, authors.au_fname, titles.title, publishers.pub_name
FROM lab_mysql_select.authors
INNER JOIN lab_mysql_select.titleauthor
ON lab_mysql_select.titleauthor.au_id = lab_mysql_select.authors.au_id
INNER JOIN lab_mysql_select.titles
ON lab_mysql_select.titleauthor.title_id = lab_mysql_select.titles.title_id
INNER JOIN lab_mysql_select.publishers
ON lab_mysql_select.titles.pub_id = lab_mysql_select.publishers.pub_id;

SELECT *
FROM lab_mysql_select.publications;

SELECT *
FROM lab_mysql_select.titleauthor;

/*  Challenge 2 - Who Have Published How Many At Where? */

SELECT publications.au_id,publications.au_lname, publications.au_fname, publications.pub_name,
COUNT(publications.au_id) AS Title_count
FROM lab_mysql_select.publications
GROUP BY publications.au_id , publications.pub_name, publications.au_lname, publications.au_fname;

SELECT *
FROM lab_mysql_select.titleauthor;

/* Challenge 3 - Best Selling Authors */

SELECT title_id, title, ytd_sales
FROM lab_mysql_select.titles
ORDER BY ytd_sales DESC;

CREATE TEMPORARY TABLE lab_mysql_select.best_sells
SELECT DISTINCT publications.au_id, publications.au_lname, publications.au_fname, titles.title, titles.ytd_sales
FROM lab_mysql_select.publications
INNER JOIN lab_mysql_select.titles
ON lab_mysql_select.publications.title = lab_mysql_select.titles.title
ORDER BY ytd_sales DESC LIMIT 3;

SELECT *
FROM lab_mysql_select.best_sells;

/* Challenge 4 - Best Selling Authors Ranking */

CREATE TEMPORARY TABLE lab_mysql_select.almost_best_sells
SELECT DISTINCT publications.au_id, publications.au_lname, publications.au_fname, titles.title, titles.ytd_sales
FROM lab_mysql_select.publications
INNER JOIN lab_mysql_select.titles
ON lab_mysql_select.publications.title = lab_mysql_select.titles.title
ORDER BY ytd_sales DESC LIMIT 23;

SELECT *
FROM lab_mysql_select.almost_best_sells;

/* I don't see Null values, I don't know why */
