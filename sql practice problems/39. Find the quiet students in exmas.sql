create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

/*
Write an SQL query to report the students (student_id, student_name) being "quiet" in ALL exams.
A "quite" student is the one who took at least one exam and didn't score neither the high score nor the low score in any of the exam.
Don't return the student who has never taken any exam. Return the result table ordered by student_id.
*/


create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);

select * from students;
select * from exams;

-- method 1
with cte as(
select *,
first_value(student_id)over(partition by exam_id order by score desc) as first_rn,
last_value(student_id)over(partition by exam_id order by score desc rows between unbounded preceding and unbounded following) as last_rn
from exams),

cte2 as(
select first_rn as student_id from cte
union 
select last_rn as student_id from cte
)

select * from students
where student_id not in (select student_id from cte2) and 
student_id in (select student_id from exams)


-- method 2
with cte as(
select *,
first_value(student_id)over(partition by exam_id order by score desc) as first_rn,
last_value(student_id)over(partition by exam_id order by score desc rows between unbounded preceding and unbounded following) as last_rn
from exams)

select student_id,
max(case when student_id=first_rn or student_id=last_rn then 1 else 0 end) as flg
from cte
group by student_id
having flg=0;