use day1;

-- To find out the google their next employer right after microsoft

CREATE TABLE linkedin_users (user_id INT,employer VARCHAR(255), position VARCHAR(255), start_date DATETIME,end_date DATETIME);

INSERT INTO linkedin_users (user_id, employer, position, start_date, end_date) VALUES
(1, 'Microsoft', 'developer', '2020-04-13', '2021-11-01'),
(1, 'Google', 'developer', '2021-11-01', NULL),
(2, 'Google', 'manager', '2021-01-01', '2021-01-11'),
(2, 'Microsoft', 'manager', '2021-01-11', NULL),
(3, 'Microsoft', 'analyst', '2019-03-15', '2020-07-24'),
(3, 'Amazon', 'analyst', '2020-08-01', '2020-11-01'),
(3, 'Google', 'senior analyst', '2020-11-01', '2021-03-04'),
(4, 'Google', 'junior developer', '2018-06-01', '2021-11-01'),
(4, 'Google', 'senior developer', '2021-11-01', NULL),
(5, 'Microsoft', 'manager', '2017-09-26', NULL),
(6, 'Google', 'CEO', '2015-10-02', NULL),
(7,'Microsoft','CEO','2015-01-12','2025-12-12'),
(7,'Google','CEO','2016-01-01',NULL),
(8,'Microsoft','manager','2015-04-15','2015-07-01'),
(8,'Google','manager','2015-08-01',NULL);

select * from linkedin_users;

with cte as(
select *,lead(employer) over (partition by user_id order by start_date) as next_position from linkedin_users
)

select * from cte where next_position in ('Google') and employer in ('Microsoft');