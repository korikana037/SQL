
--  write a  query to find person id, name, number of friends, sum of marks of the person who has friends with total Score
-- greater than 100

Create table friend (pid int, fid int);
insert into friend (pid , fid ) values ('1','2');
insert into friend (pid , fid ) values ('1','3');
insert into friend (pid , fid ) values ('2','1');
insert into friend (pid , fid ) values ('2','3');
insert into friend (pid , fid ) values ('3','5');
insert into friend (pid , fid ) values ('4','2');
insert into friend (pid , fid ) values ('4','3');
insert into friend (pid , fid ) values ('4','5');

create table person (PersonID int,	Name varchar(50),	Score int);
insert into person(PersonID,Name ,Score) values('1','Alice','88');
insert into person(PersonID,Name ,Score) values('2','Bob','11');
insert into person(PersonID,Name ,Score) values('3','Devis','27');
insert into person(PersonID,Name ,Score) values('4','Tara','45');
insert into person(PersonID,Name ,Score) values('5','John','63');

select * from person;
select * from friend;

select pid,min(p2.Name) ,count(*) as num_of_frnds, sum(p.Score) from friend f
inner join person p on f.fid=p.PersonID
inner join person p2 on f.pid = p2.PersonID
group by pid
having sum(p.Score)>100;