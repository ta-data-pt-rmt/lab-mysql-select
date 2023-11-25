CREATE DATABASE publications;
USE publications;

-- Challenge 1 - Who Have Published What At Where?
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title, publishers.pub_name
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id;

-- Challenge 2 - Who Have Published How Many At Where?

SELECT authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name, COUNT(titles.title_id) AS title_count
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;

-- Challenge 3 - Top 3 Best Selling Authors

SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(sales.title_id) AS total
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY total DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking

SELECT authors.au_id, authors.au_lname, authors.au_fname, COALESCE(COUNT(sales.title_id), 0) AS total
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY total DESC;
