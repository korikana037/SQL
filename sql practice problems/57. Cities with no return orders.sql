
-- write sql query to find cities where not even a single order was returned
create table namaste_orders
(
order_id int,
city varchar(10),
sales int
); 

insert into namaste_orders values(1, 'Mysore' , 100),(2, 'Mysore' , 200),(3, 'Bangalore' , 250),
(4, 'Bangalore' , 150),(5, 'Mumbai' , 300),(6, 'Mumbai' , 500),(7, 'Mumbai' , 800);

create table namaste_returns
(
order_id int,
return_reason varchar(20)
);

insert into namaste_returns values
(3,'wrong item'),(6,'bad quality'),(7,'wrong item');

select * from namaste_orders;
select * from namaste_orders;

-- method 1

select distinct city from namaste_orders 
where city not in (
select distinct city from namaste_orders
where order_id in (select order_id from namaste_returns))

-- method 2

select a.city,
count(b.order_id)as cnt
from namaste_orders a 
left join namaste_returns b on a.order_id=b.order_id
group by a.city
having cnt=0

-- method 3

with cte as(
select a.city,
sum(case when b.order_id is null then 0 else 1 end)over(partition by a.city) as cnt
from namaste_orders a 
left join namaste_returns b on a.order_id=b.order_id
)
select distinct * from cte 
where cnt = 0