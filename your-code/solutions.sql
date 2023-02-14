use `lab-mysql-select`;

/* Challenge 1 - Who Have Published What At Where? 
In this challenge you will write a MySQL `SELECT` query that joins various tables to figure out what titles each author has published at which publishers. Your output should have at least the following columns:

* `AUTHOR ID` - the ID of the author
* `LAST NAME` - author last name
* `FIRST NAME` - author first name
* `TITLE` - name of the published title
* `PUBLISHER` - name of the publisher where the title was published*/




SELECT au_id, au_lname,au_fname
FROM authors;

SELECT au_id, title_id
FROM titleauthor;

CREATE TEMPORARY TABLE publications
SELECT DISTINCT authors.au_id, authors.au_lname, authors.au_fname, titles.title, publishers.pub_name
FROM authors
INNER JOIN titleauthor
ON titleauthor.au_id = authors.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id;

SELECT *
FROM lab_mysql_select.publications;

SELECT *
FROM lab_mysql_select.titleauthor;

/*  Challenge 2 - Who Have Published How Many At Where? */

SELECT authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name, COUNT(titles.title)
FROM authors
INNER JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN publishers ON titles.pub_id=publishers.pub_id
GROUP BY au_id, au_lname, au_fname, pub_name;

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

SELECT authors.au_id, authors.au_lname, authors.au_fname, COALESCE(SUM(sales.qty),0)
FROM authors
LEFT JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN sales ON titles.title_id=sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY SUM(qty) DESC;