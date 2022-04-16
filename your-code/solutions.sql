## Challenge 1 - Who Have Published What At Where? --> total rows in output = 25

SELECT COUNT(*) FROM titleauthor;

CREATE TEMPORARY TABLE auth_title
SELECT
 authors.au_id,
 authors.au_lname,
 authors.au_fname,
 titleauthor.title_id
 FROM authors
 JOIN titleauthor ON authors.au_id = titleauthor.au_id;
  
CREATE TEMPORARY TABLE auth_title2
SELECT
auth_title.*,
titles.pub_id,
titles.title
FROM auth_title
JOIN titles ON auth_title.title_id = titles.title_id;

SELECT
auth_title2.au_id AS "Author ID",
auth_title2.au_lname AS "Last Name",
auth_title2.au_fname AS "First Name",
auth_title2.title AS "Title",
publishers.pub_name AS "Publishers"
FROM auth_title2
JOIN publishers ON auth_title2.pub_id = publishers.pub_id;

CREATE TABLE challenge_1
SELECT
auth_title2.au_id AS "Author_ID",
auth_title2.au_lname AS "Last_Name",
auth_title2.au_fname AS "First_Name",
auth_title2.title AS "Title",
publishers.pub_name AS "Publishers"
FROM auth_title2
JOIN publishers ON auth_title2.pub_id = publishers.pub_id;


## Challenge 2 - Who Have Published How Many At Where?

SELECT * FROM auth_title2

SELECT
auth_title2.au_id AS "Author_ID",
auth_title2.au_lname AS "Last_Name",
auth_title2.au_fname AS "First_Name",
publishers.pub_name AS "Publishers",
COUNT(auth_title2.title) AS "Title Count"
FROM auth_title2
JOIN publishers ON auth_title2.pub_id = publishers.pub_id
GROUP BY auth_title2.au_id WITH ROLLUP;


## Challenge 3 - Best Selling Authors --> I don't know how to do this part: * Only output the top 3 best selling authors.

SELECT
 authors.au_id AS "Author_ID",
 authors.au_lname AS "Last_Name",
 authors.au_fname AS "First_Name",
 COUNT(titleauthor.title_id) AS "Total"
 FROM authors
 JOIN titleauthor ON authors.au_id = titleauthor.au_id
 GROUP BY authors.au_id
 ORDER BY COUNT("Total") DESC;

## Challenge 4 - Best Selling Authors Ranking
 
 SELECT
 authors.au_id AS "Author_ID",
 authors.au_lname AS "Last_Name",
 authors.au_fname AS "First_Name",
 COUNT(titleauthor.title_id) AS "Total"
 FROM authors
 JOIN titleauthor ON authors.au_id = titleauthor.au_id
 GROUP BY authors.au_id
 ORDER BY COUNT("Total") DESC