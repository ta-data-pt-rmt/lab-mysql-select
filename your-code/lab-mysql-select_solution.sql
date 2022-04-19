USE publications;

/* Challenge 1 - Who Have Published What At Where? */

-- center Question is the start of the query
SELECT titles.title, publishers.pub_name AS 'Publisher'
FROM titles
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id;

-- first subquery
SELECT titleauthor.au_id, titleauthor.title_id, new_table.title, new_table.publisher AS 'Publisher'
FROM titleauthor
LEFT JOIN
(SELECT titles.title_id, titles.title, publishers.pub_name AS 'Publisher'
FROM titles
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id) AS new_table
ON titleauthor.title_id = new_table.title_id;

-- second subquery (FINAL QUERY)
SELECT authors.au_id AS 'Author ID', authors.au_lname AS 'Last Name', authors.au_fname AS 'First Name', new_table.title, new_table.publisher
FROM authors
INNER JOIN
(SELECT titleauthor.au_id, titleauthor.title_id, new_table.title, new_table.publisher AS 'Publisher'
FROM titleauthor
LEFT JOIN
(SELECT titles.title_id, titles.title, publishers.pub_name AS 'Publisher'
FROM titles
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id) AS new_table
ON titleauthor.title_id = new_table.title_id) AS new_table
ON authors.au_id = new_table.au_id;

-- to check if the number of rows is correct
SELECT COUNT(title_id) FROM titleauthor; -- Result: 25 (same as the query -> correct)

-- shorter solution (from Slack):
SELECT titleauthor.au_id AS "AUTHOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", titles.title AS "TITLE", publishers.pub_name AS "PUBLISHER"
FROM titleauthor
INNER JOIN authors ON titleauthor.au_id = authors.au_id
INNER JOIN  titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;


/* Challenge 2 - Who Have Published How Many At Where? */

SELECT titleauthor.au_id AS "AUTHOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", publishers.pub_name AS "PUBLISHER", COUNT(titles.title) AS "TITLE_COUNT"
FROM titleauthor
INNER JOIN authors ON titleauthor.au_id = authors.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titleauthor.au_id;

-- to check the sum of the table count (sum = 25 -> correct):
SELECT SUM(new_table.title_count)
FROM
(SELECT titleauthor.au_id AS "AUTHOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", publishers.pub_name AS "PUBLISHER", COUNT(titles.title) AS "TITLE_COUNT"
FROM titleauthor
INNER JOIN authors ON titleauthor.au_id = authors.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titleauthor.au_id) AS new_table


/* Challenge 3 - Best Selling Authors */

SELECT authors.au_id AS "AUTHOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", SUM(sales.qty) AS "TOTAL"
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY SUM(sales.qty) DESC
LIMIT 3;


/* Challenge 4 - Best Selling Authors Ranking */

-- first option (ifnull())
-- ifnull() returns an alternative value if an expression is NULL
SELECT authors.au_id AS "AUTHOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", SUM(IFNULL(sales.qty,0)) AS "TOTAL"
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id     -- inner join changed to left join
LEFT JOIN sales ON titleauthor.title_id = sales.title_id     -- inner join changed to left join
GROUP BY authors.au_id
ORDER BY SUM(sales.qty) DESC;

-- second option (coalesce())
-- COALESCE(SUM(sales.qty),0): COALESCE() function returns the first non-null value in a list
SELECT authors.au_id AS "AUTHOR ID", authors.au_lname AS "LAST NAME", authors.au_fname AS "FIRST NAME", COALESCE(SUM(sales.qty),0) AS "TOTAL"
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id     -- inner join changed to left join
LEFT JOIN sales ON titleauthor.title_id = sales.title_id     -- inner join changed to left join
GROUP BY authors.au_id
ORDER BY SUM(sales.qty) DESC;

