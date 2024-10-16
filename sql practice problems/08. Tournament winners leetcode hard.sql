/*
Write an SQL query to find the winner in each group.
The winner in each group is the player who scored the maximum total points within the group.
In the case of a tie, the lowest player_id wins.
*/

create table players
(player_id int,
group_id int);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

with cte as(
select first_player as player, first_score as score from matches
union all
select second_player as player, second_score as score from matches)
,cte2 as(
select group_id,player_id, sum(score) as score from players p 
left join cte c on p.player_id = c.player
group by group_id,player_id)
, cte3 as(
select *, 
row_number()over(partition by group_id order by score desc, player_id) as rnk
from cte2)
select * from cte3
where rnk =1;







