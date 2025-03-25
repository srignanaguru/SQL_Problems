use day1;

-- To find out the absolute differnece between the highest salaries found int marketing and engineering departments

CREATE TABLE db_employee (id INT,first_name VARCHAR(50), last_name VARCHAR(50), salary INT,department_id INT);

INSERT INTO db_employee (id, first_name, last_name, salary, department_id) 
VALUES (10306, 'Ashley', 'Li', 28516, 4), (10307, 'Joseph', 'Solomon', 19945, 1),
 (10311, 'Melissa', 'Holmes', 33575, 1), (10316, 'Beth', 'Torres', 34902, 1),
 (10317, 'Pamela', 'Rodriguez', 48187, 4), (10320, 'Gregory', 'Cook', 22681, 4), 
 (10324, 'William', 'Brewer', 15947, 1), (10329, 'Christopher', 'Ramos', 37710, 4), 
 (10333,'Jennifer', 'Blankenship', 13433, 4), (10339, 'Robert', 'Mills', 13188, 1);

CREATE TABLE db_dept (id INT, department VARCHAR(50));

INSERT INTO db_dept (id, department) VALUES(1, 'engineering'), (2, 'human resource'), (3, 'operation'), (4,'marketing');

select * from db_employee;

select * from db_dept;

select *, max(salary) over (partition by department) as highest_salaries from db_employee db 
join db_dept db1 on db.department_id=db1.id;

with cte as(
select distinct department, max(salary) over (partition by department) as max_salary
from db_employee db 
join db_dept db1 on db.department_id=db1.id
)

select abs(c1.max_salary - c2.max_salary) as absolute_difference from cte c1 
join cte c2 on c1.department="engineering" and c2.department="marketing";