SELECT authors.au_id,authors.au_fname,authors.au_lname,titles.title,publishers.pub_name
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id;


SELECT authors.au_id,authors.au_lname,authors.au_fname,publishers.pub_name,COUNT(titles.title)
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id
GROUP BY title;


SELECT authors.au_id,authors.au_lname,authors.au_fname,SUM(sales.qty)
FROM authors
INNER JOIN titleauthor
ON authors.au_id = titleauthor.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN sales
ON titles.title_id = sales.title_id
GROUP BY au_id
ORDER BY SUM(sales.qty) DESC limit 3;



SELECT authors.au_id, authors.au_fname, authors.au_lname, coalesce(SUM(sales.qty), 0) -- Coalesce function will substitute the null values by 0
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY SUM(sales.qty) DESC;



















