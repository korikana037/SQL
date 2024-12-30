/*
there is a phoenlog table that has information about the caller call history
write an sql query to findout the callers whose first and last call was to the same person on a given day
*/

create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
       
       
       
-- method 2
with cte as(
select Callerid, date(Datecalled) as caller_date, min(Datecalled) as first_call, max(Datecalled) as last_call
from phonelog
group by Callerid, date(Datecalled)
)

select c.Callerid, c.caller_date from cte c 
inner join phonelog p on c.Callerid = p.Callerid and c.first_call = p.Datecalled
inner join phonelog pl on c.Callerid = pl.Callerid and c.last_call = pl.Datecalled
where p.Recipientid = pl.Recipientid;

-- method 1
with cte as (
  select *,
  first_value(Recipientid) over(partition by Callerid, day(Datecalled), month(Datecalled) order by Datecalled) as first_call,
  last_value(Recipientid) over(partition by Callerid, day(Datecalled), month(Datecalled) order by Datecalled range between unbounded preceding and unbounded following) as last_call
  from phonelog
  ),
cte2 as(
  select Callerid, date(Datecalled) as date, min(first_call) as first_call, max(last_call) as last_call
  from cte
  group by Callerid, date(Datecalled))
  
  
select date, Callerid from (
select date,
case when first_call = last_call then Callerid end as Callerid
from cte2) a
  where Callerid is not null;
  

