SELECT *
FROM courses.authors;

SELECT *
FROM courses.titles;

SELECT *
FROM courses.publishers;

SELECT *
FROM courses.titleauthor ;

/*Challenge 1 - Who Have Published What At Where?*/
SELECT
  authors.au_id AS 'AUTHOR ID',
  authors.au_fname AS 'LAST NAME',
  authors.au_lname AS 'FIRST NAME',
  titles.title AS 'TITLE',
  publishers.pub_name AS 'PUBLISHER'
FROM
  courses.authors
INNER JOIN
  courses.titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN
  courses.titles ON titleauthor.title_id = titles.title_id
INNER JOIN
  courses.publishers ON titles.pub_id = publishers.pub_id;

/*Challenge 2 - Who Have Published How Many At Where?*/
SELECT
  authors.au_id AS 'AUTHOR ID',
  authors.au_fname AS 'LAST NAME',
  authors.au_lname AS 'FIRST NAME',
  publishers.pub_name AS 'PUBLISHER',
  COUNT(*) AS 'TITLE COUNT'
FROM
  courses.authors
INNER JOIN
  courses.titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN
  courses.titles ON titleauthor.title_id = titles.title_id
INNER JOIN
  courses.publishers ON titles.pub_id = publishers.pub_id
GROUP BY
  authors.au_id,
  authors.au_fname,
  authors.au_lname,
  publishers.pub_name;

/*Challenge 3 - Best Selling Authors*/
SELECT
  authors.au_id AS 'AUTHOR ID',
  authors.au_fname AS 'LAST NAME',
  authors.au_lname AS 'FIRST NAME',
  publishers.pub_name AS 'PUBLISHER',
  COUNT(*) AS 'TOTAL'
FROM
  courses.authors
INNER JOIN
  courses.titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN
  courses.titles ON titleauthor.title_id = titles.title_id
INNER JOIN
  courses.publishers ON titles.pub_id = publishers.pub_id
GROUP BY
  authors.au_id,
  authors.au_fname,
  authors.au_lname,
  publishers.pub_name
ORDER BY
  TOTAL DESC
LIMIT 3;

/*Challenge 4 - Best Selling Authors Ranking*/
SELECT
  authors.au_id AS 'AUTHOR ID',
  authors.au_fname AS 'LAST NAME',
  authors.au_lname AS 'FIRST NAME',
  publishers.pub_name AS 'PUBLISHER',
  COUNT(*) AS 'TOTAL'
FROM
  courses.authors
INNER JOIN
  courses.titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN
  courses.titles ON titleauthor.title_id = titles.title_id
INNER JOIN
  courses.publishers ON titles.pub_id = publishers.pub_id
GROUP BY
  authors.au_id,
  authors.au_fname,
  authors.au_lname,
  publishers.pub_name
ORDER BY
  TOTAL DESC;