USE Publications;

/* CHALLENGE 1*/ 

SELECT * FROM authors; 
SELECT * FROM Publications.titleauthor; 
SELECT * FROM Publications.titles; 
SELECT * FROM Publications.publishers;


/* ADDING ONLY THE TITLE ID*/
SELECT 
    authors.au_id,
    authors.au_lname,
    authors.au_fname,
    titleauthor.au_id,
    titleauthor.title_id
FROM
    authors
LEFT JOIN
	titleauthor 
ON 
	authors.au_id = titleauthor.au_id;

/*ADDIND THE OTHER TABLES*/ 

SELECT 
    authors.au_id AS Author_ID,
    authors.au_lname AS Last_name,
    authors.au_fname AS First_Name,
    titles.title AS Title,
    publishers.pub_name AS Publisher
FROM
    authors
LEFT JOIN
	titleauthor 
ON 
	authors.au_id = titleauthor.au_id
LEFT JOIN
	titles
ON
    titleauthor.title_id = titles.title_id
LEFT JOIN 
	publishers
ON 
	titles.pub_id = publishers.pub_id;

/* CHALLENGE 2 */ 

SELECT 
    authors.au_id AS Author_ID,
    authors.au_lname AS Last_name,
    authors.au_fname AS First_Name,
    publishers.pub_name AS Publisher,
    COUNT(titles.title_id) AS Title_count
FROM
    authors
LEFT JOIN
	titleauthor 
ON 
	authors.au_id = titleauthor.au_id
LEFT JOIN
	titles
ON
    titleauthor.title_id = titles.title_id
LEFT JOIN 
	publishers
ON 
	titles.pub_id = publishers.pub_id
GROUP BY 
authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;     

/* CHALLENGE 3 */ 

SELECT
    authors.au_id AS Author_ID,
    authors.au_lname AS Last_name,
    authors.au_fname AS First_name,
    COALESCE(SUM(sales.qty), 0) AS total_sales
FROM 
    authors
LEFT JOIN 
    titleauthor ON titleauthor.au_id = authors.au_id
LEFT JOIN 
    titles ON titles.title_id = titleauthor.title_id
LEFT JOIN
    sales ON sales.title_id = titles.title_id
GROUP BY
    authors.au_id, authors.au_lname, authors.au_fname
ORDER BY
    total_sales DESC
LIMIT 3;

/* CHALLENGE 4 */ 

SELECT
    authors.au_id AS Author_ID,
    authors.au_lname AS Last_name,
    authors.au_fname AS First_name,
    COALESCE(SUM(sales.qty), 0) AS total_sales
FROM 
    authors
LEFT JOIN 
    titleauthor ON titleauthor.au_id = authors.au_id
LEFT JOIN 
    titles ON titles.title_id = titleauthor.title_id
LEFT JOIN
    sales ON sales.title_id = titles.title_id
GROUP BY
    authors.au_id, authors.au_lname, authors.au_fname
ORDER BY
    total_sales DESC;