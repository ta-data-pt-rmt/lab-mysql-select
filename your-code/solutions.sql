USE publications;

/* Challenge 1 - Who Have Published What At Where?  */

SELECT aut.au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME', tit.title AS 'TITLE', pub.pub_name AS 'PUBLISHER'
  FROM authors AS aut
  INNER JOIN titleauthor AS taut ON aut.au_id = taut.au_id
  INNER JOIN titles AS tit ON taut.title_id = tit.title_id
  INNER JOIN publishers AS pub ON tit.pub_id = pub.pub_id
ORDER BY aut.au_id;

/* Challenge 2 - Who Have Published How Many At Where? */

SELECT aut.au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME',  pub.pub_name AS 'PUBLISHER', COUNT(tit.title_id) AS 'TITLE COUNT'
  FROM authors AS aut
  INNER JOIN titleauthor AS taut ON aut.au_id = taut.au_id
  INNER JOIN titles AS tit ON taut.title_id = tit.title_id
  INNER JOIN publishers AS pub ON tit.pub_id = pub.pub_id
GROUP BY aut.au_id, au_lname, au_fname,  pub.pub_name
ORDER BY aut.au_id DESC,  pub.pub_name;

/* Challenge 3 - Best Selling Authors */

SELECT aut.au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME', SUM(sal.qty) AS TOTAL
  FROM authors AS aut
  INNER JOIN titleauthor AS taut ON aut.au_id = taut.au_id
  INNER JOIN titles AS tit ON taut.title_id = tit.title_id
  INNER JOIN sales AS sal ON tit.title_id = sal.title_id
GROUP BY aut.au_id, au_lname, au_fname
ORDER BY SUM(sal.qty) DESC
LIMIT 3;

/* Challenge 4 - Best Selling Authors Ranking */

SELECT aut.au_id AS 'AUTHOR ID', au_lname AS 'LAST NAME', au_fname AS 'FIRST NAME', IFNULL(SUM(sal.qty),0) AS TOTAL
  FROM authors AS aut
  LEFT JOIN titleauthor AS taut ON aut.au_id = taut.au_id
  LEFT JOIN titles AS tit ON taut.title_id = tit.title_id
  LEFT JOIN sales AS sal ON tit.title_id = sal.title_id
GROUP BY aut.au_id, au_lname, au_fname
ORDER BY SUM(sal.qty) DESC;
