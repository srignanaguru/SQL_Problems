use day1;

-- To find out the top two busiest time of the week by using the criteria before 12pm is morning, between 12pm and 15pm is early afternoon, after 15pm is late afternoon

CREATE TABLE sales_log (
    order_id BIGINT PRIMARY KEY,
    product_id BIGINT,
    timestamp DATETIME
);

INSERT INTO sales_log (order_id, product_id, timestamp) VALUES
    (1, 101, '2024-12-15 09:30:00'),
    (2, 102, '2024-12-15 11:45:00'),
    (3, 103, '2024-12-15 12:10:00'),
    (4, 104, '2024-12-15 13:15:00'),
    (5, 105, '2024-12-15 14:20:00'),
    (6, 106, '2024-12-15 15:30:00'),
    (7, 107, '2024-12-15 16:40:00'),
    (8, 108, '2024-12-16 09:50:00'),
    (9, 109, '2024-12-16 10:30:00'),
    (10, 110, '2024-12-16 12:05:00'),
    (11, 111, '2024-12-16 13:50:00'),
    (12, 112, '2024-12-16 14:15:00'),
    (13, 113, '2024-12-16 15:30:00'),
    (14, 114, '2024-12-17 09:45:00'),
    (15, 115, '2024-12-17 11:20:00'),
    (16, 116, '2024-12-17 12:25:00'),
    (17, 117, '2024-12-17 13:30:00'),
    (18, 118, '2024-12-17 14:55:00'),
    (19, 119, '2024-12-17 15:10:00'),
    (20, 120, '2024-12-18 10:40:00');

select * from sales_log;

with cte as(
select dayname(timestamp) as day,
case when  time(timestamp)<'12:00:00' then 'Morning'
	when  time(timestamp) >='12:00:00' and  time(timestamp) <='15:00:00' then 'Early afternoon'
    when  time(timestamp)>'15:00:00' then 'Late afternoon' end as criteria_time,
count(order_id) as num_of_order
from sales_log group by 1,2
),
ranked as(
select *, dense_rank() over (order by num_of_order desc) as rnk from cte
)

select day,criteria_time,num_of_order from ranked where rnk<=2;