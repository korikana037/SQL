
-- find the active subscriptions at the end of 2020 in each market place
create table subscription_history(
  customer_id int,
  market_place varchar(300),
  event_date date,
  event varchar(300),
  subscription_period int
);

insert into subscription_history values
  (1, 'india', '2020-01-05', 's', 6),
  (1, 'india', '2020-12-05', 'r', 1),
  (1, 'india', '2021-01-05', 'c', null);

with cte as (
  select *,
  row_number() over( partition by customer_id order by event_date desc) as rn
  from subscription_history
  where event_date < '2020-12-31'
)

select *,
date_add(event_date, interval subscription_period month) as valid_til
from cte where rn = 1 and event != 'c' 
and date_add(event_date, interval subscription_period month)> ' 2020-12-31' ;
