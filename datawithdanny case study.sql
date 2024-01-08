use mysql_projects;
CREATE TABLE sales(customer_id VARCHAR(100),order_date DATE,product_id INTEGER);
INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
  
  CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  
  CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);
INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  select * from sales;
  select * from members;
  select * from menu;
## what is the total amount each customer spent at the restaurant?
select customer_id,sum(price)as totalspend from sales s  join menu m on 
s.product_id=m.product_id group by customer_id;
## How many days has each customer visited the restaurant?group by 
select customer_id,count(distinct order_date) from sales group by customer_id;
## What was the first item from the menu purchased by each customer?
with final as (select  s.*,product_name , rank() over ( partition by customer_id order by order_date)
 as ranking from menu m join sales s on m.product_id=s.product_id )
 select * from final where ranking=1;
 ## What is the most purchased item on the menu and how many times was it purchased by all customers?
 select product_name,count(*) from menu m join sales s on m.product_id=s.product_id  group by product_name;
 ## Which item was the most popular for each customer?
with final2 as (select product_name, customer_id,count(*) as total  
from menu m join sales s on m.product_id=s.product_id group by customer_id,product_name)
 select  product_name, customer_id,total,
rank() over(partition by customer_id order by product_name desc) as 
ranking from final2 group by customer_id,product_name ;
---
## Which item was purchased first by the customer after they became a member?
with final as (
select a.*,b.customer_id as customerid,
rank() over (partition by a.customer_id order by order_date) as ranking,
c.product_name
 from sales a
 left join members b
 on a.customer_id=b.customer_id
 join menu c
 on a.product_id=c.product_id
 where a.order_date>=b.join_date)
select customer_id,ranking,product_name from final where ranking=1; 
## Which item was purchased just before the customer became a member?
select a.*,b.customer_id ,b.join_date,rank() over (partition by a.customer_id order by order_date)
as ranking ,c.product_name from sales a
left join members b on a.customer_id=b.customer_id
join menu c on a.product_id=c.product_id where a.order_date<b.join_date;