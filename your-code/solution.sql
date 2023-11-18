USE lab_mysql_select;

SELECT * FROM authors;
SELECT * FROM discounts;
SELECT * FROM employee;
SELECT * FROM jobs;
SELECT * FROM pub_info;
SELECT * FROM publishers;
SELECT * FROM roysched;
SELECT * FROM sales;
SELECT * FROM stores;
SELECT * FROM titleauthor;
SELECT * FROM titles;

-- CHALENGE 1
-- Instead of ON... We can use USING to make a smaller code.  
SELECT A.au_id AS 'Author ID', au_lname AS 'Last name', au_fname AS 'First Name', titles.title AS 'Title', publishers.pub_name AS 'Publisher'
FROM authors as A
INNER JOIN titleauthor ON A.au_id = titleauthor.au_id
INNER JOIN titles USING (title_id)
INNER JOIN publishers USING (pub_id)
ORDER BY A.au_id ASC;

-- CHALENGE 2
SELECT authors.au_id AS 'Author ID', au_lname AS 'Last name', au_fname AS 'First Name', publishers.pub_name AS 'Publisher', COUNT(titles.title) AS 'Title Count'
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles USING (title_id)
LEFT JOIN publishers USING (pub_id)
GROUP BY authors.au_id, au_lname, au_fname, publishers.pub_name
ORDER BY authors.au_id DESC, Publisher DESC ;


##CHALLENGE 3
SELECT A.au_id AS 'Author ID', au_lname AS 'Last name', au_fname AS 'First Name', SUM(sales.qty) AS 'Total'
FROM authors AS A
LEFT JOIN titleauthor USING (au_id)
LEFT JOIN titles USING (title_id)
LEFT JOIN sales USING (title_id)
GROUP BY A.au_id, A.au_lname, A.au_fname
ORDER BY Total DESC
LIMIT 3;

-- CHALLENGE 4 
SELECT A.au_id AS 'Author ID', au_lname AS 'Last name', au_fname AS 'First Name', SUM(sales.qty) AS 'Total'
FROM authors AS A
LEFT JOIN titleauthor USING (au_id)
LEFT JOIN titles USING (title_id)
LEFT JOIN sales USING (title_id)
GROUP BY A.au_id, A.au_lname, A.au_fname
ORDER BY Total DESC
