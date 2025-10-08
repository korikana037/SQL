/*--determine the user id and corresponding page_ids of the pages liked by their
--friends but not by the user itself.  
*/
CREATE TABLE friends (
    user_id INT,
    friend_id INT
);

INSERT INTO friends VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 1),
(3, 1),
(3, 4),
(4, 1),
(4, 3);

CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
);
INSERT INTO likes VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(2, 'A'),
(3, 'B'),
(3, 'C'),
(4, 'B');

/* solution 1*/

with cte as(
  select f.user_id, f.friend_id, l.page_id as friends_likes
  from friends f
  join likes l on f.friend_id = l.user_id
)

select distinct c.user_id, c.friends_likes as recomendation from cte c
left join likes l on
c.user_id = l.user_id and c.friends_likes = l.page_id
where l.page_id is null;

/* solution 2*/
with cte as
(
select distinct f.user_id, l.page_id from friends f
join likes l on f.friend_id = l.user_id
)

select user_id, page_id from cte
where (user_id, page_id) not in (select user_id, page_id from likes)




