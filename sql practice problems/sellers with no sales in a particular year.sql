/*
 write a SQL query to identify sellers who did not make any sales in 2020.

*/
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    sale_date DATE,
    order_cost DECIMAL(10, 2),
    customer_id INT,
    seller_id INT
);

INSERT INTO orders (order_id, sale_date, order_cost, customer_id, seller_id) VALUES
(1, '2020-03-01', 1500.00, 101, 1),
(2, '2020-05-25', 2400.00, 102, 2),
(3, '2019-05-25', 800.00, 101, 3),
(4, '2020-09-13', 1000.00, 103, 2),
(5, '2019-02-11', 700.00, 101, 2);



CREATE TABLE sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100)
);

INSERT INTO sellers (seller_id, seller_name) VALUES
(1, 'Daniel'),
(2, 'Ben'),
(3, 'Frank');


select * from sellers where seller_id not in (
select distinct o.seller_id as seller_id from orders o
inner join sellers s on o.seller_id = s.seller_id
where year(sale_date) = 2020)