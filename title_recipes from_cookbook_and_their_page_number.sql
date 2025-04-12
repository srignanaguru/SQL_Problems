use day1;

-- to find out the table that consist of leftpgno, lefttitle and righttitle from  the cookbook

CREATE TABLE cookbook_titles (
    page_number INT PRIMARY KEY,
    title VARCHAR(255)
);

INSERT INTO cookbook_titles (page_number, title) 
VALUES 
    (1, 'Scrambled eggs'),
    (2, 'Fondue'),
    (3, 'Sandwich'),
    (4, 'Tomato soup'),
    (6, 'Liver'),
    (11, 'Fried duck'),
    (12, 'Boiled duck'),
    (15, 'Baked chicken');


select * from cookbook_titles;


with leftpages as(
select title as left_title, page_number as left_pages from cookbook_titles  where page_number%2=0
),
rightpages as(
select title as right_title, page_number as right_pages  from cookbook_titles  where page_number%2=1
)

select l.left_pages,l.left_title,r.right_title from leftpages l left join rightpages r on l.left_pages+1=r.right_pages order by l.left_pages;