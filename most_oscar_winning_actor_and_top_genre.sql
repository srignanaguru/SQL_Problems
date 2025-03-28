use day1;

-- To find the genre of the person and name with most number of oscar winning 

CREATE TABLE nominee_information(name varchar(20), amg_person_id varchar(10), top_genre varchar(10), birthday datetime, id int);

INSERT INTO nominee_information VALUES('Jennifer Lawrence', 'P562566', 'Drama','1990-08-15',755), ('Jonah Hill', 'P418718', 'Comedy', '1983-12-20',747), ('Anne Hathaway', 'P292630','Drama', '1982-11-12',744), ('Jennifer Hudson', 'P454405', 'Drama', '1981-09-12',742), ('Rinko Kikuchi', 'P475244','Drama', '1981-01-06', 739);

CREATE TABLE oscar_nominees (year int, category varchar(30), nominee varchar(20), movie varchar(30), winner int, id int);

INSERT INTO oscar_nominees 
VALUES 
(2008, 'actress in a leading role', 'Anne Hathaway', 'Rachel Getting Married', 0, 77),
(2012, 'actress in a supporting role', 'Anne Hathaway', 'Les Misérables', 1, 78), 
(2006, 'actress in a supporting role', 'Jennifer Hudson', 'Dreamgirls', 1, 711),
(2010, 'actress in a leading role', 'Jennifer Lawrence', 'Winter\'s Bone', 1, 717), 
(2012, 'actress in a leading role', 'Jennifer Lawrence', 'Silver Linings Playbook', 1, 718),
(2011, 'actor in a supporting role', 'Jonah Hill', 'Moneyball', 0, 799),
(2006, 'actress in a supporting role', 'Rinko Kikuchi', 'Babel', 0, 1253);

select * from nominee_information;

select * from oscar_nominees;

select * from nominee_information ni join oscar_nominees oi on ni.name=oi.nominee where winner=1;


select ni.top_genre,ni.name,count(oi.winner) as winner from nominee_information ni 
join oscar_nominees oi on ni.name=oi.nominee where winner=1 group by ni.name, ni.top_genre order by winner desc limit 1;
