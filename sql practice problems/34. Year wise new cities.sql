-- write an sql query to identify yearwise count of new cities where udaan started their operation

create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),5),(cast('2022-12-15' as date),5),(cast('2022-02-28' as date),12);




select year(bc1.business_date) as year,
sum(case when bc2.city_id is null then 1 else 0 end) as cnt
from business_city bc1
left join  business_city bc2 on bc1.business_date > bc2.business_date and bc1.city_id = bc2.city_id 
group by year(bc1.business_date)
order by year(bc1.business_date)
;