create table booking_table (
    booking_id varchar(10),
    booking_date date,
    user_id varchar(10),
    line_of_business varchar(20)
);

insert into booking_table (booking_id, booking_date, user_id, line_of_business) values
('b1',  '2022-03-23', 'u1', 'Flight'),
('b2',  '2022-03-27', 'u2', 'Flight'),
('b3',  '2022-03-28', 'u1', 'Hotel'),
('b4',  '2022-03-31', 'u4', 'Flight'),
('b5',  '2022-04-02', 'u1', 'Hotel'),
('b6',  '2022-04-02', 'u2', 'Flight'),
('b7',  '2022-04-06', 'u5', 'Flight'),
('b8',  '2022-04-06', 'u6', 'Hotel'),
('b9',  '2022-04-06', 'u2', 'Flight'),
('b10', '2022-04-10', 'u1', 'Flight'),
('b11', '2022-04-12', 'u4', 'Flight'),
('b12', '2022-04-16', 'u1', 'Flight'),
('b13', '2022-04-19', 'u2', 'Flight'),
('b14', '2022-04-20', 'u5', 'Hotel'),
('b15', '2022-04-22', 'u6', 'Flight'),
('b16', '2022-04-26', 'u4', 'Hotel'),
('b17', '2022-04-28', 'u2', 'Hotel'),
('b18', '2022-04-30', 'u1', 'Hotel'),
('b19', '2022-05-04', 'u4', 'Hotel'),
('b20', '2022-05-06', 'u1', 'Flight');

create table user_table (
    user_id varchar(10),
    segment varchar(10)
);

insert into user_table (user_id, segment) values
('u1', 's1'),
('u2', 's1'),
('u3', 's1'),
('u4', 's2'),
('u5', 's2'),
('u6', 's3'),
('u7', 's3'),
('u8', 's3'),
('u9', 's3'),
('u10', 's3');

-- Question 1
-- write a query which gives below output segment, total users in the segment and no of users
-- who users_who_booked_flight_apr2022

select u.segment, count(distinct u.user_id) as ttl_users,
count(distinct case when (b.booking_date between '2022-04-01' and '2022-04-30') and (b.line_of_business='Flight') then u.user_id else null end) as users_who_booked_flight_apr2022
from user_table u
left join booking_table b on u.user_id=b.user_id
group by u.segment

with cte as(
select u.segment, count(distinct u.user_id) as users_who_booked_flight_apr2022 from booking_table b
inner join user_table u on b.user_id=u.user_id
and b.line_of_business = 'Flight' and b.booking_date between '2022-04-01' and '2022-05-01'
group by u.segment)

, cte2 as(
select segment, count(user_id) as ttl_users from user_table
group by segment)

select a.segment, a.users_who_booked_flight_apr2022, b.ttl_users from cte a 
inner join cte2 b on a.segment=b.segment

-- Question 3 
-- write a query to identify users whose first booking is hotel
with cte as(
select *,
row_number()over(partition by user_id order by booking_date) as rnk
from booking_table)

select * from cte 
where rnk =1 and line_of_business='Hotel'

-- Question 4 
-- write a query to calculate the dayys between first and last booking of the user_id

select user_id,  datediff(max(booking_date), min(booking_date)) as no_of_days_between_last_and_first_booking
from booking_table
group by user_id

-- Question 5
-- write a query to count the no of flight and hotel bookings for each of the user segments for year 2022

select u.segment,
sum(case when b.line_of_business = 'Flight' then 1 else 0 end )as flight_bookings,
sum(case when b.line_of_business = 'Hotel' then 1 else 0 end) as hotel_bookings
from user_table u 
left join booking_table b on u.user_id=b.user_id
group by u.segment

-- Question 2
-- find for each segment, the user who made the earliest booking in apr2022, and also return how many
-- total bokings that user made in april 2022


with cte as(
select u.user_id, u.segment, b.booking_id, b.booking_date, b.line_of_business,
row_number()over(partition by u.segment order by b.booking_date, b.booking_id) as rnk, 
count(*)over(partition by u.user_id) as total_bookings_in_apr
from user_table u 
inner join booking_table b on u.user_id=b.user_id
where b.booking_date between '2022-04-01' and '2022-04-30'
)

select * from cte
where rnk = 1




