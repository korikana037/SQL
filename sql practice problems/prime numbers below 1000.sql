-- print all the prime numbers below 1000

with recursive cte as(
select 2 as num
    union all
select num +1 from cte
    where  num < 1000
)


select group_concat(num SEPARATOR '&') as num from cte where num not in (
select distinct c1.num as num from cte c1
inner join cte c2 on c1.num>c2.num and mod(c1.num,c2.num) =0
order by c1.num);
