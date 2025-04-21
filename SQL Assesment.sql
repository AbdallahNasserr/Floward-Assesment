/*Floward SQL Assessment*/

-- Creating Database
create database floward;
use floward;


-- Creating Customers Table
/*
--------------
Customers
--------------
+----------------+-------------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| customer_id | int | NO |PK | | |
| custmer_name | varchar(100)| YES | | NULL | |
| country | varchar(50) | YES | | NULL | |
| region | varchar(100)| YES | | NULL | |
| register_date | DATE | YES | | NULL | |
+----------------+-------------+------+-----+---------+-------+
*/

drop table if exists customers;
create table Customers(
customer_id int primary key,
customer_name varchar(100) default null ,
country varchar(50) default null ,
region varchar(100) default null,
register_date date default null
);
-- Filling the table with dummy data
insert into Customers (customer_id, customer_name, country, region, register_date)
values
  (1, 'Abdallah Nasser', 'Egypt', 'Cairo', '01-15-2022'),
  (2, 'Ahmed Mostafa', 'Saudi Arabia', 'Riyadh', '12-26-2023'),
  (3, 'Omar Sayed', 'Oman', 'Muscat', '09-30-2023'),
  (4, 'John Mark', 'UK', 'London', '11-16-2021'),
  (5, 'Mazen Osama', 'UAE', 'Dubai', '03-26-2019'),
  (6, 'Mariam Said', 'Egypt', 'Alexandria', '07-21-2024'),
  (7, 'Rami Mahmoud', 'Egypt', 'Giza', '11-23-2024'),
  (8, 'Alice Johnson', 'UK', 'Manchester', '12-12-2023'),
  (9, 'Shakir Osama', 'Saudi Arabia', 'Jeddah', '09-06-2023'),
  (10, 'Omar Said', 'Kuwait', 'Kuwait City', '10-11-2024'),
  (11, 'Mohamed Nasser', 'Egypt', 'Cairo', '01-15-2022'),
  (12, 'Anas Mostafa', 'Saudi Arabia', 'Riyadh', '12-26-2023'),
  (13, 'Shady Sayed', 'Oman', 'Muscat', '09-30-2023'),
  (14, 'Marcos Mark', 'UK', 'London', '11-16-2021'),
  (15, 'Mostafa Osama', 'UAE', 'Dubai', '03-26-2019'),
  (16, 'Somaia Said', 'Egypt', 'Alexandria', '07-21-2024'),
  (17, 'Asmaa Mahmoud', 'Egypt', 'Giza', '11-23-2024'),
  (18, 'James Johnson', 'UK', 'Manchester', '12-12-2023'),
  (19, 'Amira Osama', 'Saudi Arabia', 'Jeddah', '09-06-2023'),
  (20, 'Yousra Said', 'Kuwait', 'Kuwait City', '10-11-2024');



-- Creating Orders Table
/*
--------------
Orders
--------------
+----------------+-------------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| order_id | int | NO |PK | | |
| customer_id | int | NO |FK | | |
| order_date | DATE | YES | | NULL | |
| total_amount | Decimal(10,2) | YES | | NULL | |
+----------------+-------------+------+-----+---------+-------+
*/

