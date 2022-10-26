# 1 - Who Have Published What At Where 

-- Here we want to estract info regarding two different tables: WHERE and WHO
-- We have learnt that the way of taking enriching information from two different table is either Left, Right or Inner join, lets see: --
-- First, inspect tables to see which data is useful and important for me --

USE lab_mysql_select;
SELECT * FROM authors; -- important to have first and last name
SELECT * FROM titleauthor; -- important to have the title author ID 
SELECT * FROM titles; -- important to have the titles obviously
SELECT * FROM publishers; -- To know the publisher name and location!
SELECT * FROM pub_info; -- not many info

SELECT authors.au_lname, authors.au_fname, titleauthor.au_id, titles.title, publishers.pub_name -- we need the title
FROM titleauthor
INNER JOIN authors ON titleauthor.au_id = authors.au_id -- common in Author ID
INNER JOIN titles ON titleauthor.title_id = titles.title_id -- common in Title ID
INNER JOIN publishers ON titles.pub_id = publishers.pub_id; -- common in Publishers ID

# 2 - Who Have Published How Many At Where -- Same as previous but we want to know additionally how MANY publications (COUNT)
SELECT authors.au_lname, authors.au_fname, titleauthor.au_id, titles.title, publishers.pub_name, COUNT(titles.title) -- Same as before, but now we want to count titles
FROM titleauthor
INNER JOIN authors ON titleauthor.au_id = authors.au_id -- common in Author ID
INNER JOIN titles ON titleauthor.title_id = titles.title_id -- common in Title ID
INNER JOIN publishers ON titles.pub_id = publishers.pub_id -- common in Publishers ID
GROUP BY titleauthor.au_id, publishers.pub_name
ORDER BY COUNT(titles.title) DESC;  -- we want to know the order of nº of published 

# 3 - Best Selling Authors -- who are the top 5 (for instance) AUTHORS? -- Take into account SALES!
SELECT * FROM sales; -- we inspect sales table --

SELECT authors.au_id, authors.au_fname, authors.au_lname, SUM(sales.qty) 
FROM authors 
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id -- Join authors and title author where they have in common (author ID)
INNER JOIN sales ON titleauthor.title_id = sales.title_id -- Join titleauthor and sales where they have in common (title ID)
GROUP BY authors.au_id -- What they have in common
ORDER BY SUM(sales.qty) DESC
LIMIT 5; -- Top 5

# 4 - Best Selling Authors Ranking
SELECT * FROM sales; -- Inspecting the table we can see that some values are null, so lets eliminate them with COALESCE

SELECT authors.au_id, authors.au_fname, authors.au_lname, coalesce(SUM(sales.qty), 0) -- Coalesce function will substitute the null values by 0
FROM authors 
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY SUM(sales.qty) DESC;