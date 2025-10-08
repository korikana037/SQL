create table cricket(
player varchar(255),
match1 int,
match2 int,
match3 int
);

insert into cricket values ("Virat Kohli", 85, 100, 75),("Steve Smith", 90, 105, 80),("Kane Williamson", 88, 95, 70);
        
select * from cricket;

select player, match1 as score, 'match1' as x  from cricket
union all
select player, match2 as score, 'match2' as x  from cricket
union all
select player, match3 as score, 'match3' as x  from cricket
order by x, player