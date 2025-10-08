/*
The question goes as follows: We need to obtain a list of departments with an average salary
lower than the overall average salary of the company. However, when calculating the company's 
average salary, you must exclude the salaries of the department you are comparing it with. 
For instance, when comparing the average salary of the HR department with the company's average,
the HR department's salaries shouldn't be taken into consideration for the calculation of company
age salary. Likewise, if you want to compare the average salary of the Finance department with 
the company's average, the company's average salary should not include the salaries of the Finance 
department, and so on. Essentially, the company's average salary will be dynamic for each 
department.
*/

create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 10000,4,37);
insert into emp
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (9, 'Mukesh',300,6000,6,51);
insert into emp
values (10, 'Rakesh',300,7000,6,50);
  -- list of departments with avg salary less than the company's avg salary;
  
select * from emp;
select department_id, avg(salary) as dept_avg_sal
from emp 
group by department_id
having avg(salary)>(select avg(a.salary) from emp a 
inner join emp b on a.department_id!=b.department_id)


select department_id, avg(salary) as dept_avg_sal
from emp e1
group by department_id
having avg(salary) > (
    select avg(e2.salary)
    from emp e2
    where e2.department_id != e1.department_id
);

  

 





