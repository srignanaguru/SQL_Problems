use day1;

-- To find out eh no of apple user uses acbook, iphone, ipad and no of total users group them by language

CREATE TABLE playbook_users (
    user_id INT PRIMARY KEY,
    created_at DATETIME,
    company_id INT,
    language VARCHAR(50),
    activated_at DATETIME,
    state VARCHAR(50)
);

INSERT INTO playbook_users (user_id, created_at, company_id, language, activated_at, state) VALUES
    (1, '2024-01-01 08:00:00', 101, 'English', '2024-01-05 10:00:00', 'Active'),
    (2, '2024-01-02 09:00:00', 102, 'Spanish', '2024-01-06 11:00:00', 'Inactive'),
    (3, '2024-01-03 10:00:00', 103, 'French', '2024-01-07 12:00:00', 'Active'),
    (4, '2024-01-04 11:00:00', 104, 'English', '2024-01-08 13:00:00', 'Active'),
    (5, '2024-01-05 12:00:00', 105, 'Spanish', '2024-01-09 14:00:00', 'Inactive');

CREATE TABLE playbook_events (
    user_id INT,
    occurred_at DATETIME,
    event_type VARCHAR(50),
    event_name VARCHAR(50),
    location VARCHAR(100),
    device VARCHAR(50)
);

INSERT INTO playbook_events (user_id, occurred_at, event_type, event_name, location, device) VALUES
(1, '2024-01-05 14:00:00', 'Click', 'Login', 'USA', 'MacBook-Pro'),
(2, '2024-01-06 15:00:00', 'View', 'Dashboard', 'Spain', 'iPhone 5s'),
(3, '2024-01-07 16:00:00', 'Click', 'Logout', 'France', 'iPad-air'),
(4, '2024-01-08 17:00:00', 'Purchase', 'Subscription', 'USA', 'Windows-Laptop'),
(5, '2024-01-09 18:00:00', 'Click', 'Login', 'Spain', 'Andriod Phone');

select * from playbook_users;

select * from playbook_events;

select * from playbook_users p1 join playbook_events p2 on p1.user_id=p2.user_id;

with cte1 as(
select p1.language as language,count(distinct p1.user_id) as apple_users from playbook_users p1 join playbook_events p2 on p1.user_id=p2.user_id
where p2.device in('MacBook-Pro','iphone 5s','iPad-air') group by 1
),
cte2 as(
select p1.language as language ,count(distinct p1.user_id) as total_users from playbook_users p1 join playbook_events p2 on p1.user_id=p2.user_id
where p2.device is not null group by 1
)
select c1.language,c1.apple_users,c2.total_users from cte1 c1 left join cte2 c2 on c1.language=c2.language order by apple_users,total_users desc;
