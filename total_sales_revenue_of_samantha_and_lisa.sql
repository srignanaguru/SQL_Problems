use day1;

-- To find out the total sales revenue of samantha dn lisa


CREATE TABLE sales_performance (salesperson VARCHAR(50), widget_sales INT,sales_revenue INT,id INT PRIMARY KEY);

INSERT INTO sales_performance (salesperson, widget_sales, sales_revenue, id) 
VALUES('Jim', 810, 40500, 1), ('Bobby', 661, 33050, 2), ('Samantha', 1006, 50300, 3), ('Taylor', 984, 49200, 4), ('Tom', 403, 20150, 5), 
('Pat', 715, 35750, 6),
('Lisa', 1247,62350,7);

select * from sales_performance;

select sum(s1.sales_revenue) as total_sales_revenue_samantha_and_lisa from sales_performance s1 join sales_performance s2 on s1.id=s2.id
where s1.salesperson='Samantha' or s2.salesperson='Lisa';
