use day1;

-- To find out the average signup duration and average transactional amount for each location and also calculate its ratio

-- Create table for customer signups
CREATE TABLE cust_signups (
    location VARCHAR(100),
    plan_id BIGINT,
    signup_id BIGINT PRIMARY KEY,
    signup_start_date DATETIME,
    signup_stop_date DATETIME
);

-- Insert data into customer signups
INSERT INTO cust_signups (location, plan_id, signup_id, signup_start_date, signup_stop_date)
VALUES 
    ('New York', 101, 1, '2025-01-01', '2025-01-31'),
    ('San Francisco', 102, 2, '2025-01-05', '2025-02-05'),
    ('Los Angeles', 103, 3, '2025-01-10', '2025-01-20'),
    ('New York', 104, 4, '2025-02-01', '2025-02-28'),
    ('Los Angeles', 105, 5, '2025-01-15', '2025-01-25');

-- Create table for customer transactions
CREATE TABLE cust_transactions (
    amt FLOAT,
    signup_id BIGINT,
    transaction_id BIGINT PRIMARY KEY,
    transaction_start_date DATETIME
);

-- Insert data into customer transactions
INSERT INTO cust_transactions (amt, signup_id, transaction_id, transaction_start_date)
VALUES 
    (100.50, 1, 1001, '2025-01-10'),
    (200.75, 1, 1002, '2025-01-20'),
    (150.00, 2, 1003, '2025-01-15'),
    (300.00, 3, 1004, '2025-01-12'),
    (400.00, 4, 1005, '2025-02-15'),
    (250.00, 5, 1006, '2025-01-20');


select * from cust_signups;

select * from cust_transactions;

select * from cust_signups c1 join cust_transactions c2 on c1.signup_id=c2.signup_id;

with cte as(
select c1.location, avg(time(datediff(c1.signup_stop_date, c1.signup_start_date))) as avg_duration,
avg(c2.amt) as avg_transaction_amt
from cust_signups c1 join cust_transactions c2 on c1.signup_id=c2.signup_id
group by c1.location
)

select *, avg_transaction_amt/avg_duration as ratio from cte order by ratio desc;