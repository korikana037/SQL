
-- write an sql query to populate category value to the last non null value
create table brands 
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuit','britannia')
,(null,'good day')
,(null,'boost');


select * from brands;


-- method 1 (using join)
-- with cte as(
-- select *,
-- case when category is not null then 1 else 0 end as flg,
-- row_number()over(order by (select null)) as rnk
-- from brands),

-- cte2 as(
-- select *,
-- sum(flg)over(order by rnk) as cnt
-- from cte)

-- select coalesce(f.category,s.category) as category, f.brand_name from cte2 f
-- left join cte2 s on f.cnt=s.cnt and f.rnk>s.rnk and s.category is not null;

-- can also be done using first value

-- select * from brands;