
create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from spending
order by spend_date, user_id;
/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an
online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount
spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/
with cte as(
select spend_date, user_id,max(platform) as platform, sum(amount) as amount
from spending
group by spend_date,user_id
having count(distinct platform) =1
union all
select spend_date, user_id,'both' as platform, sum(amount) as amount
from spending
group by spend_date,user_id
having count(distinct platform) =2
union all
select spend_date, null as user_id, 'both' as platform, 0 as amount
from spending
group by spend_date,user_id
)

select spend_date, platform, count( distinct user_id) as total_users, sum(amount) as amount
from cte
group by spend_date, platform


-- brutr force

with cte as(
select spend_date, count( distinct user_id) as no_of_users, 
  group_concat(distinct platform) as platform ,
sum(amount) as amount_spent
from spending
group by spend_date, user_id
)
select spend_date,
case when platform in ('mobile', 'desktop') then platform else 'both' end as platform,
no_of_users,
amount_spent
from cte