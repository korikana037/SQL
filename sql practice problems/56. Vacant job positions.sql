create table job_positions (id int, title varchar(100), category varchar(100), levels varchar(100), payscale int, totalpost int );                                   
insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);  

create table job_employees ( id  int, name varchar(100), position_id  int); 
insert into job_employees values (1, 'John Smith', 1); 
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2); 
insert into job_employees values (5, 'William Lee', 3); 
insert into job_employees values (6, 'Jessica Clark', 3); 
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3);



with recursive cte as (
    select id, title, category, levels, payscale, totalpost, 1 as n
    from job_positions
    union all
    select id, title, category, levels, payscale, totalpost, n + 1
    from cte
    where n < totalpost
),
cte2 as (
    select *, row_number() over(partition by position_id order by id) as rn
    from job_employees
)
select 
    c.id as position_id,
    c.title,
    c.category,
    c.levels,
    c.payscale,
    c.n AS position_number,
    COALESCE(j.name, 'vacant') AS employee_name
from cte c
left join cte2 j on c.id = j.position_id and c.n = j.rn
order by c.category, c.n;
