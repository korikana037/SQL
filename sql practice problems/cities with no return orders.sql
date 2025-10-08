
-- write an sql query to find cities where not even a signle order was returned
create table namaste_orders
(
order_id int,
city varchar(10),
sales int
);

create table namaste_returns
(
order_id int,
return_reason varchar(20)
);

insert into namaste_orders
values(1, 'Mysore' , 100),(2, 'Mysore' , 200),(3, 'Bangalore' , 250),(4, 'Bangalore' , 150)
,(5, 'Mumbai' , 300),(6, 'Mumbai' , 500),(7, 'Mumbai' , 800)
;
insert into namaste_returns values
(3,'wrong item'),(6,'bad quality'),(7,'wrong item');


select distinct city from namaste_orders where city not in (
select  distinct city  from namaste_orders no
left join namaste_returns nr on no.order_id=nr.order_id
where nr.order_id is not null);

