use day1;

-- To find  top 3 businees purpose categoriess by total mileage for the business category

CREATE TABLE my_uber_drives (start_date DATETIME,end_date DATETIME,category VARCHAR(50), start VARCHAR(50), stop VARCHAR(50), miles FLOAT, purpose VARCHAR(50));

INSERT INTO my_uber_drives (start_date, end_date, category, start, stop, miles, purpose) 
VALUES('2016-01-01 21:11', '2016-01-01 21:17', 'Business', 'Fort Pierce', 'Fort Pierce', 5.1, 'Meal/Entertain'), 
('2016-01-02 01:25', '2016-01-02 01:37', 'Business', 'Fort Pierce', 'Fort Pierce', 5, NULL), 
('2016-01-02 20:25', '2016-01-02 20:38', 'Business', 'Fort Pierce', 'Fort Pierce', 4.8, 'Errand/Supplies'), 
('2016-01-05 17:31', '2016-01-05 17:45', 'Business', 'Fort Pierce', 'Fort Pierce', 4.7, 'Meeting'), 
('2016-01-06 14:42', '2016-01-06 15:49', 'Business', 'Fort Pierce', 'West Palm Beach', 63.7, 'Customer Visit'), 
('2016-01-06 17:15', '2016-01-06 17:19', 'Business', 'West Palm Beach', 'West Palm Beach', 4.3, 'Meal/Entertain'), 
('2016-01-06 17:30', '2016-01-06 17:35', 'Business', 'West Palm Beach', 'Palm Beach', 7.1,'Meeting');

select * from my_uber_drives;

select purpose, round(sum(miles),2) as total_milege from my_uber_drives where category='Business'
 group by purpose order by total_milege desc limit 3;