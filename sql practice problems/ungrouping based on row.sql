
-- write a mysql query to ungroup the rows in language
create table data( name varchar(300), languages varchar(300));
insert into data values("Manish","Java, Scala, C++");
insert into data values("rahul","spark, Java, Scala, C++");
insert into data values("shyam","CSharp, Vb, spark, python");

select * from data;