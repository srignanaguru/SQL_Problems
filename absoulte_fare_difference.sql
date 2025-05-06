use day1;

CREATE TABLE titanic (
    passengerid BIGINT PRIMARY KEY,
    name VARCHAR(255),
    pclass BIGINT,
    survived BIGINT,
    age FLOAT,
    fare FLOAT,
    cabin VARCHAR(50),
    embarked VARCHAR(1),
    parch BIGINT,
    sibsp BIGINT,
    ticket VARCHAR(50),
    sex VARCHAR(10)
);

INSERT INTO titanic (
    passengerid, name, pclass, survived, age, fare, cabin, embarked, parch, sibsp, ticket, sex
) VALUES
    (1, 'John Smith',        1, 0, 35, 71.28, 'C85',  'C', 0, 1, 'PC 17599',       'male'),
    (2, 'Mary Johnson',      1, 0, 30, 53.10, 'C123', 'C', 0, 0, 'PC 17601',       'female'),
    (3, 'James Brown',       1, 1, 40, 50.00, NULL,   'S', 0, 0, '113803',         'male'),
    (4, 'Anna Davis',        2, 0, 28, 13.50, NULL,   'S', 0, 1, '250644',         'female'),
    (5, 'Robert Wilson',     2, 0, 32, 13.50, NULL,   'S', 0, 1, '250655',         'male'),
    (6, 'Emma Moore',        3, 0, 25,  7.25, NULL,   'S', 0, 0, '349909',         'female'),
    (7, 'William Taylor',    3, 0, 27,  7.75, NULL,   'Q', 0, 0, 'STON/O 2. 3101282', 'male'),
    (8, 'Sophia Anderson',   3, 1, 22,  8.05, NULL,   'S', 0, 0, '347082',         'female'),
    (9, 'David Thomas',      1, 0, 36, 71.28, 'C85',  'C', 0, 1, 'PC 17599',       'male'),
    (10,'Alice Walker',      1, 0, 33, 53.10, 'C123', 'C', 0, 0, 'PC 17601',       'female');

select * from titanic;

with passengerdifference as(
select t1.name as passenger_name, t1.passengerid as passenger_id, abs(t1.fare - t2.fare) as fare_difference from titanic t1 join titanic t2 on
t1.pclass=t2.pclass and t1.survived=0 and t2.survived=0 and abs(t1.age - t2.age)<=5 and t1.passengerid != t2.passengerid)

select t.name as passenger_nme, avg(pfd.fare_difference) as avg_absolute_fare_difference from titanic t 
left join passengerdifference pfd on t.passengerid=pfd.passenger_id where t.survived=0 group by t.name;