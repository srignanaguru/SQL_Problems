use day1;

-- To find out the exclusive user count and group by client_id (unique user )

CREATE TABLE meetup_events (
    client_id VARCHAR(255),
    customer_id VARCHAR(255),
    event_id BIGINT,
    event_type VARCHAR(255),
    id BIGINT PRIMARY KEY,
    time_id DATETIME,
    user_id VARCHAR(255)
);

INSERT INTO meetup_events (client_id, customer_id, event_id, event_type, id, time_id, user_id) 
VALUES 
    ('C001', 'CU001', 101, 'click', 1, '2025-01-01 10:00:00', 'U001'),
    ('C001', 'CU002', 102, 'view', 2, '2025-01-01 11:00:00', 'U002'),
    ('C002', 'CU003', 103, 'click', 3, '2025-01-02 10:00:00', 'U003'),
    ('C002', 'CU003', 104, 'view', 4, '2025-01-02 11:00:00', 'U003'),
    ('C003', 'CU004', 105, 'click', 5, '2025-01-03 10:00:00', 'U004'),
    ('C001', 'CU001', 106, 'view', 6, '2025-01-04 10:00:00', 'U001'),
    ('C003', 'CU005', 107, 'click', 7, '2025-01-05 10:00:00', 'U005'),
    ('C004', 'CU006', 108, 'view', 8, '2025-01-06 10:00:00', 'U006'),
    ('C004', 'CU006', 109, 'click', 9, '2025-01-07 10:00:00', 'U006'),
    ('C001', 'CU007', 110, 'click', 10, '2025-01-08 10:00:00', 'U007'),
    ('C003', 'CU002', 111, 'view', 11, '2025-01-09 11:00:00', 'U002');

select * from meetup_events;

select client_id, count(distinct user_id) as exclusive_users from meetup_events 
where user_id not in (select distinct m1.user_id from meetup_events m1 join meetup_events m2 on m1.user_id=m2.user_id and m1.client_id<>m2.client_id)
group by client_id order by exclusive_users desc;
