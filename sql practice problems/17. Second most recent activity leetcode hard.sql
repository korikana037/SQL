
-- get the second most recent activity of user  and if there is one one activity then get that one
create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


with cte as(
select *,
count(1)over(partition by username) as activity_count,
rank()over(partition by username order by endDate desc) as rnk 
from UserActivity
)

select * from cte
where activity_count=1 or rnk =2