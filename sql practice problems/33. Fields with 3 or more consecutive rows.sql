
-- write a query to display the records which have 3 or more consecutive rows
-- with amount of people more than 100(inclusive) each day
create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

with cte as(
select *,
id - row_number()over() as grp
from stadium
where no_of_people >= 100)


-- select * from (
-- select *,
-- count(*) over(partition by grp) as cnt
-- from cte) a
-- where cnt>=3;

select * from cte
where grp in (
select grp
from cte
group by grp
having count(*)>=3);
