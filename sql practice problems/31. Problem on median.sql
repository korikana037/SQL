-- mean, mode, median of each company

create table employee 
(
emp_id int,
company varchar(10),
salary int
);

insert into employee values (1,'A',2341);
insert into employee values (2,'A',341);
insert into employee values (3,'A',15);
insert into employee values (4,'A',15314);
insert into employee values (5,'A',451);
insert into employee values (6,'A',513);
insert into employee values (7,'B',15);
insert into employee values (8,'B',13);
insert into employee values (9,'B',1154);
insert into employee values (10,'B',1345);
insert into employee values (11,'B',1221);
insert into employee values (12,'B',234);
insert into employee values (13,'C',2345);
insert into employee values (14,'C',2645);
insert into employee values (15,'C',2645);
insert into employee values (16,'C',2652);
insert into employee values (17,'C',65);


-- method 1

select company, avg(salary) from (
select *,
row_number() over(partition by company order by salary) as rnk,
count(*) over(partition by company) as ttl_cnt
from employee) a
where rnk between ttl_cnt/2 and ttl_cnt/2+1
group by company;
 
-- method 2 

with cte as(
select *,
row_number() over(partition by company order by salary) as rnk,
count(*) over(partition by company) as ttl_cnt
from employee)

select company,
case when ttl_cnt%2 = 1 then
(select salary from cte where company = c.company and rnk = (ttl_cnt+1)/2) else
(select avg(salary) from (select salary from cte where company = c.company and rnk = ttl_cnt/2 or rnk = (ttl_cnt/2)+1) as sub) end as median_salary
from cte c
group by company;





 

