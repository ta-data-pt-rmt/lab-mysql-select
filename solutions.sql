-- Challenge 1 - Who Have Published What At Where?

/* In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author has published at which publishers. Your output should have at least the following columns:

AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published */ 

with authors_publishers_titles as ( select au.au_id as "author_id", au.au_lname as "author_last_name", au.au_fname as "author_first_name", ti.title as "title", pub.pub_name as "publisher_name"
	   from authors as au
	   inner join titleauthor as tau
		 on au.au_id = tau.au_id
	   inner join titles ti
		 on tau.title_id = ti.title_id
	   inner join publishers pub
		 on ti.pub_id = pub.pub_id)

select author_id, author_last_name, author_first_name, title, publisher_name
from authors_publishers_titles;

-- Challenge 2 - Who Have Published How Many At Where?

with authors_publishers_titles_count as ( select au.au_id as "author_id", au.au_lname as "author_last_name", au.au_fname as "author_first_name", COUNT(ti.title) as "title_count", pub.pub_name as "publisher_name"
	   from authors as au
	   inner join titleauthor as tau
		 on au.au_id = tau.au_id
	   inner join titles ti
		 on tau.title_id = ti.title_id
	   inner join publishers pub
		 on ti.pub_id = pub.pub_id
         group by author_id, author_last_name, author_first_name, publisher_name
         order by title_count DESC)

select author_id, author_last_name, author_first_name,publisher_name, title_count
from authors_publishers_titles_count;

-- Challenge 3 - Best Selling Authors

/* Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

Requirements:

Your output should have the following columns:
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TOTAL - total number of titles sold from this author
Your output should be ordered based on TOTAL from high to low.
Only output the top 3 best selling authors. */ 

with top_sellers_authors as ( select au.au_id as "author_id", au.au_lname as "author_last_name", au.au_fname as "author_first_name", SUM(sal.qty) as "total_sales"
	   from authors as au
	   inner join titleauthor as tau
		 on au.au_id = tau.au_id
	   inner join titles ti
		 on tau.title_id = ti.title_id
	   inner join sales sal
		 on ti.title_id = sal.title_id
	   group by author_id, author_last_name, author_first_name
       order by total_sales DESC)
		
select author_id, author_last_name, author_first_name, total_sales
from top_sellers_authors
limit 3;  

-- Challenge 4 - Best Selling Authors Ranking

-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). Also order your results based on TOTAL from high to low.

with top_sellers_authors_no_limit as ( select au.au_id as "author_id", au.au_lname as "author_last_name", au.au_fname as "author_first_name", 
		case 
			when SUM(sal.qty) IS NULL then 0 
            else SUM(sal.qty)
		end as "total_sales"
	   from authors as au
	   left join titleauthor as tau
		 on au.au_id = tau.au_id
	   left join sales sal
		 on tau.title_id = sal.title_id
	   group by author_id, author_last_name, author_first_name
       order by total_sales DESC)
		
select author_id, author_last_name, author_first_name, total_sales
from top_sellers_authors_no_limit;


