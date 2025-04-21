# SQL Analysis Assessment 📊
---

## 🗃️ Data Used
Two tables were created:

### 1. `Customers`
Contains customer information:
- `customer_id`, `customer_name`, `country`, `city`, `register_date`
```sql
drop table if exists customers;
create table Customers(
customer_id int primary key,
customer_name varchar(100) default null ,
country varchar(50) default null ,
region varchar(100) default null,
register_date date default null
);
```

### 2. `Orders`
Contains order transaction data:
- `order_id`, `customer_id`, `order_date`, `total_amount`
> 💡 *All dates were formatted as `MM-DD-YYYY` to match registration and order months properly.*
```sql
drop table if exists orders 
create table Orders(
order_id int primary key,
customer_id int,
order_date date default null,
total_amount decimal(10,2) default null
foreign key (customer_id) references customers(customer_id)
);
```


---
![image](https://github.com/user-attachments/assets/36980b47-50fe-4862-b4fa-7dddd9aad0a5)

![image](https://github.com/user-attachments/assets/815c3983-b487-4156-a4f4-c22daafa3193)

![image](https://github.com/user-attachments/assets/17118320-43ec-46f7-ab21-71baae8632c2)

## 📊 Tasks Required


### 🔹 For each customer, find their total orders amount and cumulative order amount over time, ordered by order_date & Order the set of returned customer based on the customer_id and cumulative order amount 
```sql

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

```


![image](https://github.com/user-attachments/assets/3d775810-e8d3-4640-8de3-211fcde3e088)



### 🔹Retaintion Rate = Number of Customers with Repeat Orders After Signup Month / Number of Customers Who Ordered in Signup Month *100
```sql
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

```
![image](https://github.com/user-attachments/assets/6d683ec4-7586-4c1d-9a4a-a985eb1bcaf4)

### 🔹20% Deviation
```sql

with Moving_avg_cte as (
select  order_date,
		sum(total_amount) over(partition by order_date) as total_sales,
		cast(AVG(total_amount) over(order by order_date rows between 6 preceding and current row) as decimal(10,1))as moving_avg
from Customers c 
inner join orders o 
on c.customer_id = o.customer_id
)
select *,
format((total_sales - moving_avg) / moving_avg*100,'0.##') + '%' as Deviation_perc
from Moving_avg_cte
where (total_sales - moving_avg) / moving_avg*100 >=20 or (total_sales - moving_avg) / moving_avg*100<=-20
order by order_date



```
![image](https://github.com/user-attachments/assets/9c8b5d45-5be9-4888-a8b5-5eaf8dbb59f4)




# Power BI Task 📊 
[🔗 View Power BI Report - Floward Checkout Analysis](https://app.powerbi.com/view?r=eyJrIjoiZjFhMzU0YjQtYjAzOC00NjI2LTg0MmEtMzRjN2EzNGEzMzA5IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9&pageName=ReportSection)


![image](https://github.com/user-attachments/assets/a8389af3-4c15-419d-99e2-ed31386169ab)
![image](https://github.com/user-attachments/assets/c067f47c-ce9e-4070-a0e0-0562ccce60b4)
![image](https://github.com/user-attachments/assets/da5737ac-f9b2-4909-9e69-7af3b39bc119)


# Floward Checkouts Failures Presentation
[🔗 View Presentation - Floward Checkout Analysis](https://www.canva.com/design/DAGlNpVu_E8/xbZGLFgqTV90zorkpXHJqQ/edit?utm_content=DAGlNpVu_E8&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)


![image](https://github.com/user-attachments/assets/209c0b61-7d32-471b-bafd-619189c00904)




