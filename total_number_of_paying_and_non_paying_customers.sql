use day1;

-- To find out the total no. of paying and non-paying customer by date and non-paying customer is greater than paying customers

CREATE TABLE ms_user_dimension (user_id INT PRIMARY KEY,acc_id INT);

INSERT INTO ms_user_dimension (user_id, acc_id) VALUES (1, 101), (2, 102), (3, 103), (4, 104), (5, 105);

CREATE TABLE ms_acc_dimension (acc_id INT PRIMARY KEY, paying_customer VARCHAR(10));

INSERT INTO ms_acc_dimension (acc_id, paying_customer) VALUES (101, 'Yes'), (102, 'No'), (103, 'Yes'), (104, 'No'), (105, 'No');

CREATE TABLE ms_download_facts (date DATETIME,user_id INT,downloads INT);

INSERT INTO ms_download_facts (date, user_id, downloads) 
VALUES ('2024-10-01', 1, 10), ('2024-10-01', 2, 15), ('2024-10-02', 1, 8), ('2024-10-02', 3, 12), 
('2024-10-02', 4, 20), ('2024-10-03', 2, 25), ('2024-10-03',5,18);

select * from ms_user_dimension;

select * from ms_acc_dimension;

select * from ms_download_facts;

select date(m3.date) as Date, 
	sum(case when m2.paying_customer='No' then m3.downloads else 0 end) as non_paying_customers,
    sum(case when m2.paying_customer='Yes' then m3.downloads else 0 end) as paying_customers
from ms_user_dimension m1 
join ms_acc_dimension m2 on m1.acc_id=m2.acc_id join ms_download_facts m3 on m1.user_id=m3.user_id
group by date having (non_paying_customers>paying_customers) order by Date asc
;

