use day1;

-- To find out the managers with at least 7 reporting employees and count users that reporting himself/herself 

CREATE TABLE employees (id INT PRIMARY KEY,first_name VARCHAR(50), last_name VARCHAR(50), age INT,sex VARCHAR(10), employee_title VARCHAR(50),department VARCHAR(50), salary INT,target INT,bonus INT, email VARCHAR(100),city VARCHAR(50), address VARCHAR(255), manager_id INT);

INSERT INTO employees (id, first_name, last_name, age, sex, employee_title, department, salary, target, bonus, email, city, address, manager_id)  
VALUES
(1, 'Alice', 'Smith', 40, 'F', 'Manager', 'Sales', 90000, 100000, 15000, 'alice.smith@example.com', 'New York', '123 Main St', 1),  
(2, 'Bob', 'Johnson', 35, 'M', 'Team Lead', 'Sales', 80000, 95000, 12000, 'bob.johnson@example.com', 'Chicago', '456 Oak St', 1),  
(3, 'Carol', 'Williams', 30, 'F', 'Sales Executive', 'Sales', 70000, 85000, 10000, 'carol.williams@example.com', 'New York', '789 Pine St', 1),  
(4, 'David', 'Brown', 28, 'M', 'Sales Executive', 'Sales', 68000, 80000, 9000, 'david.brown@example.com', 'Chicago', '101 Maple St', 1),  
(5, 'Emma', 'Jones', 32, 'F', 'Sales Executive', 'Sales', 71000, 86000, 9500, 'emma.jones@example.com', 'New York', '202 Cedar St', 1),  
(6, 'Frank', 'Miller', 45, 'M', 'Manager', 'Engineering', 95000, 105000, 16000, 'frank.miller@example.com', 'San Francisco', '303 Spruce St', 6),  
(7, 'Grace', 'Davis', 29, 'F', 'Engineer', 'Engineering', 73000, 87000, 11000, 'grace.davis@example.com', 'San Francisco', '404 Willow St', 6),
(8, 'Sam', 'Willians',34,'M','Sales Analyst','Sales',78000,85000,10000,'sam.williams@example.com','Chicago','289 East St',1),
(9, 'Jane','Foster',28,'F','Engineer','Engineering',85000,95000,12000,'jane.foster@example.comm','San Fransico','290 West St', 1);



select * from employees;

select e1.first_name as manager_name from employees e1 
join employees e2 on e1.id=e2.manager_id group by manager_name having count(e2.manager_id)>=7;
