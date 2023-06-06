USE publications;

# Challenge 1 - Who have published what at where?

CREATE TABLE table_challenge1 AS
SELECT joined_table2.au_id AS 'AUTHOR ID', joined_table2.au_lname AS 'LAST NAME', joined_table2.au_fname AS 'FIRST NAME', joined_table2.title AS 'TITLE', publishers.pub_name AS 'PUBLISHER'
FROM
  (SELECT joined_table1.au_id, joined_table1.au_lname, joined_table1.au_fname, titles.title, titles.pub_id
    FROM
      (SELECT authors.au_id, authors.au_lname, authors.au_fname, titleauthor.title_id
        FROM authors
        LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
      ) AS joined_table1
    LEFT JOIN titles ON joined_table1.title_id = titles.title_id
  ) AS joined_table2
LEFT JOIN publishers ON joined_table2.pub_id = publishers.pub_id;

SELECT * FROM table_challenge1;

# Challenge 2 - Who Have Published How Many At Where?

SELECT COUNT(*) AS total_records FROM titleauthor;

SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`, COUNT(`TITLE`) AS `TITLE COUNT`
FROM table_challenge1
GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`;


SELECT SUM(`TITLE COUNT`) AS TOTAL
FROM (
	SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`, COUNT(`TITLE`) AS `TITLE COUNT`
	FROM table_challenge1
	GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`
    ) AS table_challenge2;
    
# Challenge 3 - Best Selling Authors

SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, COUNT(`TITLE`) AS `TOTAL`
FROM table_challenge1
GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`
ORDER BY `TOTAL` DESC
LIMIT 3;


# Challenge 4 - Best Selling Authors Ranking

SELECT `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, COUNT(`TITLE`) AS `TOTAL`
FROM table_challenge1
GROUP BY `AUTHOR ID`, `LAST NAME`, `FIRST NAME`
ORDER BY `TOTAL` DESC;
