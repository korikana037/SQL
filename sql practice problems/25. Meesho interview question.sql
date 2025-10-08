
-- find how many products fall into custmer budget along with list of products
-- incase of clash chose the less costly product
create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

select * from customer_budget;
select * from products;

with cte as
(select *,
sum(cost)over(order by cost ) as run_sum
from products)

select customer_id, budget, count(product_id), group_concat(product_id order by product_id) from customer_budget  cb 
left join cte c on cb.budget>=c.run_sum
group by customer_id, budget