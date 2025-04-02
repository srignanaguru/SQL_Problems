use day1;

CREATE TABLE marketing_campaign (
    user_id INT,
    created_at DATETIME,
    product_id INT,
    quantity INT,
    price INT
);

INSERT INTO marketing_campaign (user_id, created_at, product_id, quantity, price) 
VALUES
    (1, '2020-01-01', 101, 25, 200), 
    (2, '2020-01-01', 102, 5, 150), 
    (3, '2020-01-02', 103, 15, 300), 
    (4, '2020-01-03', 101, 10, 200), 
    (5, '2020-01-04', 102, 22, 150), 
    (6, '2020-01-05', 104, 8, 120), 
    (7, '2020-01-06', 105, 18, 250), 
    (8, '2020-01-07', 101, 30, 200), 
    (9, '2020-01-08', 103, 20, 300), 
    (10, '2020-01-09', 104, 9, 120);

select * from marketing_campaign;

with cte as(
select product_id,sum(quantity) as total_units_sold from marketing_campaign group by product_id 
)

select *, 
case when total_units_sold >=30 then "Outstanding"
	 when total_units_sold >=20 and total_units_sold<=29 then "Satisfactory"
     when total_units_sold >=10 and total_units_sold<=19 then "Unsatisfactory"
     when total_units_sold>=1 and total_units_sold<=9 then "Poor"
     end as category_performance
from cte order by total_units_sold desc
