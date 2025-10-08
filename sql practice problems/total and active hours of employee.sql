/* Acies global interview question 
we have a swipe table which keeps track of employee login and logut timings.
Q1. findout the totalhours in time employee spent in office on a particular day?
Q2. findout the productive hours employee spent in office in a day?
*/
CREATE TABLE swipe (
    employee_id INT,
    activity_type VARCHAR(10),
    activity_time datetime
);

-- Insert sample data
INSERT INTO swipe (employee_id, activity_type, activity_time) VALUES
(1, 'login', '2024-07-23 08:00:00'),
(1, 'logout', '2024-07-23 12:00:00'),
(1, 'login', '2024-07-23 13:00:00'),
(1, 'logout', '2024-07-23 17:00:00'),
(2, 'login', '2024-07-23 09:00:00'),
(2, 'logout', '2024-07-23 11:00:00'),
(2, 'login', '2024-07-23 12:00:00'),
(2, 'logout', '2024-07-23 15:00:00'),
(1, 'login', '2024-07-24 08:30:00'),
(1, 'logout', '2024-07-24 12:30:00'),
(2, 'login', '2024-07-24 09:30:00'),
(2, 'logout', '2024-07-24 10:30:00');

with cte as(
  select *, cast(activity_time as date) as activity_date,
  lead(activity_time,1) over(partition by employee_id, cast(activity_time as date) order by activity_time) as logout_time
  from swipe
)

select employee_id,
TIMESTAMPDIFF(HOUR, min(activity_time), max(logout_time)) as total_hours,
sum(TIMESTAMPDIFF(HOUR, activity_time, logout_time)) as productive_hours
from cte
where activity_type='login'
group by employee_id,activity_date;
