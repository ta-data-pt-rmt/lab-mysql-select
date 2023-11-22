USE publications;

-- Challenge 1 - Who Have Published What At Where?

SELECT authors.au_id AS 'Author ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', titles.title AS 'TITLE', publishers.pub_name AS 'PUBLISHER'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles USING (title_id)
INNER JOIN publishers USING (pub_id);

-- Challenge 2 - Who Have Published How Many At Where?

SELECT authors.au_id AS 'Author ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', COUNT(titles.title) AS 'TITLE COUNT', publishers.pub_name AS 'PUBLISHER'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles USING (title_id)
INNER JOIN publishers USING (pub_id)
GROUP BY authors.au_id,publishers.pub_name;

-- Challenge 3 - Best Selling Authors

SELECT authors.au_id AS 'Author ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', SUM(sales.qty) AS 'TOTAL'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles USING (title_id)
INNER JOIN sales USING (title_id)
GROUP BY authors.au_id
ORDER BY TOTAL DESC
LIMIT 3; 

-- Challenge 4 - Best Selling Authors Ranking

SELECT authors.au_id AS 'Author ID', authors.au_lname AS 'LAST NAME', authors.au_fname AS 'FIRST NAME', IFNULL(SUM(sales.qty), 0) AS 'TOTAL'
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles USING (title_id)
LEFT JOIN sales USING (title_id)
GROUP BY authors.au_id
ORDER BY TOTAL DESC;
