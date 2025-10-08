-- write an sql query to get the starting and ending locations of each customer

CREATE TABLE travel_data (
    customer VARCHAR(10),
    start_loc VARCHAR(50),
    end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
    ('c1', 'New York', 'Lima'),
    ('c1', 'London', 'New York'),
    ('c1', 'Lima', 'Sao Paulo'),
    ('c1', 'Sao Paulo', 'New Delhi'),
    ('c2', 'Mumbai', 'Hyderabad'),
    ('c2', 'Surat', 'Pune'),
    ('c2', 'Hyderabad', 'Surat'),
    ('c3', 'Kochi', 'Kurnool'),
    ('c3', 'Lucknow', 'Agra'),
    ('c3', 'Agra', 'Jaipur');
    
    
-- method 4    
select td1.customer,
max(case when td2.end_loc is null then td1.start_loc end) as starting_location,
max(case when td3.start_loc is null then td1.end_loc end) as ending_location
from travel_data td1 
left join travel_data td2 on td1.customer = td2.customer and td1.start_loc=td2.end_loc
left join travel_data td3 on td1.customer= td3.customer and td1.end_loc = td3.start_loc
group by td1.customer;

    
-- method c3
with cte as (
select customer, start_loc as loc, 'start_loc' as loc_type from travel_data
union all
select customer, end_loc as loc, 'end_loc' as loc_type from travel_data
),
cte2 as(
select *, count(*) over(partition by customer, loc) as cnt from cte)

select customer,
max(case when loc_type='start_loc' then loc end) as starting_location,
max(case when loc_type='end_loc' then loc end) as ending_location
from cte2 where cnt=1
group by customer;





-- method 2   
WITH cte AS (
    SELECT 
        customer, 
        GROUP_CONCAT(start_loc ORDER BY start_loc SEPARATOR ',') AS all_start_locs,
        GROUP_CONCAT(end_loc ORDER BY end_loc SEPARATOR ',') AS all_end_locs
    FROM travel_data
    GROUP BY customer
)
SELECT 
    td.customer, 
    td.start_loc, 
    td.end_loc,
    CASE 
        WHEN FIND_IN_SET(td.start_loc, c.all_end_locs) = 0 THEN 1 
        ELSE 0 
    END AS flg_for_start_loc,
    CASE 
        WHEN FIND_IN_SET(td.end_loc, c.all_start_locs) = 0 THEN 1 
        ELSE 0 
    END AS flg_for_end_loc
FROM 
    travel_data td
JOIN 
    cte c 
ON 
    td.customer = c.customer;


-- method 1   
WITH cte AS (
    SELECT customer, start_loc, end_loc
    FROM travel_data
),
cte2 as(
SELECT *,
    CASE WHEN NOT EXISTS (
        SELECT 1 FROM cte c WHERE c.customer = td.customer AND c.end_loc = td.start_loc
    ) THEN 1 ELSE 0 END AS flg_for_start_loc,
    CASE WHEN NOT EXISTS (
        SELECT 1 FROM cte c WHERE c.customer = td.customer AND c.start_loc = td.end_loc
    ) THEN 1 ELSE 0 END AS flg_for_end_loc
FROM travel_data td)

select customer,
min(case when flg_for_start_loc=1 then start_loc end) as starting_location,
min(case when flg_for_end_loc=1 then  end_loc end) as ending_location
from cte2
group by customer;

