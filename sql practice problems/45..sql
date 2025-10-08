/*
We wish to capture "deltas" from this table (inserts and deletes) by leveraging a nightly copy of the table. There are no timestamps that can be used for delta processing.
Export PDF
ORDER
ORDER_ID (Primary Key)
This table processes 10,000 transactions per day, including INSERTS, UPDATES, and DELETEs. The DELETEs are physical, so the records will no longer exist in the table.
Adobe Export PDF
Convert PDF Files to Word or Excel Online
Select PDF File
Every day at 12:00AM, a snapshot (copy) of this table created and is an exact copy of the table at that time.
SQL Pre-Sc...estion.pdf X
ORDER COPY
ORDER_ID (Primary Key)
Convert to
Microsoft Word (*.docx)
Requirement:
Document Language:
English (U.S.) Change
Write a query that (as efficiently as possible) will return only new INSERTs into ORDER since the snapshot was taken (record is in ORDER, but not ORDER_COPY) OR only new DELETEs from ORDER since the snapshot was taken (record is in ORDER_COPY, but not ORDER).
The query should return the Primary Key (ORDER_ID) and a single character ("INSERT_OR_DELETE_FLAG") of "I" if it is an INSERT, or "D" if it is a DELETE.
For example, consider the Ven Diagram below depicting Inserts and Deletes and the desired result set:
Convert
*/

create table tbl_orders (
order_id integer,
order_date date
);
insert into tbl_orders
values (1,'2022-10-21'),(2,'2022-10-22'),
(3,'2022-10-25'),(4,'2022-10-25');

create table tbl_orders_copy as select * from tbl_orders;

insert into tbl_orders
values (5,'2022-10-26'),(6,'2022-10-26');
delete from tbl_orders where order_id=1;



select coalesce(o.order_id, c.order_id) as order_id,
case 
    when o.order_id is null then 'D'
    when c.order_id is null then 'I' 
end as flag 
from tbl_orders o
left join tbl_orders_copy c on o.order_id=c.order_id
where o.order_id is null or c.order_id is null

union

select coalesce(o.order_id, c.order_id) as order_id,
case 
    when o.order_id is null then 'D'
    when c.order_id is null then 'I' 
end as flag 
from tbl_orders o
right join tbl_orders_copy c on o.order_id=c.order_id
where o.order_id is null or c.order_id is null;


