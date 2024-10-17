
/* Prime subscription rate by product action I
SQLQuery5.sql - not connected*
Given the following two tables, return the fraction of users, rounded to two decimal places, 
who accessed Amzon music and upgraded to prime mebership within the first 30 days of signing up.*/

-- Create the 'users' table
CREATE TABLE users (
    user_id INTEGER,
    name VARCHAR(20),
    join_date DATE
);
-- Insert data into the 'users' table with the correct date format
INSERT INTO users VALUES 
(1, 'Jon', '2020-02-14'), 
(2, 'Jane', '2020-02-14'), 
(3, 'Jill', '2020-02-15'), 
(4, 'Josh', '2020-02-15'), 
(5, 'Jean', '2020-02-16'), 
(6, 'Justin', '2020-02-17'),
(7, 'Jeremy', '2020-02-18');
-- Create the 'events' table
CREATE TABLE events (
    user_id INTEGER,
    type VARCHAR(10),
    access_date DATE
);
-- Insert data into the 'events' table with the correct date format
INSERT INTO events VALUES 
(1, 'Pay', '2020-03-01'), 
(2, 'Music', '2020-03-02'), 
(2, 'P', '2020-03-12'),
(3, 'Music', '2020-03-15'), 
(4, 'Music', '2020-03-15'), 
(1, 'P', '2020-03-16'), 
(3, 'P', '2020-03-22');

SELECT * FROM users;
SELECT * FROM events;




-- ptimal solution 

select  count(distinct e.user_id)/count(distinct u.user_id) as num_upgrades from users u 
left join events e on u.user_id=e.user_id and e.type='P' and datediff(e.access_date,u.join_date)<=30
where u.user_id in (select user_id from events where type = 'Music');


-- brute force
with cte as(
select count(*) as num_music from events
where type ='Music'
)
, cte2 as(
select count(*) as num_upgrades from events e1 
inner join events e2 on e1.user_id = e2.user_id and e1.type='Music' and e2.type='P' and e1.access_date <e2.access_date
inner join users u on e2.user_id=u.user_id and datediff(e2.access_date,u.join_date)<=30)

select
    (cte2.num_upgrades / cte.num_music) as upgrade_ratio
from cte, cte2;
