create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

-- method 1
with cte as(
select customer_id, min(order_date) as first_visit_date from
customer_orders
group by customer_id
)

select co.order_date, 
sum(case when co.order_date=c.first_visit_date then 1 else 0 end) as new_customers,
sum(case when co.order_date != c.first_visit_date then 1 else 0 end) as repeat_customers
from customer_orders co
inner join cte c on co.customer_id=c.customer_id
group by co.order_date

-- method 2
with total_customers as(
select order_date,count(1) as customers_per_day from customer_orders
group by order_date),

new_customers as(
select c1.order_date,count(1) as new_customers from customer_orders c1
left join customer_orders c2 on c1.order_date>c2.order_date and c1.customer_id=c2.customer_id
where c2.order_id is null
group by c1.order_date)

select tc.order_date,nc.new_customers, tc.customers_per_day-nc.new_customers as repeat_customers  from total_customers tc 
inner join new_customers nc on tc.order_date=nc.order_date;
