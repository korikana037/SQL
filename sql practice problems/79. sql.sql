
create table assessments
(
id int,
experience int,
sqls int,
algo int,
bug_fixing int
);

insert into assessments values 
(1,3,100,null,50),
(2,5,null,100,100),
(3,1,100,100,100),
(4,5,100,50,null),
(5,5,100,100,100);

with cte as(
select *, 
case when (algo = 100 or algo is null) and (sqls = 100 or sqls is null) and (bug_fixing = 100 or bug_fixing is null) then 1 else 0 end as flg
from assessments
)
-- output exp, total students, student with perfect score 

select experience, count(*) as total_emps, sum(flg) as max_score_emps from cte
group by experience
order by experience desc;