drop table if exists orders 
create table Orders(
order_id int primary key,
customer_id int,
order_date date default null,
total_amount decimal(10,2) default null
foreign key (customer_id) references customers(customer_id)
);
-- Filling the Orders Table with dummy data
insert into orders(order_id, customer_id, order_date, total_amount)
values
  (1, 1, '01-20-2022',   200.00),
  (2, 1, '03-15-2023',   180.50),
  (3, 2, '12-28-2023',   450.00),
  (4, 2, '01-12-2024',   125.00),
  (5, 3, '09-30-2023',   310.00),
  (6, 4, '11-20-2021',   170.25),
  (7, 5, '04-05-2019',   220.00),
  (8, 5, '03-26-2019',   180.75),
  (9, 6, '07-21-2024',   390.00),
  (10, 7, '11-23-2024',  99.50),
  (11, 8, '12-15-2023',  275.00),
  (12, 9, '09-10-2023',  320.00),
  (13, 10, '10-18-2024', 285.75),
  (14, 11, '02-14-2022', 140.00),
  (15, 11, '01-25-2022', 90.00),
  (16, 12, '12-30-2023', 165.00),
  (17, 13, '10-10-2023', 210.00),
  (18, 13, '09-30-2023', 100.00),
  (19, 14, '11-30-2021', 305.50),
  (20, 15, '03-28-2019', 275.20),
  (21, 16, '07-30-2024', 180.00),
  (22, 17, '12-03-2024', 120.00),
  (23, 17, '11-29-2024', 85.50),
  (24, 18, '01-15-2024', 250.00),
  (25, 18, '12-22-2023', 190.00),
  (26, 19, '10-01-2023', 160.00),
  (27, 19, '09-06-2023', 245.00),
  (28, 20, '10-20-2024', 310.00),
  (29, 20, '11-05-2024', 275.00),
  (30, 3, '10-15-2023',  140.00),
  (31, 6, '08-01-2024',  215.00),
  (32, 8, '01-08-2024',  190.00),
  (33, 9, '10-01-2023',  110.00),
  (34, 10, '12-20-2024', 210.00),
  (35, 12, '01-10-2024', 140.00),
  (36, 14, '12-10-2021', 95.00),
  (37, 15, '04-15-2019', 105.00),
  (38, 16, '08-21-2024', 115.00),
  (39, 18, '02-14-2024', 85.00),
  (40, 13, '11-01-2023', 145.00);

  ------------------------------------------------------------------------------------------------------------------------------------------



  -- Quering 
	/* - For each customer, find their total orders amount and cumulative order amount over time, ordered by order_date. 
	- Order the set of returned customer based on the customer_id and cumulative order amount 
	Output:
	Customer_id
	customer_name
	Region
	order_date
	total_amount
	cumulative_amount
	Regional_rank */
  
  -- CTE to store the result before ranking 
  with cummulative_cte as(
  select c.customer_id,
		 customer_name,
		 region,
		 order_date,
		 total_amount,
		 sum(total_amount)over(partition by c.customer_id order by order_date asc ) as cummulative_amount
  from Customers c
  inner join orders o
  on c.customer_id = o.customer_id
  )

  -- Regional Ranking using the cummulative_amount column in cummulative_cte CTE
  select *,
		dense_rank() over(partition by region order by cummulative_amount desc) as Regional_Rank
  from cummulative_cte
  order by customer_id,cummulative_amount

  
  -----------------------------------------------------------------------------------------------------------------------------------
  -- Retention Rate
  
  /* 
     I used this equation to calc Retention Rate: 
     Retaintion Rate = Number of Customers with Repeat Orders After Signup Month / Number of Customers Who Ordered in Signup Month *100
  */​

  -- Here i try to categories our visitor whether they are customers or not and wether they are retained or not 
  with customers_classes as(
  select c.*,
		 o.order_date,
		 o.total_amount,
		 o.order_id,
  -- less than one month from registeration date
		case 
			when datediff(day,register_date,order_date)<=30 then 'Customer'
			else 'Not Customer'
			end as Customer,
  -- more than one month from registeration date
		case 
			when datediff(day,register_date,order_date)>30 then 'Retained'
			else 'Not Retained'
		end as Retained
  from Customers c 
  inner join Orders o 
  on c.customer_id = o.customer_id
  )
  -- Here i use the above CTE to get the IDS of customers only not all visitors
  , Customers_only as(
  select distinct customer_id
  from customers_classes
  where Customer = 'Customer'
  )
  -- Here i get IDS of Retained Customers only 
  ,retained_customers as(
  select distinct customer_id
  from customers_classes
  where customer_id in (select customer_id from customers_classes where Customer = 'Customer') 
  and Retained = 'Retained'
  )
  -- Here i Divide them and find Retention Rate
  select format(cast(count(*) as float)  / coalesce(cast((select COUNT(*) from Customers_only) as float),1) *100,'0.#') + '%' as Retention_Rate
  from retained_customers



---------------------------------------------------------------------------------------------------------------------------------------------
-- 20% Deviation

/*
	Identify days in the last year where daily sales significantly deviated
	(±20%) from the 7-day moving average.
*/


with Moving_avg_cte as (
select  order_date,
		sum(total_amount) over(partition by order_date) as total_sales,
		AVG(total_amount) over(order by order_date rows between 6 preceding and current row)as moving_avg
from Customers c 
inner join orders o 
on c.customer_id = o.customer_id
)
select *,
format((total_sales - moving_avg) / moving_avg*100,'0.##') + '%' as Deviation_perc
from Moving_avg_cte
where (total_sales - moving_avg) / moving_avg*100 >=20 or (total_sales - moving_avg) / moving_avg*100<=-20
order by order_date


---------------------------------------------------------------------------------------------------------------------------------------------



-- Thank you for this Amazing Assesment i hope i did well 