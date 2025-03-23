use day1;

-- To fin out the rmse(root mean squared error) before that we need to obtain actualcost for current month and forcasted value for previous month

CREATE TABLE uber_request_logs(
request_id int, 
request_date datetime, 
request_status varchar(10), 
distance_to_travel float, 
monetary_cost float, 
driver_to_client_distance float);

INSERT INTO uber_request_logs VALUES
(1,'2020-01-09', 'success', 70.59, 6.56,14.36),
(2,'2020-01-24', 'success', 93.36, 22.68,19.9),
(3,'2020-02-08', 'fail', 51.24, 11.39,21.32),
(4,'2020-02-23', 'success', 61.58,8.04,44.26),
(5,'2020-03-09','success', 25.04,7.19,1.74),
(6,'2020-03-24','fail', 45.57, 4.68,24.19),
(7,'2020-04-08', 'success', 24.45,12.69,15.91),
(8,'2020-04-23','success',48.22,11.2,48.82),
(9,'2020-05-08', 'success', 56.63,4.04,16.08),
(10,'2020-05-23', 'fail', 19.03,16.65,11.22),
(11,'2020-06-07', 'fail', 81,6.56,26.6),
(12,'2020-06-22','fail', 21.32,8.86,28.57),
(13,'2020-07-07','fail', 14.74,17.76,19.33),
(14,'2020-07-22', 'success', 66.73,13.68,14.07),
(15,'2020-08-06', 'success', 32.98,16.17,25.34),
(16,'2020-08-21', 'success', 46.49,1.84,41.9),
(17,'2020-09-05', 'fail', 45.98,12.2,2.46),
(18,'2020-09-20', 'success', 3.14,24.8,36.6),
(19,'2020-10-05','success', 75.33,23.04,29.99),
(20,'2020-10-20','success', 53.76,22.94,18.74);

select * from uber_request_logs;

with cte as (
select
month(request_date) as month,
year(request_date) as year,
sum(distance_to_travel)/sum(monetary_cost) as actual_cost
from uber_request_logs 
group by year(request_date),month(request_date)
),
forcast  as (
select year, month, actual_cost, lag(actual_cost) over (order by year, month) as previous_cost,
	actual_cost -(lag(actual_cost) over (order by year, month)) as forcasted_cost
from cte
),
square as (
select power(forcasted_cost,2) as square from forcast
)
select round(sqrt(avg(square)),2) as square_root from square;

