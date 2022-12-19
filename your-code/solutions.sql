SELECT au.au_id AS 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME', pub.pub_name as 'PUBLISHER'
	FROM authors as au
    JOIN titleauthor as title_au 
    ON au.au_id = title_au.au_id
    JOIN titles as titles
    ON title_au.title_id = titles.title_id
    JOIN publishers as pub
    ON titles.pub_id = pub.pub_id
    


SELECT au.au_id AS 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME', pub.pub_name as 'PUBLISHER', COUNT(titles.title_id) as 'TITLE COUNT'
	FROM authors as au
    JOIN titleauthor as title_au 
    ON au.au_id = title_au.au_id
    JOIN titles as titles
    ON title_au.title_id = titles.title_id
    JOIN publishers as pub
    ON titles.pub_id = pub.pub_id
    GROUP BY au.au_id
    
    
SELECT au.au_id AS 'AUTHOR ID', au.au_lname as 'LAST NAME', au.au_fname as 'FIRST NAME', COUNT(sl.qty) as 'TOTAL'
	FROM authors as au
    LEFT JOIN titleauthor as title_au 
    ON au.au_id = title_au.au_id
    JOIN titles as titles
    ON title_au.title_id = titles.title_id
    JOIN publishers as pub
    ON titles.pub_id = pub.pub_id
    JOIN sales as sl
    on sl.title_id = titles.title_id
    GROUP BY au.au_id
    ORDER BY sl.qty
    LIMIT 3
       
SELECT au.au_id as 'AUTHOR ID', au.au_fname as 'FIRST NAME', au.au_lname as 'LAST NAME', count(sl.qty) as 'TOTAL' FROM authors au
	LEFT JOIN titleauthor as title_au 
    ON au.au_id = title_au.au_id
    LEFT JOIN titles as titles
    ON title_au.title_id = titles.title_id
    LEFT JOIN sales as sl
    on sl.title_id = titles.title_id
    GROUP BY au.au_id
    ORDER BY total DESC
    

     
