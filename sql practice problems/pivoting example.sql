create table details(
product varchar(255),
amount int,
country varchar(255)
);

insert into details values ("Banana",1000,"USA"), ("Carrots",1500,"USA"), ("Beans",1600,"USA"), \
      ("Orange",2000,"USA"),("Orange",2000,"USA"),("Banana",400,"China"), \
      ("Carrots",1200,"China"),("Beans",1500,"China"),("Orange",4000,"China"), \
      ("Banana",2000,"Canada"),("Carrots",2000,"Canada"),("Beans",2000,"Mexico");
      
      
select * from details;
select product,
sum(case when country = "USA" then amount end) as USA,
sum(case when country = "China" then amount end) as China,
sum(case when country = "Canada" then amount end) as Canada,
sum(case when country = "Mexico" then amount end) as Mexico
from details
group by product
