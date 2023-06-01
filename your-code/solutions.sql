USE publications;

#Challenge 1 - Who Have Published What At Where?
SELECT publications.authors.au_id, publications.authors.au_lname, publications.authors.au_fname,
titles.title, publishers.pub_name FROM publications.authors
join publications.titleauthor on authors.au_id = titleauthor.au_id
join publications.titles on titleauthor.title_id = titles.title_id
join publications.publishers on titles.pub_id = publishers.pub_id
order by authors.au_id asc;

#Challenge 2 - Who Have Published How Many At Where?
SELECT authors.au_id, authors.au_lname, authors.au_fname,
       publishers.pub_name, COUNT(titles.title)
FROM publications.authors
JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
JOIN publications.titles ON titleauthor.title_id = titles.title_id
JOIN publications.publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;

#Challenge 3 - Best Selling Authors
SELECT authors.au_id, authors.au_lname, authors.au_fname, sum(sales.qty) as TOTAL
FROM publications.authors
JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
JOIN publications.titles ON titleauthor.title_id = titles.title_id
JOIN publications.sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
order by TOTAL desc
LIMIT 3;

#Challenge 4 - Best Selling Authors Ranking
SELECT authors.au_id, authors.au_lname, authors.au_fname, sum(sales.qty) as TOTAL
FROM publications.authors
JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
JOIN publications.titles ON titleauthor.title_id = titles.title_id
JOIN publications.sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
order by TOTAL desc;
