
-- recommendation system based on product pairs most frequently bought together

create table orders
(
order_id int,
customer_id int,
product_id int
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');


-- optimal solution 

select concat(p1.name, p2.name) as pair, count(*) as purchase_freq from orders o1
inner join orders o2 on o1.order_id = o2.order_id and o1.product_id<o2.product_id
inner join products p1 on o1.product_id = p1.id
inner join products p2 on o2.product_id = p2.id
group by p1.name,p2.name


-- brute force

with cte as(
select * from orders o
inner join products p on o.product_id=p.id)

,cte2 as(
select c.order_id, c.customer_id,
concat(c.name,c2.name) as  name
from cte c
inner join cte c2 on  c.order_id=c2.order_id and  c.customer_id=c2.customer_id and c.name <c2.name
order by c.customer_id, name)

select name as pair, count(*) as purchase_freq from cte2
group by name