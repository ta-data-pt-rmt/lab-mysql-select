USE Mysql_Nhan;
CREATE TABLE AuthorTitlePublisher AS
SELECT
    a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    t.title AS 'TITLE',
    p.pub_name AS 'PUBLISHER'
FROM
    authors a
JOIN
    titleauthor ON a.au_id = titleauthor.au_id
JOIN
    titles t ON titleauthor.title_id = t.title_id
JOIN
    publishers p ON t.pub_id = p.pub_id;
SELECT * FROM AuthorTitlePublisher;
SELECT
    COUNT(*) AS NumRowsInAuthorTitlePublisher
FROM
    AuthorTitlePublisher;

-- Check the number of rows in the titleauthor table
SELECT
    COUNT(*) AS NumRowsInTitleAuthor
FROM
    titleauthor;
/*CHallenge 2*/
SELECT
    `AUTHOR ID`,
    `LAST NAME`,
    `FIRST NAME`,
    `PUBLISHER`,
    COUNT(`TITLE`) AS `NUMBER OF TITLES`
FROM
    AuthorTitlePublisher
GROUP BY
    `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`;
-- Challenges 3
SELECT
    `AUTHOR ID`,
    `LAST NAME`,
    `FIRST NAME`,
    SUM(`NUMBER OF TITLES`) AS `TOTAL TITLES SOLD`
FROM
    (
        SELECT
            `AUTHOR ID`,
            `LAST NAME`,
            `FIRST NAME`,
            `PUBLISHER`,
            COUNT(`TITLE`) AS `NUMBER OF TITLES`
        FROM
            AuthorTitlePublisher
        GROUP BY
            `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`
    ) AS AuthorTitleCount
GROUP BY
    `AUTHOR ID`, `LAST NAME`, `FIRST NAME`
ORDER BY
    `TOTAL TITLES SOLD` DESC
LIMIT 3;
-- Challenges 4:

SELECT
    `AUTHOR ID`,
    `LAST NAME`,
    `FIRST NAME`,
    SUM(`NUMBER OF TITLES`) AS `TOTAL TITLES SOLD`
FROM
    (
        SELECT
            `AUTHOR ID`,
            `LAST NAME`,
            `FIRST NAME`,
            `PUBLISHER`,
            COUNT(`TITLE`) AS `NUMBER OF TITLES`
        FROM
            AuthorTitlePublisher
        GROUP BY
            `AUTHOR ID`, `LAST NAME`, `FIRST NAME`, `PUBLISHER`
    ) AS AuthorTitleCount
GROUP BY
    `AUTHOR ID`, `LAST NAME`, `FIRST NAME`
ORDER BY
    `TOTAL TITLES SOLD` DESC
;