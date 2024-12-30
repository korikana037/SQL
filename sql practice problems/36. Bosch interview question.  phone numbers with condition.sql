
-- write an sql query to find the phone numbers which satisfies the following conditions
-- 1. number shoud have both incoming and outgoing calls
-- 2. total duration of outgoing calls should be greater then incoming calls
create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

-- method 1(cte and filter clause)
with cte as(
select call_number,
sum(case when call_type = 'INC' then call_duration end) as tt_inc_dur,
sum(case when call_type = 'OUT' then call_duration end) as ttl_out_dur
from call_details
group by call_number)

select call_number from cte
where tt_inc_dur is not null and ttl_out_dur is not null and ttl_out_dur>tt_inc_dur;

-- method 2(having clause)
select call_number
from call_details
group by call_number
having sum(case when call_type = 'INC' then call_duration end)>0 and
sum(case when call_type = 'OUT' then call_duration end)>0 and
sum(case when call_type = 'INC' then call_duration end)<
sum(case when call_type = 'OUT' then call_duration end);

-- method 3 (using join)
with cte_out as(
select call_number,
sum(call_duration) as duration
from call_details
where call_type = 'OUT'
group by call_number),

cte_in as(
select call_number,
sum(call_duration) as duration
from call_details
where call_type = 'INC'
group by call_number)

select cte_out.call_number from  cte_out
inner join cte_in on cte_out.call_number=cte_in.call_number
where cte_out.duration>cte_in.duration;



--brute force

-- with cte as(
-- select *,
-- row_number()over(partition by call_number, call_type) as rnk,
-- sum(call_duration)over(partition by call_number, call_type) as ttl_dur
-- from call_details
-- where call_type ='INC' or call_type ='OUT')
-- , cte2 as(
-- select call_number, call_type, min(ttl_dur) as ttl_dur from cte
-- group by call_number,call_type)
-- ,cte3 as(
-- select call_number,
-- min(case when call_type = 'INC' then ttl_dur end) as tt_inc_dur,
-- min(case when call_type = 'OUT' then ttl_dur end) as ttl_out_dur
-- from cte2
-- group by call_number)
-- select call_number from cte3
-- where tt_inc_dur is not null and ttl_out_dur is not null and ttl_out_dur>tt_inc_dur;

