use day1;

-- To find out the user who started sesssion and placed order on same day and also total no. of orders and total no order value for that day 

CREATE TABLE sessions1(
    session_id INT,
    user_id INT,
    session_date DATETIME
);

INSERT INTO sessions1 (session_id, user_id, session_date) 
VALUES 
    (1, 1, '2024-01-01'),
    (2, 2, '2024-01-02'),
    (3, 3, '2024-01-05'),
    (4, 3, '2024-01-05'),
    (5, 4, '2024-01-03'),
    (6, 4, '2024-01-03'),
    (7, 5, '2024-01-04'),
    (8, 5, '2024-01-04'),
    (9, 3, '2024-01-05'),
    (10, 5, '2024-01-04');

CREATE TABLE order_summary1(
    order_id INT,
    user_id INT,
    order_value INT,
    order_date DATETIME
);

INSERT INTO order_summary1 (order_id, user_id, order_value, order_date) 
VALUES 
    (1, 1, 152, '2024-01-01'),
    (2, 2, 485, '2024-01-02'),
    (3, 3, 398, '2024-01-05'),
    (4, 3, 320, '2024-01-05'),
    (5, 4, 156, '2024-01-03'),
    (6, 4, 121, '2024-01-03'),
    (7, 5, 238, '2024-01-04'),
    (8, 5, 70, '2024-01-04'),
    (9, 3, 152, '2024-01-05'),
    (10, 5, 171, '2024-01-04');
    

select * from sessions1;

select * from order_summary1;

select *from sessions1 s join order_summary1 o on s.user_id=o.user_id 
where date(s.session_date)=date(o.order_date);

select s.user_id,date(session_date) as session_date,count(o.order_id) as total_no_orders, sum(o.order_value) as total_no_order_value from sessions1 s join order_summary1 o on s.user_id=o.user_id 
where date(s.session_date)=date(o.order_date) group by s.user_id,s.session_date ;