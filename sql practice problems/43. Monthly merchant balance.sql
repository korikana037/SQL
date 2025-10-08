/*
Say you have access to all the transactions for a given merchant account. Write a query to print the cumulative balance of the merchant account at the end of each day, with the total balance reset back to zero at the end of the month.
Output the transaction date and cumulative balance
*/

create table transaction44(
transaction_id int ,
type varchar(300),
amount float,
transaction_date datetime
);
insert into transaction44 values (19153, 'deposit', 65.90, '2022-07-10 10:00:00'),
(53151, 'deposit', 178.55, '2022-07-08 10:00:00'),
(29776, 'withdrawal', 25.90, '2022-07-08 10:00:00'),
(16461, 'withdrawal', 45.99, '2022-07-08 13:00:00'),
(77134, 'deposit',32.60, '2022-07-10 10:00:00');

with cte as(
select date(transaction_date) as transaction_date,
sum(case when type = 'withdrawal' then amount*(-1) else amount end) as new_amount
from transaction44
group by date(transaction_date)
order by date(transaction_date)
)

select *,
sum(new_amount) over (partition by year(transaction_date), month(transaction_date) order by date(transaction_date)) as cumm_sum
from cte;






-- cumm balance at end of each day and monthly reset
-- with cte as(
-- select *,
-- sum(amount) over(partition by date(transaction_date), type order by transaction_date) as ttl_sum
-- from transaction44
-- )
-- select date(transaction_date) as curr_date ,type, max(ttl_sum)from cte
-- group by date(transaction_date), type;

