-- toatl sales by year
create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);


SET @@cte_max_recursion_depth = 2000;

with recursive cte as(
select min(period_start) as dates, max(period_end) as max_date from sales
union all
select date_add(dates, interval 1 day) as dates, max_date from cte
where dates<max_date
)

select product_id, year(dates) as report_year, sum(average_daily_sales) as total_sales from cte
inner join sales on dates between period_start and period_end
group by product_id, year(dates)
order by product_id, year(dates)
