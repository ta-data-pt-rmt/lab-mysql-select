/* alarm this lab is not good, I really struggled 
challenge 1*/
select titles.title, titles.title_id, titles.pub_id, publishers.pub_name, publishers.pub_id,
titleauthor.au_id, titleauthor.title_id, authors.au_id, authors.au_lname, authors.au_fname
from titles
inner join publishers on titles.pub_id = publishers.pub_id
inner join titleauthor on titles.title_id = titleauthor.title_id
inner join authors on titleauthor.au_id = authors.au_id;

/* challenge 2*/
select authors.au_id, authors.au_lname, authors.au_fname, titleauthor.au_id, titleauthor.title_id,
titles.title_id, titles.pub_id, publishers.pub_name, publishers.pub_id, count(au_id) 
titlecount
from titles
inner join titleauthor on titles.title_id = titleauthor.title_id
inner join publishers on titles.pub_id = publishers.pub_id
inner join authors on titleauthor.au_id = authors.au_id
group by publishers.pub_name;
/* I don´t understand why, regarding the inner join on, still both columns exist
+ I don´t get to the count solution :´( maybe create a temporary table out of this
and add the count version*/

/* challenge 3 */
select authors.au_id, authors.au_fname, authors.au_lname, sales.qty, sum(sales.qty)
from authors
inner join titleauthor on authors.au_id = titleauthor.au_id
inner join sales on titleauthor.title_id = sales.title_id 
order by sum(sales.qty) desc
group by authors.au_id
limit 3;

/* challenge 4 
is it not the same as the one above just without the limit?*/








