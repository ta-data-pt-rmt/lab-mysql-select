-- CHALLENGE 1 --
SELECT 
row_number() OVER (PARTITION BY ta.au_id||a.au_lname ORDER BY ta.au_id) AS id
,ta.au_id as author_id
, a.au_lname as last_name
, a.au_fname as first_name
, t.title as title
, p.pub_name as publisher_name

FROM titleauthor as ta

INNER JOIN authors a
ON ta.au_id=a.au_id

INNER JOIN titles t
ON ta.title_id = t.title_id

INNER JOIN publishers as p
ON t.pub_id = p.pub_id;

-- CHALLENGE 2 -- 
SELECT ta.au_id as author_id
, a.au_lname as last_name
, a.au_fname as first_name
, p.pub_name as publisher_name
,COUNT(t.title) as title_count

FROM titleauthor as ta

INNER JOIN authors a
ON ta.au_id=a.au_id

INNER JOIN titles t
ON ta.title_id = t.title_id

INNER JOIN publishers as p
ON t.pub_id = p.pub_id

GROUP BY 1,2,3,4

ORDER BY 5 DESC;

-- CHALLENGE 3 --
SELECT ta.au_id as author_id
, a.au_lname as last_name
, a.au_fname as first_name
, SUM(s.qty) as total

FROM titleauthor as ta

LEFT JOIN authors a
ON ta.au_id=a.au_id

LEFT JOIN sales s
ON s.title_id = ta.title_id

GROUP BY 1,2,3

ORDER BY 4 DESC

LIMIT 3;

-- CHALLENGE 4 -- 
DROP TABLE sales_title;
CREATE TABLE sales_title AS (
SELECT t.title_id
, SUM(s.qty) AS qty
FROM titles AS t
LEFT JOIN sales AS s
ON t.title_id = s.title_id
GROUP BY 1);

SELECT 
 a.au_id as author_id
, a.au_lname as last_name
, a.au_fname as first_name
, COALESCE(SUM(ts.qty),0) as total

FROM authors a
LEFT JOIN titleauthor ta
ON a.au_id = ta.au_id

LEFT JOIN sales_title ts
ON ta.title_id = ts.title_id

GROUP BY 1,2,3
ORDER BY 4 DESC