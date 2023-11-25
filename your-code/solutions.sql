-- Challenge 1 -------------------------

USE publications;

SELECT 
    authors.au_id AS `Author Id`,
    au_lname AS `Last Name`,
    au_fname AS `First Name`,
    titles.title AS `Title`,
    pub_name AS `Publisher`
FROM
    authors
        INNER JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        INNER JOIN
    titles ON titleauthor.title_id = titles.title_id
        INNER JOIN
    publishers ON titles.pub_id = publishers.pub_id


-- Challenge 2 - Solution 1 ----------------------------
USE publications;

SELECT 
    authors.au_id AS `Author Id`,
    au_lname AS `Last Name`,
    au_fname AS `First Name`,
    pub_name AS `Publisher`,
    COUNT(titles.title_id) AS `Title Count`
FROM
    authors
        INNER JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        INNER JOIN
    titles ON titleauthor.title_id = titles.title_id
        INNER JOIN
    publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id , au_lname , au_fname , pub_name


-- Challenge 2 - Solution 2 using subquery --------
USE publications;

SELECT 
    `Author Id`,
    `Last Name`,
    `First Name`,
    `Publisher`,
    COUNT(`Title`) AS `Title Count`
FROM
    (SELECT 
        authors.au_id AS `Author Id`,
            au_lname AS `Last Name`,
            au_fname AS `First Name`,
            titles.title AS `Title`,
            pub_name AS `Publisher`
    FROM
        authors
    INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN publishers ON titles.pub_id = publishers.pub_id) t
GROUP BY `Author Id` , `Last Name` , `First Name` , `Publisher`

-- Challenge 3 -----------
USE publications;

SELECT 
    authors.au_id AS `Author Id`,
    au_lname AS `Last Name`,
    au_fname AS `First Name`,
    SUM(qty) AS `Total`
FROM
    authors
        INNER JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        INNER JOIN
    sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id , au_lname , au_fname
ORDER BY `Total` DESC
LIMIT 3

-- Challenge 4 -----------------
USE publications;

SELECT 
    authors.au_id AS `Author Id`,
    au_lname AS `Last Name`,
    au_fname AS `First Name`,
    IFNULL(SUM(qty), 0) AS `Total`
FROM
    authors
        LEFT JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
        LEFT JOIN
    sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id , au_lname , au_fname
ORDER BY `Total` DESC
