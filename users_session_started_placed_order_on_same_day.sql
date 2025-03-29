use day1;

-- To find  users, session date, total number of orders, total order vaalue for that day by condition users who started a session and placed on order same day

CREATE TABLE sessions (session_id INT PRIMARY KEY,user_id INT, session_date DATETIME);

INSERT INTO sessions(session_id, user_id, session_date) 
VALUES (1, 1, '2024-01-01 00:00:00'),(2, 2, '2024-01-02 00:00:00'), 
(3, 3, '2024-01-05 00:00:00'), (4, 3, '2024-01-05 00:00:00'), (5, 4, '2024-01-03 00:00:00'), 
(6, 4, '2024-01-03 00:00:00'), (7, 5, '2024-01-04 00:00:00'), (8, 5, '2024-01-04 00:00:00'), 
(9, 3, '2024-01-05 00:00:00'), (10, 5, '2024-01-04 00:00:00');


CREATE TABLE order_summary(order_id INT PRIMARY KEY,user_id INT, order_value INT, order_date datetime);

INSERT INTO order_summary (order_id, user_id, order_value, order_date) VALUES (1, 1, 152, '2024-01-01 00:00:00'), 
(2, 2, 485, '2024-01-02 00:00:00'), (3, 3, 398, '2024-01-05 00:00:00'), (4, 3, 320, '2024-01-05 00:00:00'), 
(5, 4, 156, '2024-01-03 00:00:00'), (6, 4, 121, '2024-01-03 00:00:00'), (7, 5, 238, '2024-01-04 00:00:00'), 
(8, 5, 70, '2024-01-04 00:00:00'), (9, 3, 152, '2024-01-05 00:00:00'), (10, 5, 171,'2024-01-04 00:00:00');

INSERT INTO sessions(session_id, user_id, session_date) 
VALUES (11,6,'2024-01-05 00:00:00');

INSERT INTO order_summary (order_id, user_id, order_value, order_date) 
VALUES(11,6,190,'2024-01-06 00:00:00');

select * from sessions;

select * from order_summary;

select s.user_id, s.session_date, count(o.order_id) as total_no_of_order, sum(o.order_value) as total_order_value from sessions s join order_summary o on s.user_id=o.user_id 
where datediff(s.session_date,o.order_date)=0 
group by s.user_id,s.session_date having count(o.order_id)>0 order by total_order_value
;
