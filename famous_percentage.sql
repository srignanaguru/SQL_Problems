create database day1;

use day1;

-- Need to find out famous percentage of user_id that represents each user_id followed by follower_id
create table  famous(user_id int, follower_id int);
insert into famous values(1,2),(1,3),(2,4),(5,1),(5,3),(11,7),(12,8),(13,5),(13,10),(14,12),(14,3),(15,14),(15,13);

select * from famous;

with distinct_users as (
    select user_id as users from famous 
    union
    select follower_id as users from famous
),
follower_count as (
    select user_id, count(follower_id) as followers 
    from famous 
    group by user_id
)

select 
    f.user_id,
    (f.followers * 100) / (select COUNT(*) from distinct_users) as famous_percentage
from follower_count f;

