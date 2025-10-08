

--  find the total number of messages exchanged between each person per day
CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);


select sms_date, p1, p2, sum(sms_no) from (
select sms_date,
case when sender<receiver then sender else receiver end as p1,
case when sender>receiver then sender else receiver end as p2,
sms_no
from subscriber) a 
group by sms_date, p1, p2

-- method 2
select sms_date, person1, person2, sms_no from (
select a.sms_date, least(a.sender,coalesce(b.sender, a.sender)) as person1, greatest(a.receiver, coalesce(b.receiver,a.receiver)) as person2, a.sms_no + coalesce(b.sms_no, 0) as sms_no from subscriber a 
left join subscriber b on a.sms_date=b.sms_date and a.sender=b.receiver and a.receiver=b.sender) a 
group by sms_date,person1,person2, sms_no
