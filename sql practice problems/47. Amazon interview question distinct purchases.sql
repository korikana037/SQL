
/*
write an sql query to find users who purchased different products on differnt dates
i.e, products purchased on any given day are not repeated on any other day
*/

CREATE TABLE purchase_history (
    userid INT,
    productid INT,
    purchasedate DATE
);

INSERT INTO purchase_history (userid, productid, purchasedate) VALUES
(1, 1, STR_TO_DATE('23-01-2012', '%d-%m-%Y')),
(1, 2, STR_TO_DATE('23-01-2012', '%d-%m-%Y')),
(1, 3, STR_TO_DATE('25-01-2012', '%d-%m-%Y')),
(2, 1, STR_TO_DATE('23-01-2012', '%d-%m-%Y')),
(2, 2, STR_TO_DATE('23-01-2012', '%d-%m-%Y')),
(2, 2, STR_TO_DATE('25-01-2012', '%d-%m-%Y')),
(2, 4, STR_TO_DATE('25-01-2012', '%d-%m-%Y')),
(3, 4, STR_TO_DATE('23-01-2012', '%d-%m-%Y')),
(3, 1, STR_TO_DATE('23-01-2012', '%d-%m-%Y')),
(4, 1, STR_TO_DATE('23-01-2012', '%d-%m-%Y')),
(4, 2, STR_TO_DATE('25-01-2012', '%d-%m-%Y'));

select userid
from purchase_history
group by userid
having count(distinct purchasedate)>1 and
(COUNT(productid) = COUNT(DISTINCT productid) and COUNT(DISTINCT productid) >= COUNT(DISTINCT purchasedate));

