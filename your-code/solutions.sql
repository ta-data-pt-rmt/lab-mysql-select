-- Lab | MySQL Select

USE publications;

SHOW TABLES;

SELECT COUNT(*) FROM titleauthor;
SELECT * FROM authors;
SELECT * FROM titles;
SELECT * FROM pub_info;
SELECT * FROM titleauthor;
SELECT * FROM publishers;
SELECT * FROM sales;

ALTER TABLE authors RENAME COLUMN au_id TO au_id_authors;


#Challenge 1
SELECT * FROM titleauthor
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN authors ON titleauthor.au_id = authors.au_id_authors
LEFT JOIN publishers ON titles.pub_id=publishers.pub_id;


#Challenge2
SELECT au_id_authors,au_lname,au_fname,pub_name, COUNT(titleauthor.title_id) AS 'Title_count' FROM titleauthor
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN authors ON titleauthor.au_id = au_id_authors
LEFT JOIN publishers ON titles.pub_id=publishers.pub_id 
GROUP BY au_id_authors
ORDER BY Title_count DESC;

#checking if Title_count colum sums 25
SELECT SUM(Title_count) FROM (
SELECT au_id_authors,au_lname,au_fname,pub_name, COUNT(titleauthor.title_id) AS 'Title_count' FROM titleauthor
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN authors ON titleauthor.au_id = au_id_authors
LEFT JOIN publishers ON titles.pub_id=publishers.pub_id 
GROUP BY au_id_authors
ORDER BY Title_count DESC) AS Sum_title_count;

#Challenge 3
SELECT au_id_authors,au_lname,au_fname, SUM(qty) AS total_sales FROM titleauthor
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN authors ON titleauthor.au_id = authors.au_id_authors
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY au_id_authors
ORDER BY total_sales DESC
LIMIT 3;


#Challenge 4
SELECT au_id_authors,au_lname,au_fname, COALESCE(SUM(qty),0) AS total_sales FROM authors
LEFT JOIN titleauthor ON authors.au_id_authors = titleauthor.au_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY au_id_authors
ORDER BY total_sales DESC;