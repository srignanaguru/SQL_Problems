use day1;

-- To find no. of transaction occured for each product that order by product_id ascending order

CREATE TABLE excel_sql_inventory_data (product_id INT,product_name VARCHAR(50),product_type VARCHAR(50), unit VARCHAR(20),price_unit FLOAT, wholesale FLOAT, current_inventory INT);

INSERT INTO excel_sql_inventory_data (product_id, product_name, product_type, unit, price_unit, wholesale, current_inventory)
 VALUES(1, 'strawberry', 'produce', 'lb', 3.28, 1.77, 13),
 (2, 'apple_fuji', 'produce', 'lb', 1.44, 0.43, 2), 
 (3, 'orange', 'produce', 'lb', 1.02, 0.37, 2), 
 (4, 'clementines', 'produce', 'lb', 1.19, 0.44, 44), 
 (5, 'blood_orange', 'produce', 'lb', 3.86, 1.66, 19);

CREATE TABLE excel_sql_transaction_data (transaction_id INT PRIMARY KEY,time DATETIME,product_id INT);

INSERT INTO excel_sql_transaction_data (transaction_id, time, product_id) 
VALUES(153, '2016-01-06 08:57:52', 1), 
(91, '2016-01-07 12:17:27', 1), 
(31, '2016-01-05 13:19:25', 1), 
(24, '2016-01-03 10:47:44', 3), 
(4, '2016-01-06 17:57:42',3), 
(163, '2016-01-03 10:11:22',3), 
(92, '2016-01-08 12:03:20',2),
(32, '2016-01-04 19:37:14',4),
(253, '2016-01-06 14:15:20',5), 
(118, '2016-01-06 14:27:33',5);

select * from excel_sql_inventory_data;

select * from excel_sql_transaction_data;

select e1.product_name, count(e2.transaction_id) as transaction_count from excel_sql_inventory_data e1 
join excel_sql_transaction_data e2 on e1.product_id=e2.product_id
group by e1.product_id,e1.product_name order by e1.product_id asc
;
