

CREATE TABLE students(
 studentid int NULL,
 studentname nvarchar(255) NULL,
 subject nvarchar(255) NULL,
 marks int NULL,
 testid int NULL,
 testdate date NULL
);
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');


--  q1. get list of students who scoreed avobe the average marks in each subject
with avg_marks as(
select subject, avg(marks) as avg_sub_marks
from students
group by subject)

select * from students s
left join avg_marks a on s.subject=a.subject
where s.marks>a.avg_sub_marks

-- q2. get percentage  of students who scored more than 90 in any subject amongst the total students 
select 
count(distinct case when marks>90 then studentid else null end)/ count(distinct studentid)*100 as perc
from students

-- q3 get second highest and second lowest marks for each subject
using nth value
select subject, min(second_lowest), min(second_highest) from (
select *,
nth_value(marks, 2)over(partition by subject order by marks rows between unbounded preceding and unbounded following ) as second_lowest,
nth_value(marks, 2)over(partition by subject order by marks desc rows between unbounded preceding and unbounded following ) as second_highest
from students) a
group by subject

-- using rank

select subject, 
sum(case when rnk_desc=2 then marks else null end) as second_highest,
sum(case when rnk_asc= 2 then marks else null end) as second_lowest
from(
select subject, marks,
rank()over(partition by subject order by marks ) as rnk_asc,
rank()over(partition by subject order by marks desc) as rnk_desc 
from students) A 
group by subject

-- q4 for each student and test identify if their marks increased or decreased

select *, case when marks>prev_marks then 'increased' else 'decreased' end as result from(
select *, 
lag(marks,1)over(partition by studentid order by testdate,subject) as prev_marks
from students
order by studentid,testdate,subject) a
