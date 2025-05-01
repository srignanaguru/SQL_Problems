use day1;

-- To find out the longest win streak count along with their player id

CREATE TABLE players_results (
    match_date DATETIME,
    match_result VARCHAR(1),
    player_id INT
);

INSERT INTO players_results (match_date, match_result, player_id) VALUES
('2023-01-01', 'W', 1),
('2023-01-02', 'W', 1),
('2023-01-03', 'L', 1),
('2023-01-04', 'W', 1),
('2023-01-01', 'L', 2),
('2023-01-02', 'W', 2),
('2023-01-03', 'W', 2),
('2023-01-04', 'W', 2),
('2023-01-05', 'L', 2),
('2023-01-01', 'W', 3),
('2023-01-02', 'W', 3),
('2023-01-03', 'W', 3),
('2023-01-04', 'W', 3),
('2023-01-05', 'L', 3),
('2023-01-01', 'W', 6),
('2023-01-02', 'L', 6),
('2023-01-03', 'W', 6),
('2023-01-04', 'W', 6),
('2023-01-05', 'W', 6),
('2023-01-06', 'L', 6),
('2023-01-07', 'W', 6),
('2023-01-08', 'W', 6),
('2023-01-09', 'L', 6);


select * from players_results;


with order_row_no as(
select *, 
row_number() over (partition by player_id order by match_date) as row_no
from players_results
),
win_streaks as(
select *,row_no -
row_number() over (partition by player_id, match_result order by match_date) as streak_grp
from order_row_no where match_result='W'
),
grouped as(
select player_id, streak_grp, count(*) as streak_length 
from win_streaks group by player_id, streak_grp
),
longest_streak as(
select player_id, max(streak_length) as longest_win_streak from grouped group by player_id
)

select player_id, longest_win_streak from longest_streak order by longest_win_streak desc limit 1;

