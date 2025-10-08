/*
The Airbnb Booking Recommendations team is trying to understand the "substitutability" of two rentals and whether one rental is a good substitute for another. They want you to write a query to determine if two Airbnb rentals have the same exact amenities offered.
Output the count of matching rental ids.
Assumptions:
If property 1 has kitchen and pool, and property 2 has kitchen and pool too, then it is a good substitute and represents a count of 1 matching rental.
If property 3 has kitchen, pool and fireplace, and property 4 only has pool and fireplace, then it is not a good substitute.
*/


create table rental_amenities(
rental_id int,
amenity varchar(255)
);

insert into rental_amenities values (123, 'pool'), (123, 'kitchen'), (234, 'hot tub'), (234, 'fire place'),
(345, 'kitchen'), (345, 'pool'), (456, 'pool');


with cte as(
select rental_id, group_concat(amenity order by amenity) as amenities
from rental_amenities
group by rental_id)

select count(*) as matching_airbnb from cte c
join cte d on c.rental_id > d.rental_id  and c.amenities=d.amenities;