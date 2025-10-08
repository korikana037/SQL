
/*A company wants to hire new employees. The budget of the company for the salaries is $70000. The company's criteria for hiring are:
Keep hiring the senior with the smallest salary until you cannot hire any more seniors.
Use the remaining budget to hire the junior with the smallest salary.
Keep hiring the junior with the smallest salary until you cannot hire any more juniors.
Write an SQL query to find the seniors and juniors hired under the mentioned criteria.*/


create table candidates (
emp_id int,
experience varchar(20),
salary int
);
delete from candidates;
insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);

with running_salaries as(
select *,
sum(salary) over(partition by experience order by salary) as running_sal
from candidates
),
seniors as (
select * from running_salaries
where experience = 'Senior' and running_sal<70000
)

select * from running_salaries
where experience = 'Junior' and running_sal < 70000-(select sum(salary) from seniors)
union all
select * from seniors;