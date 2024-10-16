

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');






-- method 1
with cte as(
select *, day(date_value)-row_number()over(partition by state order by date_value) as grp

from tasks)

select 
min(date_value) as start_date, max(date_value) as end_date, state
from cte
group by grp, state
order by start_date


-- method 2
with cte as (
SELECT *, lag(state, 1,state) over (order by date_value) as prev 
from tasks)

, cte2 as(
SELECT *, sum(case when prev = state then 0 else 1 end) over (order by date_value) as flag
from cte)

SELECT min(date_value) as start, max(date_value) as endDate, min(state) as state
from cte2
GROUP BY flag


-- method 3 
With t1 as(
 select date_value as d, state,
  Row_number() over(partition by state order by date_value) as r,
  Row_number() over(order by date_value) as r2 
  from tasks )
    
 select min(d) as start_date, max(d) as end_date , min(state)
 from t1
 group by (r2-r) Order by start_date;




