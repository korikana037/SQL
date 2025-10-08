
-- find missing quarter
CREATE TABLE STORES (
store varchar(10),
quarter varchar(10),
amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);


-- method 1 using aggregations

select store,
concat('Q',10-sum(cast(substring(quarter,-1,1) as signed))) as q_no
from stores
group by store

-- method 2 using recursion

with recursive cte as(
select distinct store, 1 as q_no from stores
union all
select store, q_no+1 as q_no from cte
where q_no < 4
)
, cte2 as(
select store, concat('Q',q_no) as q_no from cte)

select * from cte2 c 
left join stores s on c.store = s.store and c.q_no = s.quarter
where s.quarter is null

-- method3 using cross joins

with cte as(
select  distinct s1.store, s2.quarter
from stores s1, stores s2
)

select c.store, c.quarter from cte c
left join stores s on  c.store = s.store and  c.quarter=s.quarter
where s.store is null