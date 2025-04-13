use day1;

-- To find out the top 3 areas with highest customer density

CREATE TABLE transaction_records (
    customer_id BIGINT,
    store_id BIGINT,
    transaction_amount BIGINT,
    transaction_date DATETIME,
    transaction_id BIGINT PRIMARY KEY
);

INSERT INTO transaction_records (
    customer_id, store_id, transaction_amount, transaction_date, transaction_id
) VALUES 
    (101, 1,  500,  '2024-01-01 10:15:00', 10001),
    (102, 2, 1500,  '2024-01-02 12:30:00', 10002),
    (103, 1,  700,  '2024-01-03 14:00:00', 10003),
    (104, 3, 1200,  '2024-01-04 09:45:00', 10004),
    (105, 2,  800,  '2024-01-05 11:20:00', 10005);
CREATE TABLE stores (
    area_name VARCHAR(20),
    area_size BIGINT,
    store_id BIGINT PRIMARY KEY,
    store_location TEXT,
    store_open_date DATETIME
);
INSERT INTO stores (
    area_name, area_size, store_id, store_location, store_open_date
) VALUES 
    ('Downtown', 1000, 1, 'Main Street',  '2020-01-01'),
    ('Uptown',   1500, 2, 'Park Avenue',  '2021-06-15'),
    ('Midtown',  1200, 3, 'Broadway',     '2019-11-20'),
    ('Suburbs',  2000, 4, 'Elm Street',   '2018-08-10');

select * from transaction_records;

select * from stores;

select * from transaction_records t join stores s on t.store_id=s.store_id;

with cte as(
select count(distinct t.customer_id) as unique_cust , s.area_name,s.area_size from transaction_records t 
join stores s on t.store_id=s.store_id group by s.area_name, s.area_size
)

select area_name, (unique_cust / area_size) as density from cte order by density desc limit 3;