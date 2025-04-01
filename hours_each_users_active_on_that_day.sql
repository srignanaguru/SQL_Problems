use day1;

-- To find out the hours each users active on that day: starts when state=1 and ends state=0

CREATE TABLE customer_state_log (
    cust_id VARCHAR(10),
    state INT,
    timestamp TIME
);

INSERT INTO customer_state_log (cust_id, state, timestamp) VALUES
    ('c001', 1, '07:00:00'), 
    ('c001', 0, '09:30:00'), 
    ('c001', 1, '12:00:00'), 
    ('c001', 0, '14:30:00'),
    ('c002', 1, '08:00:00'), 
    ('c002', 0, '09:30:00'), 
    ('c002', 1, '11:00:00'), 
    ('c002', 0, '12:30:00'), 
    ('c002', 1, '15:00:00'), 
    ('c002', 0, '16:30:00'),
    ('c003', 1, '09:00:00'), 
    ('c003', 0, '10:30:00'),
    ('c004', 1, '10:00:00'), 
    ('c004', 0, '10:30:00'), 
    ('c004', 1, '14:00:00'), 
    ('c004', 0, '15:30:00'),
    ('c005', 1, '10:00:00'), 
    ('c005', 0, '14:30:00'), 
    ('c005', 1, '15:30:00'), 
    ('c005', 0, '18:30:00');
    
select * from customer_state_log;

with cte as(
select cust_id, state,
case when state=1 then unix_timestamp(timestamp) end as start_time,
case when state=0 then unix_timestamp(timestamp) end as end_time
from customer_state_log
),
cte1 as(
select cust_id,
sum(case when state=1 then start_time end) as sum_start_time,
sum(case when state=0 then end_time end) as sum_end_time
from cte group by cust_id
)
select cust_id, sec_to_time(sum_end_time - sum_start_time) as work_time from cte1;


