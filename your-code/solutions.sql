USE publications;

/*CHALLENGE 1*/

SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title, publishers.pub_name
FROM authors
INNER JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN publishers ON titles.pub_id=publishers.pub_id;

/*CHALLENGE 2*/

SELECT authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name, COUNT(titles.title)
FROM authors
INNER JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN publishers ON titles.pub_id=publishers.pub_id
GROUP BY au_id, au_lname, au_fname, pub_name;

/*CHALLENGE 3*/

SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty)
FROM authors
LEFT JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN sales ON titles.title_id=sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY SUM(qty) DESC
LIMIT 3;

/*CHALLENGE 4*/

SELECT authors.au_id, authors.au_lname, authors.au_fname, COALESCE(SUM(sales.qty),0)
FROM authors
LEFT JOIN titleauthor ON authors.au_id=titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id=titles.title_id
LEFT JOIN sales ON titles.title_id=sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY SUM(qty) DESC;