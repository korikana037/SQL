
/*The Pareto principle states that for many outcomes, roughly 80% of consequences come from 20% of causes. eg:
1-80% of the productivity come from 20% of the employees.
2-80% of your sales come from 20% of your clients.
3-80% of decisions in a meeting are made in 20% of the time
4-80% of your sales comes from 20% of your products or services.
*/

-- identify the 20% products that contribute to 80% of sales

with cte as (select product_id, sum(sales) as product_sales 
from orders
group by product_id)

select * from
(select *,
sum(product_sales) over(order by product_sales desc) as running_total
from cte) A
where running_total<=(select 0.8*sum(sales) as eighty_percent_sales from orders)
