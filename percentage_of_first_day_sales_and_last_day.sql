use day1;

-- To find out the percentage of weekly sales on first day of weke as monday and last day of week as sunday

CREATE TABLE early_sales (
    invoicedate DATETIME,
    invoiceno BIGINT,
    quantity BIGINT,
    stockcode NVARCHAR(50),
    unitprice FLOAT
);

INSERT INTO early_sales (invoicedate, invoiceno, quantity, stockcode, unitprice) 
VALUES 
    ('2023-01-01 10:00:00', 1001, 5, 'A001', 20.0),
    ('2023-01-01 15:30:00', 1002, 3, 'A002', 30.0),
    ('2023-01-02 09:00:00', 1003, 10, 'A003', 15.0),
    ('2023-01-02 11:00:00', 1004, 2, 'A004', 50.0),
    ('2023-01-08 10:30:00', 1005, 4, 'A005', 25.0),
    ('2023-01-08 14:45:00', 1006, 7, 'A006', 18.0),
    ('2023-01-15 08:00:00', 1007, 6, 'A007', 22.0),
    ('2023-01-15 16:00:00', 1008, 8, 'A008', 12.0),
    ('2023-01-22 09:30:00', 1009, 3, 'A009', 40.0),
    ('2023-01-22 18:00:00', 1010, 5, 'A010', 35.0),
    ('2023-02-01 10:00:00', 1011, 9, 'A011', 20.0),
    ('2023-02-01 12:00:00', 1012, 2, 'A012', 60.0),
    ('2023-02-05 09:30:00', 1013, 4, 'A013', 25.0),
    ('2023-02-05 13:00:00', 1014, 6, 'A014', 18.0),
    ('2023-02-12 10:00:00', 1015, 7, 'A015', 22.0),
    ('2023-02-12 14:00:00', 1016, 5, 'A016', 28.0);

select * from early_sales;

with cte as(
select week(invoicedate) as week_no, sum(quantity*unitprice) as total_price,
sum(case when dayofweek(invoicedate)=2 then quantity*unitprice else 0 end) as monday_sales,
sum(case when dayofweek(invoicedate)=1 then quantity*unitprice else 0 end) as sunday_sales 
from early_sales
where year(invoicedate)=2023 and month(invoicedate) in (1,2) group by week_no
)
select week_no,
round((monday_sales/total_price)*100,2) as monday_sales_percentage,
round((sunday_sales/total_price)*100,2) as sunday_sales_percentage
from cte;
