
-- find the cities where covid cases are increasing continuously
create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);

-- method 1 using rank
-- with cte as(
-- select *, 
-- rank()over(partition by city order by days) as rn_days,
-- rank()over(partition by city order by cases) as rn_cases,
-- cast(rank()over(partition by city order by days) as signed) - cast(rank()over(partition by city order by cases) as signed) as diff
-- from covid
-- )
-- select city from cte 
-- group by city
-- having count(distinct diff) = 1 and max(diff)=0

-- method 2 using lag
with cte as(
select *,
cases-lag(cases,1,0)over(partition by city order by days) as diff 
from covid)
select distinct city from cte where city not in (
select city from cte
where diff <=0)
 

