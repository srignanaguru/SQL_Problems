use day1;

-- To find out the absoulte difffernce between the guntime and nettime for both of the genders

CREATE TABLE marathon_male (
    age BIGINT,
    div_tot TEXT,
    gun_time BIGINT,
    hometown TEXT,
    net_time BIGINT,
    num BIGINT,
    pace BIGINT,
    person_name TEXT,
    place BIGINT
);
INSERT INTO marathon_male (
    age, div_tot, gun_time, hometown, net_time, num, pace, person_name, place
) VALUES 
    (25, '1/100', 3600, 'New York', 3400, 101, 500, 'John Doe', 1),
    (30, '2/100', 4000, 'Boston', 3850, 102, 550, 'Michael Smith', 2),
    (22, '3/100', 4200, 'Chicago', 4150, 103, 600, 'David Johnson', 3);
CREATE TABLE marathon_female (
    age BIGINT,
    div_tot TEXT,
    gun_time BIGINT,
    hometown TEXT,
    net_time BIGINT,
    num BIGINT,
    pace BIGINT,
    person_name TEXT,
    place BIGINT
);
INSERT INTO marathon_female (
    age, div_tot, gun_time, hometown, net_time, num, pace, person_name, place
) VALUES 
    (28, '1/100', 3650, 'San Francisco', 3600, 201, 510, 'Jane Doe', 1),
    (26, '2/100', 3900, 'Los Angeles', 3850, 202, 530, 'Emily Davis', 2),
    (24, '3/100', 4100, 'Seattle', 4050, 203, 590, 'Anna Brown', 3);

with cte as(
select "Male" as gender, avg(abs(gun_time-net_time)) as avg_diff from marathon_male
union all
select "Female" as gender, avg(abs(gun_time-net_time)) as avg_diff from marathon_female
)

select abs(max(case when gender="Male" then avg_diff end) - max(case when gender="Female" then avg_diff end)) as avg_diff 
from cte;