/* SECTION 1 CREATE TABLE STATEMENTS */

create table adck765Product
(
product_no integer primary key,
product_name varchar(100),
brand varchar(45),
price decimal(7,2)
);

create table adck765Employee
(
employee_no integer primary key,
employee_name varchar(45),
employee_age integer(3)
);

create table adck765Salesperson
(
sales_commission decimal(7,2),
employee_no integer,
foreign key (employee_no) references adck765Employee (employee_no),
primary key (employee_no)
);

create table adck765Manager
(
bonus decimal(7,2),
employee_no integer,
foreign key (employee_no) references adck765Employee (employee_no),
primary key (employee_no)
);

create table adck765Purchase
(
purchase_no integer(10) primary key,
customer_name varchar(45),
purchase_date integer(6),
product_no integer,
employee_no integer,
foreign key (product_no) references adck765Product (product_no),
foreign key (employee_no) references adck765Employee (employee_no)
);


/* SECTION 2 INSERT STATEMENTS */

insert into adck765Product values
(1, 'Player Stratocaster', 'Fender', 499.99),
(2, 'Player Telecaster', 'Fender', 499.99),
(3, 'Professional Stratocaster', 'Fender', 1999.99),
(4, 'Professional Telecaster', 'Fender', 1999.99),
(5, 'Custom Stratocaster', 'Fender', 4999.99),
(6, 'Custom Telecaster', 'Fender', 4999.99),
(7, 'Les Paul Standard', 'Gibson', 1999.99),
(8, 'SG Standard', 'Gibson', 1499.99),
(9, 'Les Paul Custom', 'Gibson', 2999.99),
(10, 'SG Custom', 'Gibson', '2499.99'),
(11, 'Custom 24', 'PRS', 7499.99),
(12, 'Custom 24 Limited Edition', 'PRS', '7999.99');

insert into adck765Employee values
(1, 'Nathan Drake', 31),
(2, 'Elena Fisher', 31),
(3, 'Victor Sullivan', 58),
(4, 'Eddy Raja', 34),
(5, 'Atoq Navarro', 35),
(6, 'Gabriel Roman', 62),
(7, 'Chloe Frazer', 28),
(8, 'Harry Flynn', 33),
(9, 'Zoran Lazarevic', 47),
(10, 'Karl Schafer', 68),
(11, 'Charlie Cutter', 42),
(12, 'Katherine Marlow', 57),
(13, 'Samuel Drake', 36),
(14, 'Cassandra Morgan', 56),
(15, 'Arthur Morgan', 30),
(16, 'John Marston', 29),
(17, 'Abigail Roberts', 24),
(18, 'Sadie Adler', 28),
(19, 'Jack Marston', 18),
(20, 'Mary-Beth Gaskill', 22);

insert into adck765Salesperson values
(399.48, 1),
(877.34, 2),
(3999.01, 3),
(343.22, 4),
(1088.72, 5),
(3987.33, 6),
(119.10, 7),
(339.22, 8),
(null, 9),
(199.38, 10);

insert into adck765Manager values
(3678.12, 11),
(3778.90, 12),
(2229.27, 13),
(1433.29, 14),
(1996.22, 15),
(2955.68, 16),
(2968.65, 17),
(1329.12, 18),
(1239.91, 19),
(2991.48, 20);

insert into adck765Purchase values 
(1, 'Cloud Strife', 220101, 3, 7),
(2, 'Tifa Lockhart', 211019, 4, 1),
(3, 'Barret Wallace', 211105, 10, 6),
(4, 'Aerith Gainsborough', 210304, 1, 8),
(5, 'Noctis Caelum', 200302, 12, 2),
(6, 'Prompto Argentum', 200923, 5, 3),
(7, 'Ignis Scientia', 210113, 6, 10),
(8, 'Gladiolus Amicitia', 220202, 11, 5),
(9, 'Chris Redfield', 210607, 9, 9),
(10, 'Leon Kennedy', 200825, 2, 8),
(11, 'Claire Redfield', 211010, 3, 10),
(12, 'Jill Valentine', 220102, 4, 5);
                     

/* SECTION 3 UPDATE STATEMENTS */

update adck765Salesperson set sales_commission = null
where employee_no = 1;

update adck765Purchase set purchase_date = 210102, employee_no = 4
where purchase_no = 12;


/* SECTION 4 SINGLE TABLE QUERIES */

/* 1) Which employees are aged 40 or older? */
select employee_name, employee_age
from adck765Employee 
where employee_age >= 40;

/* 2) Order all employees by the alphabetical order of their first names */
select employee_name
from adck765Employee
order by employee_name asc;

/* 3) Which brands offer more than three different guitar models? */
select brand, count(*)
from adck765Product
group by brand
having count(*)>3;

/* 4) What is the highest amount of bonus a manager earns? */
select max(bonus) 
from adck765Manager;

/* 5) List the names of all customers whose first names begins with 'C' */
select customer_name
from adck765Purchase
where customer_name like 'C%';

/* 6) How old is the youngest employee? */
select min(employee_age)
from adck765Employee;


/* SECTION 5 MULTIPLE TABLE QUERIES */

/* 1) List the names of salespersons who are not currently receiving sales commissions */
select employee_name
from adck765Employee
where employee_no in (select employee_no
from adck765Salesperson
where sales_commission is null);

/* 2) What products has Harry Flynn sold, and to which customers have these products been sold to? */
select product_name, customer_name, employee_name
from adck765Product
inner join adck765Purchase 
on adck765Product.product_no = adck765Purchase.product_no
inner join adck765Employee
on adck765Purchase.employee_no = adck765Employee.employee_no
where employee_name = 'Harry Flynn';

/* 3) Which salespersons receive more than 1000 in sales commission? */
select employee_name, sales_commission
from adck765Employee
inner join adck765Salesperson
on adck765Employee.employee_no = adck765Salesperson.employee_no
where sales_commission > 1000;

/* 4) Which managers receive less than 2000 as a bonus? */
select employee_name, bonus
from adck765Employee
inner join adck765Manager
on adck765Employee.employee_no = adck765Manager.employee_no
where bonus < 2000;

/* 5) Which product did Claire Redfield buy? */
select product_name
from adck765Product
where product_no in (select product_no
from adck765Purchase
where customer_name = 'Claire Redfield');

/* 6) Which customers have bought a Fender guitar? */
select customer_name, product_name, brand
from adck765Purchase
inner join adck765Product
on adck765Purchase.product_no = adck765Product.product_no
where brand = 'Fender';


/* SECTION 6 DELETE ROWS

delete from adck765Purchase
where customer_name = 'Cloud Strife' or customer_name = 'Jill Valentine';

delete from adck765Manager
where bonus > 3000;

*/


/* SECTION 7 DROP TABLES

drop table adck765Purchase;
drop table adck765Manager;
drop table adck765Salesperson;
drop table adck765Employee;
drop table adck765Product;

*/
