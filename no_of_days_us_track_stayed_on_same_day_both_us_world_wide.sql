use day1;

-- To find out no. of days U.S track has stayed in 1st position for both U.S and worldwide rankings on same day

CREATE TABLE spotify_daily_rankings_2017_us (
    position INT,
    trackname VARCHAR(255),
    artist VARCHAR(255),
    streams INT,
    url VARCHAR(255),
    date DATETIME
);

INSERT INTO spotify_daily_rankings_2017_us (position, trackname, artist, streams, url, date) 
VALUES 
    (1, 'Track A', 'Artist 1', 500000, 'https://url1.com', '2017-01-01'),
    (2, 'Track B', 'Artist 2', 400000, 'https://url2.com', '2017-01-01'),
    (1, 'Track A', 'Artist 1', 520000, 'https://url1.com', '2017-01-02'),
    (3, 'Track C', 'Artist 3', 300000, 'https://url3.com', '2017-01-02'),
    (1, 'Track D', 'Artist 4', 600000, 'https://url4.com', '2017-01-03'),
    (1, 'Track E', 'Artist 5', 700000, 'https://url5.com', '2017-01-04'),
    (1, 'Track F', 'Artist 6', 800000, 'https://url6.com', '2017-01-05'),
    (1, 'Track F', 'Artist 6', 820000, 'https://url6.com', '2017-01-06');

CREATE TABLE spotify_worldwide_daily_song_ranking (
    id INT,
    position INT,
    trackname VARCHAR(255),
    artist VARCHAR(255),
    streams INT,
    url VARCHAR(255),
    date DATETIME,
    region VARCHAR(50)
);

INSERT INTO spotify_worldwide_daily_song_ranking (id, position, trackname, artist, streams, url, date, region) 
VALUES 
    (1, 1, 'Track A', 'Artist 1', 550000, 'https://url1.com', '2017-01-01', 'US'),
    (2, 2, 'Track B', 'Artist 2', 450000, 'https://url2.com', '2017-01-01', 'US'),
    (3, 1, 'Track A', 'Artist 1', 530000, 'https://url1.com', '2017-01-02', 'US'),
    (4, 1, 'Track D', 'Artist 4', 610000, 'https://url4.com', '2017-01-03', 'AUS'),
    (5, 3, 'Track C', 'Artist 3', 320000, 'https://url3.com', '2017-01-03', 'US'),
    (6, 1, 'Track E', 'Artist 5', 700000, 'https://url5.com', '2017-01-04', 'IND'),
    (7, 1, 'Track F', 'Artist 6', 800000, 'https://url6.com', '2017-01-05', 'US'),
    (8, 1, 'Track F', 'Artist 6', 820000, 'https://url6.com', '2017-01-06', 'US');
    
select * from spotify_daily_rankings_2017_us;

select * from spotify_worldwide_daily_song_ranking;

with cte1 as(
select position,trackname,artist,date from spotify_daily_rankings_2017_us where position=1
),
cte2 as (
select position,trackname,artist,date from spotify_worldwide_daily_song_ranking where position=1 and region in('US')
) 

select c1.trackname,c1.artist, count(*) as no_of_days  from cte1 c1 join cte2 c2 on c1.date=c2.date 
group by c1.trackname,c1.artist order by c1.trackname asc;


