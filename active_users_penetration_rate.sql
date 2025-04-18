use day1;

-- To find out the active users [penetration rate by total no active users/total users in the country by some condition atleast 5 sessions and 10 listening hours and within 30 days range like >=2024-01-01


CREATE TABLE penetration_analysis (
    country VARCHAR(20),
    last_active_date DATETIME,
    listening_hours BIGINT,
    sessions BIGINT,
    user_id BIGINT
);

INSERT INTO penetration_analysis (
    country, last_active_date, listening_hours, sessions, user_id
) VALUES 
    ('USA', '2024-01-25', 15, 7, 101),
    ('USA', '2023-12-20', 5, 3, 102),
    ('USA', '2024-01-20', 25, 10, 103),
    ('India', '2024-01-28', 12, 6, 201),
    ('India', '2023-12-15', 8, 4, 202),
    ('India', '2024-01-15', 20, 7, 203),
    ('UK', '2024-01-29', 18, 9, 301),
    ('UK', '2023-12-30', 9, 4, 302),
    ('UK', '2024-01-22', 30, 12, 303),
    ('Canada', '2024-01-01', 11, 6, 401),
    ('Canada', '2023-11-15', 3, 2, 402),
    ('Canada', '2024-01-15', 22, 8, 403),
    ('Germany', '2024-01-10', 14, 7, 501),
    ('Germany', '2024-01-30', 10, 5, 502),
    ('Germany', '2024-01-01', 5, 3, 503);

select * from penetration_analysis;

with cte1 as(
select country, count(*) as active_users from penetration_analysis
where date(last_active_date)>='2024-01-01' and sessions>=5 and listening_hours>=10 group by country
),
cte2 as(
select country, count(*) as total_users from penetration_analysis group by country
)

select c1.country, round((c1.active_users/c2.total_users)*100, 2) as active_user_penetration_rate
from cte1 c1 join cte2 c2 on c1.country = c2.country;