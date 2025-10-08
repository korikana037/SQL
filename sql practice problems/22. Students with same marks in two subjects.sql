
-- student having same marks in both Physics and Chemistry
create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

-- method 1 using self join
select * from exams;
select  distinct e.student_id from exams e 
inner join exams x on e.student_id=x.student_id and e.marks=x.marks and e.subject != x.subject

-- method 2 using group by and having clause
select student_id from exams
group by student_id
having count(distinct subject) = 2 and count( distinct marks)= 1

-- method 3 using pivot
with cte as(
select student_id,
sum(case when subject='Chemistry' then marks end) as chem_marks,
sum(case when subject='Physics' then marks end) as phy_marks
from exams
group by student_id)

select * from cte where chem_marks=phy_marks

-- can also be done using lead lag approach