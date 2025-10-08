-- there are 3 rows each with 10 seats in a movie hall
-- write an sql query to find 4 consecutive empty seats


create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);

-- method 3
with cte as (
select *
,case when sum(case when occupancy = 0 then 1 else 0 end) over(partition by left(seat,1) rows between 3 preceding and current row) = 4 then 'true' 
when sum(case when occupancy = 0 then 1 else 0 end) over(partition by left(seat,1) rows between 2 preceding and 1 following) = 4 then 'true'  
when sum(case when occupancy = 0 then 1 else 0 end) over(partition by left(seat,1) rows between 1 preceding and 2 following) = 4 then 'true' 
when sum(case when occupancy = 0 then 1 else 0 end) over(partition by left(seat,1) rows between current row and 3 following) = 4 then 'true' end flag
from movie)
select * from cte where flag = 'true'

-- method 2 
with cte as(
select *, left(seat,1) as row_id, cast(substring(seat,2) as unsigned) as seat_id from movie
),
cte2 as(
select *,
max(occupancy)over(partition by row_id order by seat_id range between current row and 3 following) as 4_emp,
count(occupancy)over(partition by row_id order by seat_id range between current row and 3 following) as cnt
from cte),
cte3 as(
select * from cte2 
where 4_emp=0 and cnt=4
)
select * from cte2
inner join cte3 on cte2.row_id=cte3.row_id and cte2.seat_id between cte3.seat_id and cte3.seat_id+3;



-- method 1
with cte as(
select *, 
row_number()over(partition by left(seat,1) order by cast(substring(seat,2) as unsigned)) as id_no
from movie),

cte2 as(
select *,
(id_no - row_number()over(partition by left(seat,1) order by cast(substring(seat,2) as unsigned))) as grp
from cte
where occupancy=0)

select seat from (
select *, count(*)over(partition by left(seat,1), grp) as cnt
from cte2) a
where cnt>=4;