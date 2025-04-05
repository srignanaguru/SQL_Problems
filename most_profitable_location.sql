use day1;

-- To find most profitable location by calculating avg signup duration and avg transaction amt for each location and also finding those ratio

CREATE TABLE signups (
    signup_id INT PRIMARY KEY,
    signup_start_date DATETIME,
    signup_stop_date DATETIME,
    plan_id INT,
    location VARCHAR(100)
);

INSERT INTO signups (signup_id, signup_start_date, signup_stop_date, plan_id, location)
VALUES 
    (1, '2020-01-01 10:00:00', '2020-01-01 12:00:00', 101, 'New York'),
    (2, '2020-01-02 11:00:00', '2020-01-02 13:00:00', 102, 'Los Angeles'),
    (3, '2020-01-03 10:00:00', '2020-01-03 14:00:00', 103, 'Chicago'),
    (4, '2020-01-04 09:00:00', '2020-01-04 10:30:00', 101, 'San Francisco'),
    (5, '2020-01-05 08:00:00', '2020-01-05 11:00:00', 102, 'New York');

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    signup_id INT,
    transaction_start_date DATETIME,
    amt FLOAT,
    FOREIGN KEY (signup_id) REFERENCES signups(signup_id)
);

INSERT INTO transactions (transaction_id, signup_id, transaction_start_date, amt)
VALUES 
    (1, 1, '2020-01-01 10:30:00', 50.00),
    (2, 1, '2020-01-01 11:00:00', 30.00),
    (3, 2, '2020-01-02 11:30:00', 100.00),
    (4, 2, '2020-01-02 12:00:00', 75.00),
    (5, 3, '2020-01-03 10:30:00', 120.00),
    (6, 4, '2020-01-04 09:15:00', 80.00),
    (7, 5, '2020-01-05 08:30:00', 90.00);
    
select * from signups;

select * from transactions;

with cte1 as (
    select location,avg(timestampdiff(second, signup_start_date, signup_stop_date) / 60.0) as avg_signup_time
    from signups
    group by location
),
cte2 as (
    select  s.location, avg(t.amt) as avg_transaction_amt_each_location
    from transactions t
    join signups s on t.signup_id = s.signup_id
    group by s.location
),
cte3 as (
    select 
        c1.location,
        c1.avg_signup_time,
        c2.avg_transaction_amt_each_location
    from cte1 c1
    join cte2 c2 on c1.location = c2.location
)
select *, round(avg_transaction_amt_each_location / avg_signup_time, 2) as ratio
from cte3
order by ratio desc;



