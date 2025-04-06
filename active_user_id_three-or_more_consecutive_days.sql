use day1;

-- To find out the active user id who login three ro more days consecutively

CREATE TABLE sf_events (
    date DATETIME,
    account_id VARCHAR(10),
    user_id VARCHAR(10)
);

INSERT INTO sf_events (date, account_id, user_id)
VALUES
    ('2021-01-01', 'A1', 'U1'),
    ('2021-01-02', 'A1', 'U1'),
    ('2021-01-03', 'A1', 'U1'),
    ('2021-01-04', 'A1', 'U1'),
    ('2021-01-01', 'A1', 'U2'),
    ('2021-01-06', 'A1', 'U3'),
    ('2020-12-24', 'A1', 'U2'),
    ('2020-12-08', 'A1', 'U1'),
    ('2020-12-09', 'A1', 'U1'),
    ('2021-01-10', 'A2', 'U4'),
    ('2021-01-11', 'A2', 'U4'),
    ('2021-01-12', 'A2', 'U4'),
    ('2021-01-15', 'A2', 'U5'),
    ('2020-12-17', 'A2', 'U4'),
    ('2020-12-25', 'A3', 'U6'),
    ('2020-12-25', 'A3', 'U6'),
    ('2020-12-25', 'A3', 'U6'),
    ('2020-12-06', 'A3', 'U7'),
    ('2020-12-06', 'A3', 'U6'),
    ('2021-01-14', 'A3', 'U6'),
    ('2021-02-07', 'A1', 'U1'),
    ('2021-02-10', 'A1', 'U2'),
    ('2021-02-01', 'A2', 'U4'),
    ('2021-02-01', 'A2', 'U5'),
    ('2020-12-05', 'A1', 'U8');


select * from sf_events;

with cte as(
select date(date) as date, account_id, user_id from sf_events order by date
),
cte1 as(
select user_id, date,
	lead(date, 1) over (partition by user_id) as next1,
    lead(date, 2) over (partition by user_id) as next2
from cte 
)

select distinct user_id from cte1 where next1-date=1 and next2-next1=1;
