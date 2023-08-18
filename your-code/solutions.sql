USE publications;
SELECT COUNT(*) FROM titleauthor;

/* 1 - We have to match the 25 rows in titleauthor */
SELECT authors.au_id AS 'Author ID', au_lname AS 'Last name', au_fname AS 'First Name', titles.title AS 'Title', publishers.pub_name AS 'Publisher'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
order by authors.au_id;

SELECT COUNT(*) AS 'Total Rows'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;


/* 2 */
SELECT authors.au_id AS 'Author ID', 
       au_lname AS 'Last name', 
       au_fname AS 'First Name', 
       publishers.pub_name AS 'Publisher',
       COUNT(titles.title) AS 'Title Count'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, au_lname, au_fname, publishers.pub_name
ORDER BY authors.au_id;


/* 3 */
SELECT authors.au_id AS 'Author ID', 
       au_lname AS 'Last name', 
       au_fname AS 'First Name', 
       SUM(sales.qty) AS 'Total'
FROM authors
LEFT JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN sales ON titles.title_id=sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY SUM(qty) DESC
LIMIT 3;


/* 4 */
SELECT authors.au_id AS 'Author ID', 
       au_lname AS 'Last name', 
       au_fname AS 'First Name', 
       COALESCE(SUM(sales.qty),0) AS 'Total'
FROM authors
LEFT JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN sales ON titles.title_id=sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY SUM(qty) DESC


