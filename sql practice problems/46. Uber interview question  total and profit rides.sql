-- write a query to print total rides and profit rides for each rides
-- profit ride is when the ending location of current ride is same as starting location of next ride

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');

-- method 2 usong self join
with cte as(
select *, 
row_number() over(partition by id) as rnk
from drivers)


select c1.id, count(c1.start_loc) as total_rides, count(c2.start_loc) as profit_rides from cte c1
left join cte c2 on c1.id = c2.id and c1.end_loc = c2.start_loc and c1.rnk + 1 = c2.rnk
group by c1.id;


-- method 1 using lead
with cte as(
select *,
lead(start_loc) over(partition by id) as start_loc_next_ride,
case when end_loc = lead(start_loc) over(partition by id) then 1 else 0 end as profit_rides
from drivers)
select id, count(start_loc) as total_rides, sum(profit_rides) as profit_rides
from cte
group by id;
