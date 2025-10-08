
-- find the companies who are having atleast 2 users who speak both English and German 
create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');
-- method 1 using group by
select  company_id from (
select company_id, user_id
from company_users
where language in ('English', 'German')
group by company_id, user_id
having count(distinct language) =2) a 
group by company_id
having count(distinct user_id)>=2

-- method 2 using joins
select a.company_id from company_users a
inner join company_users b on a.company_id=b.company_id and a.user_id=b.user_id and a.language='English' and b.language='German'
group by a.company_id
having count(distinct a.user_id)>=2
