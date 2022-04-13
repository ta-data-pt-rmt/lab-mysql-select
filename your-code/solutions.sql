USE published;
SELECT * FROM authors;
SELECT * FROM titleauthor;
SELECT * FROM titles;
SELECT * FROM sales;
-- Challenge 1 - Who Have Published What At Where?
SELECT a.au_id AS AUTHOR_ID ,a.au_lname AS LAST_NAME, a.au_fname AS FIRS_NAME, t.title TITLE,p.pub_name AS PUBLISHER
FROM authors AS a 
INNER JOIN titleauthor AS ta ON a.au_id = ta.au_id
INNER JOIN titles AS t ON ta.title_id = t.title_id
INNER JOIN publishers AS p ON t.pub_id = p.pub_id
ORDER BY a.au_id ASC;

-- Challenge 1 - Who Have Published What At Where?

SELECT a.au_id AS AUTHOR_ID ,a.au_lname AS LAST_NAME, a.au_fname AS FIRS_NAME,p.pub_name AS PUBLISHER,COUNT(t.title) AS TITLE_COUNT
FROM authors AS a 
INNER JOIN titleauthor AS ta ON a.au_id = ta.au_id
INNER JOIN titles AS t ON ta.title_id = t.title_id
INNER JOIN publishers AS p ON t.pub_id = p.pub_id
GROUP by AUTHOR_ID, PUBLISHER
ORDER BY TITLE_COUNT DESC;

-- Challenge 3 - Best Selling Authors
SELECT a.au_id AS AUTHOR_ID , a.au_lname AS LAST_NAME, a.au_fname AS FIRS_NAME, SUM(s.qty) AS TOTAL
FROM authors AS a 
LEFT JOIN titleauthor AS ta ON ta.au_id = a.au_id
LEFT JOIN titles AS t ON ta.title_id = t.title_id
LEFT JOIN sales AS s ON s.title_id = t.title_id
GROUP BY AUTHOR_ID
ORDER BY TOTAL DESC
lIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking
SELECT a.au_id AS AUTHOR_ID , a.au_lname AS LAST_NAME, a.au_fname AS FIRS_NAME, COALESCE(SUM(s.qty),0) AS TOTAL
FROM authors AS a 
LEFT JOIN titleauthor AS ta ON ta.au_id = a.au_id
LEFT JOIN titles AS t ON ta.title_id = t.title_id
LEFT JOIN sales AS s ON s.title_id = t.title_id
GROUP BY AUTHOR_ID
ORDER BY TOTAL DESC;

