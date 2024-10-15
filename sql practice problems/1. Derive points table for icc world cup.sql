create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

-- method 1
select * from icc_world_cup;
select team, count(*) as matches_played, sum(win_flag) as wins, count(*)-sum(win_flag) as loses from (
select Team_1 as team, case when Team_1=winner then 1 else 0 end as win_flag from icc_world_cup
union all
select Team_2 as team, case when Team_2=winner then 1 else 0 end as win_flag from icc_world_cup) a 
group by team


-- method 2
with cte as(
select  Team_1 as team from icc_world_cup
union all
select  Team_2 as team from icc_world_cup)
,cte2 as(
select team, count(*) as matches_played from cte
group by team)

select team, matches_played,wins,(matches_played-wins)as loses from(
select team, matches_played, count(Winner) as wins from cte2 c
Left join icc_world_cup i on c.team =i.Winner
group by team, matches_played) a;