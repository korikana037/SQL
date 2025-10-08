
-- total charges as per billing rate

-- Create the 'billings' table
CREATE TABLE billings (
    emp_name VARCHAR(10),
    bill_date DATE,
    bill_rate INT
);

-- Delete any existing data (optional, if needed)
DELETE FROM billings;

-- Insert data into 'billings' with the correct date format
INSERT INTO billings VALUES
('Sachin', '1990-01-01', 25),
('Sehwag', '1989-01-01', 15),
('Dhoni', '1989-01-01', 20),
('Sachin', '1991-02-05', 30);

-- Create the 'HoursWorked' table
CREATE TABLE HoursWorked (
    emp_name VARCHAR(20),
    work_date DATE,
    bill_hrs INT
);

-- Insert data into 'HoursWorked' with the correct date format
INSERT INTO HoursWorked VALUES
('Sachin', '1990-07-01', 3),
('Sachin', '1990-08-01', 5),
('Sehwag', '1990-07-01', 2),
('Sachin', '1991-07-01', 4);

-- Select all data from the 'billings' table
with cte as(
SELECT *,
lead (bill_date,1,'9999-01-01')over(partition by emp_name order by bill_date) nxt_date
FROM billings)

SELECT h.emp_name as emp_name, sum(h.bill_hrs*c.bill_rate) as ttl_amt FROM HoursWorked h 
left join cte c on h.emp_name=c.emp_name and 
h.work_date>=c.bill_date and h.work_date<c.nxt_date
group by h.emp_name
