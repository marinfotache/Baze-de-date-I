select min(birthdate)
from employee

select *
from employee inner join 
	(select min(birthdate) as min_bd from employee) x 
		on employee.birthdate = x.min_bd

select *
from employee
where birthdate = 
	(select min(birthdate) from employee) 

select current_date 

select e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age 
from employee e

select e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age 
from employee e
where age(current_date, birthdate) = 
	(select max(age(current_date, birthdate)) from employee) 

select * 
from (select e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age 
	from employee e) x


select country, count(*) as n_of_cust
from customer
group by country
order by 2 desc
limit 7

select country, count(*) as n_of_cust
from customer
group by country
having count(*) >= 
	(select min (n_of_cust) 
	from
		(select distinct count(*) as n_of_cust
		from customer
		group by country
		order by 1 desc
		limit 5) x
	)	
order by 2 desc


select *
from 
	(select i.invoiceid, total, sum(quantity * unitprice) as lines_total
	from invoice i inner join invoiceline il on i.invoiceid = il.invoiceid
	group by i.invoiceid) x
where total <> lines_total
order by 1


select c.lastname || ' ' || c.firstname as customer, 
	sum(total) as sales2009
from customer c
	inner join invoice i on c.customerid =  i.customerid
where extract(year from invoicedate) = 2009
group by c.customerid	
order by 1


select c.lastname || ' ' || c.firstname as customer, 
	sum( case when extract(year from invoicedate) = 2009 then total else 0 end) as sales2009,
	sum( case when extract(year from invoicedate) = 2010 then total else 0 end) as sales2010,
	sum( case when extract(year from invoicedate) = 2011 then total else 0 end) as sales2011
from customer c
	inner join invoice i on c.customerid =  i.customerid
group by c.customerid	
order by 1


select lastname || ' ' || firstname as customer, 
	sales2009, sales2010, 
	coalesce(sales2009,0) + coalesce(sales2010,0) as sales_2009_2010
from customer left join 
	(select customerid, sum(total) as sales2009
	 from invoice
	 where extract(year from invoicedate) = 2009
	 group by customerid) x2009 on customer.customerid = x2009.customerid
		left join
	(select customerid, sum(total) as sales2010
	 from invoice
	 where extract(year from invoicedate) = 2010
	 group by customerid) x2010 on customer.customerid = x2010.customerid	
order by 1	






