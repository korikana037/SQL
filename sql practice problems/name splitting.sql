
-- split a name into first middle and last name
create table customers  (customer_name varchar(30));
insert into customers values ('Ankit Bansal'),('Vishal Pratap Singh'),('Michael'); 

-- method 1
with cte as(
select *,
length(customer_name)-length(replace(customer_name, ' ', '')) as no_of_spaces,
locate(' ', customer_name) as first_space_position,
locate(' ', customer_name,locate(' ', customer_name)+1) as second_space_position
from customers
)

select *,
case when no_of_spaces = 0 then customer_name else substring(customer_name,1,first_space_position-1) end as first_name,
case when no_of_spaces<=1 then null else substring(customer_name,first_space_position+1,second_space_position-first_space_position-1 ) end as middle_name,
case when no_of_spaces=0 then null
      when no_of_spaces = 1 then substring(customer_name, second_space_position+1, length(customer_name)- first_space_position)
      when no_of_spaces >= 2 then substring(customer_name, second_space_position+1, length(customer_name)- first_space_position)
end as last_name
from cte;

-- method 2

SELECT
    customer_name,
    SUBSTRING_INDEX(customer_name, ' ', 1) AS first_name,
    CASE
        WHEN LENGTH(SUBSTRING_INDEX(SUBSTRING_INDEX(customer_name, ' ', 2), ' ', -1)) = LENGTH(SUBSTRING_INDEX(customer_name, ' ', 1)) 
        THEN NULL
        ELSE SUBSTRING_INDEX(SUBSTRING_INDEX(customer_name, ' ', 2), ' ', -1)
    END AS middle_name,
    CASE
        WHEN LENGTH(SUBSTRING_INDEX(customer_name, ' ', -1)) = LENGTH(SUBSTRING_INDEX(customer_name, ' ', 1)) 
        THEN NULL
        ELSE SUBSTRING_INDEX(customer_name, ' ', -1)
    END AS last_name
FROM
    customers;
