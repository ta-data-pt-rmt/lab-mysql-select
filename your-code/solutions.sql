-- FIRST STEP : SEE THE TABLES AND THE NAMES OF THE FIELDS:
SELECT * FROM authors;
-- au_id, au_lname, au_fname, phone, address, city, state, zip, contract
SELECT * FROM discounts;
-- discounttype, stor_id, lowqty, highqty, discount
SELECT * FROM employee;
-- emp_id, fname, minit, lname,  job_id, job_lvl, pub_id, hire_date
SELECT * from jobs;
-- job_id, job_desc, min_lvl, max_lvl
SELECT * FROM pub_info;
-- pub_id, logo, pr_info 
SELECT * FROM publishers;
-- pub_id, pub_name, city, state, country
SELECT * FROM roysched;
-- title_id, lorange, hirange, royalty 
SELECT * FROM sales;
-- stor_id, ord_num, ord_date, qty, payterms, title_id
SELECT * FROM stores;
-- stor_id, stor_name, stor_address, city, state, zip
SELECT * FROM titleauthor;
-- au_id, title_id, au_ord, royaltyper
SELECT * FROM titles;
-- title_id, title, type, pub_id, price, advance, royalty, ytd_sales, notes, pubdate

##CHALENGE 1. 
-- Select the table in which each required field appear
-- AUTHOR ID: au_id -> authors, titleauthor OK
-- AUTHOR LAST NAME:  au_lname -> authors OK
-- AUTHOR FIRST NAME: au_fname -> authors OK
-- TITLE of the published title: title -> titles OK 
-- PUBLISHER NAME: pub_name -> publishers
-- *TITLEAUTHOR DIMENSION
SELECT au_id,au_lname,au_fname from authors;
SELECT A.au_id, B.au_lname, B.au_fname from titleauthor A left join authors B on A.au_id = B.au_id;
SELECT A.au_id, A.au_lname, A.au_fname, C.title, D.pub_name from titleauthor B
left join authors A ON A.au_id = B.au_id
left join titles C ON B.title_id = C.title_id
left join publishers D ON C.pub_id = D.pub_id
;

##CHALLENGE 2: INCLUDE TITLE(COUNT) PER AUTH:
SELECT A.au_id, A.au_lname, A.au_fname, D.pub_name,count(C.title_id) AS 'total_titles' from titleauthor B
left join authors A ON A.au_id = B.au_id
left join titles C ON B.title_id = C.title_id
left join publishers D ON C.pub_id = D.pub_id
group by A.au_id, A.au_lname, A.au_fname, D.pub_name
;


##CHALLENGE 3: INCLUDE SOLD_TITLES(sum) PER AUTH - only first 3:
SELECT A.au_id, A.au_lname, A.au_fname, sum(D.qty) AS 'sold_titles' from titleauthor B
left join authors A ON A.au_id = B.au_id
left join titles C ON B.title_id = C.title_id
left join sales D ON C.title_id = D.title_id
group by A.au_id, A.au_lname, A.au_fname
ORDER BY SUM(D.qty) DESC
LIMIT 3;
;

##CHALLENGE 4: INCLUDE SOLD_TITLES(sum) PER AUTH:
SELECT A.au_id, A.au_lname, A.au_fname, sum(D.qty) AS 'sold_titles' from titleauthor B
left join authors A ON A.au_id = B.au_id
INNER join titles C ON B.title_id = C.title_id
INNER join sales D ON C.title_id = D.title_id
group by A.au_id, A.au_lname, A.au_fname
ORDER BY SUM(D.qty) DESC
;

