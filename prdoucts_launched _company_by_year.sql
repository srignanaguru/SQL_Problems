use day1;

-- To find the count of product companies between the year 2020 and year 2019 as net difference

CREATE TABLE car_launches (year int, company_name varchar(15), product_name varchar(30));

INSERT INTO car_launches VALUES(2019, 'Toyota', 'Avalon'), 
(2019,'Toyota','Camry'), 
(2020, 'Toyota', 'Corolla'), 
(2019,'Honda', 'Accord'), 
(2019, 'Honda', 'Passport'), 
(2019, 'Honda','CR-V'), 
(2020, 'Honda', 'Pilot'), 
(2019, 'Honda', 'Civic'), 
(2020, 'Chevrolet','Trailblazer'), 
(2020, 'Chevrolet','Trax'), 
(2019, 'Chevrolet', 'Traverse'), 
(2020, 'Chevrolet','Blazer'), 
(2019,'Ford', 'Figo'), 
(2020, 'Ford', 'Aspire'), 
(2019,'Ford', 'Endeavour'), 
(2020, 'Jeep','Wrangler');

with cte as (
select company_name,
	sum(case when year=2019 then 1 else 0 end) as previous_year,
    sum(case when year=2020 then 1 else 0 end) as actual_year
from car_launches where year in (2019,2020) group by company_name
)

select company_name,(actual_year - previous_year) as net_difference from cte group by company_name order by net_difference desc;

