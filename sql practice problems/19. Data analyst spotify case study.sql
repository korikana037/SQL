CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

-- Q1. Find total active users each day

select event_date, count( distinct user_id)
from activity
group by event_date

-- -- Q2. Find total active users each week

select week(event_date), count(distinct user_id)
from activity
group by week(event_date)

-- -- Q3. date wise total no of users who made the app-purchase the same day they installed the app-purchase

-- method 1
select a.event_date, count( distinct b.user_id) from activity a
left join activity b on a.user_id = b.user_id and a.event_date=b.event_date and 
a.event_name='app-installed' and b.event_name= 'app-purchase'
group by a.event_date

-- method 2
select event_date, count(new_user) from (
select user_id, event_date,
case when count(distinct event_name) =2 then user_id else null end as new_user
from activity
group by user_id, event_date) a 
group by event_date

-- Q4. percentage of paid users in india, usa and anyother country which has to be tagged as others

with country_usres as(
select  case when country in ('India', 'USA') then country else 'others' end as new_country, count(distinct user_id) as user_cnt from activity
where event_name = 'app-purchase'
group by case when country in ('India', 'USA') then country else 'others' end)
, total as(select sum(user_cnt) as total_users from country_usres)
select new_country, user_cnt*100/total_users as per_users
from country_usres, total

-- Q5. Among all the users who installed the app on thne given day, how many did in app purchase the very next day

select a.event_date, count(distinct b.user_id) from activity a
left join activity b on  a.user_id=b.user_id and a.event_name = 'app-purchase' and
b.event_name = 'app-installed' and datediff(a.event_date, b.event_date) = 1
group by a.event_date