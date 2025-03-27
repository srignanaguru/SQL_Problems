use day1;

-- To find the invalid transaction id by saturday or sunday transaction or public holidays or timing mon-fri 9:00 to 16:00

create table boi_transactions(
	transaction_id int primary key,
    time_stamp datetime not null
);

insert into boi_transactions(transaction_id, time_stamp) values
(1051,'2022-12-03 10:15'),
(1052, '2022-12-03 17:00'),
(1053, '2022-12-04 10:00'),
(1054, '2022-12-04 14:00'),
(1055, '2022-12-05 08:59'),
(1056, '2022-12-05 16:01'),
(1057, '2022-12-06 09:00'),
(1058, '2022-12-06 15:59'),
(1059, '2022-12-07 12:00'),
(1060, '2022-12-08 09:00'),
(1061, '2022-12-09 10:00'),
(1062, '2022-12-10 11:00'),
(1063, '2022-12-10 17:30'),
(1064, '2022-12-11 12:00'),
(1065, '2022-12-12 08:59'),
(1066, '2022-12-12 16:01'),
(1067, '2022-12-25 10:00'),
(1068, '2022-12-25 15:00'),
(1069, '2022-12-26 09:00'),
(1070, '2022-12-26 14:00'),
(1071, '2022-12-26 16:30'),
(1072, '2022-12-27 09:00'),
(1073, '2022-12-28 08:30'),
(1074, '2022-12-29 16:15'),
(1075, '2022-12-30 14:00'),
(1076, '2022-12-31 10:00');

select * from boi_transactions;

select transaction_id from boi_transactions 
where ((weekday(time_stamp) between 0 and 4 and time(time_stamp)<'09:00:00' or time(time_stamp)>'16:00:00')) 
or dayofmonth(time_stamp)  in (25,26) or
weekday(time_stamp) in (5,6)
;
