
USE publications;
select * from  publishers;
select * from authors;
select count(*) from titles;
select * from titles;
select * from titleauthor;
/*Challenge 1 - Who Have Published What At Where?*/
SELECT new_table.au_id, new_table.Last_Name, new_table.First_Name, titles.title,publishers.pub_name
FROM 
(select authors.au_id ,authors.au_lname as Last_Name,authors.au_fname as First_Name,titleauthor.title_id
from publications.authors
INNER JOIN publications.titleauthor
ON publications.authors.au_id = publications.titleauthor.au_id) As new_table
INNER JOIN publications.titles
ON new_table.title_id = publications.titles.title_id
INNER JOIN publications.publishers
ON titles.pub_id = publishers.pub_id;

/*Challenge 2 - Who Have Published How Many At Where?*/
SELECT new_table.au_id, new_table.Last_Name, new_table.First_Name, titles.title,publishers.pub_name,count(titles.title) as Title_Count
FROM 
(select authors.au_id ,authors.au_lname as Last_Name,authors.au_fname as First_Name,titleauthor.title_id
from publications.authors
INNER JOIN publications.titleauthor
ON publications.authors.au_id = publications.titleauthor.au_id
) As new_table
INNER JOIN publications.titles
ON new_table.title_id = publications.titles.title_id
INNER JOIN publications.publishers
ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id;

/*Challenge 3 - Best Selling Authors*/
SELECT new_table.au_id, new_table.Last_Name, new_table.First_Name, count(titles.title) as Total
FROM 
(select authors.au_id ,authors.au_lname as Last_Name,authors.au_fname as First_Name,titleauthor.title_id
from publications.authors
INNER JOIN publications.titleauthor
ON publications.authors.au_id = publications.titleauthor.au_id) As new_table
INNER JOIN publications.titles
ON new_table.title_id = publications.titles.title_id
INNER JOIN publications.sales
ON titles.title_id = sales.title_id
GROUP BY authors.au_id
order by Total DESC
LIMIT 3;

/*Challenge 4 - Best Selling Authors Ranking*/
SELECT new_table.au_id, new_table.Last_Name, new_table.First_Name, count(titles.title) as Total
FROM 
(select authors.au_id ,authors.au_lname as Last_Name,authors.au_fname as First_Name,titleauthor.title_id
from publications.authors
INNER JOIN publications.titleauthor
ON publications.authors.au_id = publications.titleauthor.au_id) As new_table
INNER JOIN publications.titles
ON new_table.title_id = publications.titles.title_id
INNER JOIN publications.sales
ON titles.title_id = sales.title_id
GROUP BY authors.au_id
order by Total DESC
LIMIT 23;