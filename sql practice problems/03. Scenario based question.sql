create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR');

-- output should be in the below format
-- name, total_visits, most visisted floor, resources used

-- method 1
with cte as(
select name, floor, count(*) as no_of_floor_visits,
rank()over(partition by name order by count(*) desc) as rnk
from entries
group by name, floor)

,cte2 as(
select name,count(*) as total_visits,
group_concat( distinct resources) as resources_used
from entries
group by name)

select c2.name, c2.total_visits,c.floor as most_visited_floor,c2.resources_used from cte2 c2
inner join cte c on c2.name=c.name
where c.rnk=1

-- more optimized solution 

select name, count(*) as total_visits, (select floor from entries b where b.name=a.name group by floor order by count(*) desc limit 1) as most_floor_visited, 
group_concat(distinct resources) as resources_used
from entries a 
group by name