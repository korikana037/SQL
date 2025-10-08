create table Traders(
TraderID int primary key,
Name varchar(50),
Planet varchar(50)
);

insert into Traders values(1,'zorax', 'Planet X'), (2, 'Lyra', 'Planet Y');

create table Transactions(
TransactionsID int primary key,
TraderID int,
TotalValue int,
GoodsType varchar(50),
foreign key (TraderID) references Traders(TraderID)
);

insert into Transactions values (1,1,3000, 'Spice'), (2,1,4000, 'Mineral'), (3,2,1500, 'Fabric');

select * from Traders;
select * from Transactions;

-- Problem Statement
-- In the Intergalactic Trade Federation, various merchants and traders operate across multiple planets. The Federation maintains detailed records of its Traders and their Transactions involving shipments of goods in 'Traders' and 'Transactions' tables respectively.
-- The 'Traders' table provides information about the merchants, including their unique IDs, names, and the planet they represent. It contains the following columns: 'TraderID', 'Name', and 'Planet'.
-- The 'Transactions' table logs details of each transaction, including the trader involved, the total value of the transaction, and the type of goods exchanged. It contains the following columns:
-- 'TransactionID', 'TraderID', 'TotalValue', and 'GoodsType'.
-- Your task is to:
-- Generate a report listing the names of traders who have made transactions with a total value greater than the average total value of all transactions for their respective planets. Additionally, include the planet they represent in the report. Only include traders who have made at least two transactions.
-- Return 'Name' and 'Planet'

with cte as(
select t.TraderID as TraderID, t.Name as Name, t.planet as Planet, tr.TransactionsID as TransactionsID, 
tr.TotalValue as TotalValue, tr.GoodsType as GoodsType
from Traders t
inner join Transactions tr on t.TraderID = tr.TraderID),

planet_avg as(
select Planet, avg(TotalValue) as Planet_avg_ttl_val
from cte
group by Planet) 

select c.Name, min(c.Planet) AS Planet
from cte c
inner join planet_avg pa on c.Planet = pa.Planet
group by c.Name
having count(*) >= 2 and sum(c.TotalValue) > max(pa.Planet_avg_ttl_val); 


