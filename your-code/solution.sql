USE publications;

/*Challenge 1 - Who Have Published What At Where?*/
SELECT a.au_id AS "AUTHOR ID", b.au_lname AS "LAST NAME", b.au_fname AS "FIRST NAME", c.title AS "TITLE", d.pub_name AS "PUBLISHER"
FROM titleauthor a
LEFT JOIN authors b ON a.au_id = b.au_id
LEFT JOIN titles c ON a.title_id = c.title_id
LEFT JOIN publishers d ON c.pub_id = d.pub_id
ORDER BY a.au_id ASC;

/*Challenge 2 - Who Have Published How Many At Where?*/
SELECT a.au_id AS "AUTHOR ID", b.au_lname AS "LAST NAME", b.au_fname AS "FIRST NAME", d.pub_name AS "PUBLISHER", COUNT(c.title) AS "TITLE COUNT"
FROM titleauthor a
LEFT JOIN authors b ON a.au_id = b.au_id
LEFT JOIN titles c ON a.title_id = c.title_id
LEFT JOIN publishers d ON c.pub_id = d.pub_id
GROUP BY a.au_id;

/*Challenge 3 - Best Selling Authors*/
SELECT a.au_id AS "AUTHOR ID", a.au_lname AS "LAST NAME", a.au_fname AS "FIRST NAME", SUM(d.qty) AS "TOTAL"
FROM authors a
LEFT JOIN titleauthor c ON a.au_id = c.au_id
LEFT JOIN sales d ON c.title_id = d.title_id
GROUP BY a.au_id
ORDER BY SUM(d.qty) DESC
LIMIT 3;

/*Challenge 4 - Best Selling Authors Ranking*/
SELECT a.au_id AS "AUTHOR ID", a.au_lname AS "LAST NAME", a.au_fname AS "FIRST NAME", IFNULL(SUM(d.qty),0) AS "TOTAL"
FROM authors a
LEFT JOIN titleauthor c ON a.au_id = c.au_id
LEFT JOIN sales d ON c.title_id = d.title_id
GROUP BY a.au_id
ORDER BY SUM(d.qty) DESC;