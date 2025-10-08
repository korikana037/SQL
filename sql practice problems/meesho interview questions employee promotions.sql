CREATE TABLE EmployeePromotions (
    employeeId INT,
    promotionDate DATE,
    position VARCHAR(50)
);

INSERT INTO EmployeePromotions (employeeId, promotionDate, position) VALUES
(1, '2020-01-10', 'Junior Developer'),
(1, '2021-06-15', 'Developer'),
(1, '2023-03-20', 'Senior Developer'),
(2, '2019-04-01', 'Sales Associate'),
(2, '2022-08-30', 'Sales Manager');

/*
You are given a table Employee Promotions that records the promotion history of employees in a company.
Each record represents a promotion event for an employee, including their new position and the date of promotion. 
This table contains columns: employeeld, promotion Date, position.
Write an SQL query to generate a report that shows each promotion event along with the previous position held 
and the duration (in days) the employee spent in that previous position. For the first promotion event of each employee,
the previous Position should be NULL, and the duration In Previous Position should also be NULL. The output table contains columns:
employeeld, promotionDate, position, previous Position, durationIn Previous Position.
Return the output by ordering in the columns of employeeld and promotionDate
*/

select employeeId, promotionDate, position, 
lag(position,1)over(partition by employeeId order by promotionDate) as prev_position,
datediff(promotionDate, lag(promotionDate,1)over(partition by employeeId order by promotionDate)) as durationinpreviosposition
from EmployeePromotions
order by employeeId, promotionDate

