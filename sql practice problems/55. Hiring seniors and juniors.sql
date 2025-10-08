/*
Question: An organization is looking to hire employees /candidates for their junior and 
senior positions. They have a total quota/limit of 50000$ in all, they have to first fill
up the senior positions and then fill up the junior positions, There are 3 test cases, 
write a SQL query to satisfy all the testcases. To check whether your SQL query is correct
or wrong you can try with your own test case too.
*/

Create table candidates(
id int primary key,
positions varchar(10) not null,
salary int not null);

-- test case 1:
insert into candidates values(1,'junior',5000);
insert into candidates values(2,'junior',7000);
insert into candidates values(3,'junior',7000);
insert into candidates values(4,'senior',10000);
insert into candidates values(5,'senior',30000);
insert into candidates values(6,'senior',20000);

-- test case 2:
insert into candidates values(20,'junior',10000);
insert into candidates values(30,'senior',15000);
insert into candidates values(40,'senior',30000);

-- test case 3:
insert into candidates values(1,'junior',15000);
insert into candidates values(2,'junior',15000);
insert into candidates values(3,'junior',20000);
insert into candidates values(4,'senior',60000);

-- test case 4:
insert into candidates values(10,'junior',10000);
insert into candidates values(40,'junior',10000);
insert into candidates values(20,'senior',15000);
insert into candidates values(30,'senior',30000);
insert into candidates values(50,'senior',15000);


with salaries as(
select *,
sum(salary)over(partition by positions order by salary,id) as running_salaries
from candidates),


seniors as(
select * from salaries
where positions='senior' and running_salaries<=50000),

hired_employees as(
select * from salaries
where positions='junior' and running_salaries<=50000- coalesce((select sum(salary) from seniors),0)
union 
select * from seniors)


select sum(case when positions ='senior' then 1 else 0 end) as seniors,
sum(case when positions ='junior' then 1 else 0 end) as junior
from hired_employees;