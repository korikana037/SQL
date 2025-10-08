
-- write an sql query to find the details of employees with 3rd highest salary in each department
-- in case there are less than 3 employees in a deprtment then return the employee details with 
-- lowest salary in that department
CREATE TABLE emp(
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
) ;
insert into emp values(1,'Ankit',14300,4,39,100,'Analytics','Female');
insert into emp values(2,'Mohit',14000,5,48,200,'IT','Male');
insert into emp values(3,'Vikas',12100,4,37,100,'Analytics','Female');
insert into emp values(4,'Rohit',7260,2,16,100,'Analytics','Female');
insert into emp values(5,'Mudit',15000,6,55,200,'IT','Male');
insert into emp values(6,'Agam',15600,2,14,200,'IT','Male');
insert into emp values(7,'Sanjay',12000,2,13,200,'IT','Male');
insert into emp values(8,'Ashish',7200,2,12,200,'IT','Male');
insert into emp values(9,'Mukesh',7000,6,51,300,'HR','Male');
insert into emp values(10,'Rakesh',8000,6,50,300,'HR','Male');
insert into emp values(11,'Akhil',4000,1,31,500,'Ops','Male');

-- method 1

with cte as (
select *,
row_number() over(partition by dep_name order by salary desc) as rnk,
count(*) over(partition by dep_name) as emp_cnt
from emp
)

select *
from cte c
where
    (emp_cnt < 3 and salary = (select min(salary) from cte where dep_name = c.dep_name)) 
    or 
    (emp_cnt >= 3 and rnk = 3);
    
-- where rnk=3 or (emp_cnt<3 and rnk = emp_cnt)


-- method 200WITH cte AS (
    SELECT 
        emp_id,
        emp_name,
        salary,
        manager_id,
        emp_age,
        dep_id,
        dep_name,
        gender,
        NTH_VALUE(salary, 3) OVER (PARTITION BY dep_name ORDER BY salary DESC) AS third_highest_salary,
        MIN(salary) OVER (PARTITION BY dep_name ORDER BY salary DESC) AS min_salary,
        COUNT(*) OVER (PARTITION BY dep_name) AS emp_cnt
    FROM 
        emp
)
SELECT 
    dep_name,
    emp_id,
    emp_name,
    salary,
    manager_id,
    emp_age,
    dep_id,
    gender
FROM 
    cte
WHERE 
    (emp_cnt >= 3 AND salary = third_highest_salary)
    OR 
    (emp_cnt < 3 AND salary = min_salary);

