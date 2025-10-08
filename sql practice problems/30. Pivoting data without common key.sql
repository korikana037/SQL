
-- pivot the data from row to column

create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');



select player_groups,
max(case when city = 'Bangalore' then name end) as from_bangalore,
max(case when city = 'Mumbai' then name end) as from_mumbai,
max(case when city = 'Delhi' then name end) as from_delhi
from
(select *,
row_number() over(partition by city order by name) as player_groups
from players_location) a 
group by player_groups;