

create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');


-- 
with cte as(
select *, sum(case when status='on' then 0 else 1 end) over(order by event_time desc) grp_key 
from event_status )
select min(event_time) login, max(event_time) logout, count(*)-1 count
from cte 
group by grp_key
order by grp_key desc

-- 

with cte as(
select *,
lag(status,1,status)over(order by event_time) as prev_stat
from event_status)
,cte2 as(
select *,
sum(case when status= 'on' and prev_stat = 'off' then 1 else 0 end)over(order by event_time) as group_key
from cte)

select min(event_time) as login, max(event_time) as logut, count(*)-1 as on_count from cte2
group by group_key


