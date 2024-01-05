select * from orders  ;
select * from items;
##  display distinct fooditems ordered
select distinct name from items;
## How many  distinct fooditems ordered
select count(distinct name)  from items;
## group vegeterian and meat items together;
select is_veg, count(name) as items from items group by is_veg;
## count the number of unique orders;
select count(distinct order_id) from orders;
## How many paratha items we ordered
select count(name) from items where name like"%paratha%";
##Average Items per Order
 select count(name)/count(distinct order_id) from items;
 ## Item ordered the most number of times
 select name,count(*) from items group by name order by count(*) desc;
 ## orders during rainy times;
 select count(*) from orders where rain_mode=2;
 SELECT distinct rain_mode FROM orders;
 ## how many on time was delivered
 select on_time,  count( on_time) from orders group by on_time;
## How many distinct restaurents we ordered;
select count(distinct restaurant_name   ) from orders;
## Restaurant with most orders
select restaurant_name,count(order_id) from orders 
group by restaurant_name order by count(order_id) desc;
## or 
select restaurant_name,count(*) from orders 
group by restaurant_name order by count(*) desc;
## orders placed per month and year
select date_format(order_time,"%M%Y"),count(*) from orders 
group by date_format(order_time,"%M%Y") order by  count(*) desc;
### Revenue made by month
select date_format(order_time,"%M"), sum(order_total) from orders 
group by date_format(order_time,"%M") order by sum(order_total) desc;
## Average order value:
select avg(order_total) from orders;
SELECT sum(order_total)/count(distinct order_id) as aov
FROM orders;
## Year wise total revenue:
select date_format(order_time,"%Y%M"),sum(order_total) as revenue  from orders
group by  date_format(order_time,"%Y%M") order by   date_format(order_time,"%Y%M") asc ;
###YOY change in revenue:
select date_format(order_time,"%Y") as year1 ,sum(order_total) as revenue ,lag(sum(order_total))
 over(order by date_format(order_time,"%Y")) as previousyearrevenue , 
 rank() over (order by sum(order_total) desc) as rank1
 from orders 
 group by year1;
 ###(((or)))
with final as (
SELECT date_format(order_time,"%Y") as yearorder,sum(order_total) as revenue 
FROM orders
group by  date_format(order_time,"%Y"))
select yearorder,revenue,lag(revenue) over (order by yearorder) as previousrevenue from
final;
## ranking the highest year for revenue:
select date_format(order_time,"%Y") as year1 ,sum(order_total) as revenue ,
 rank() over (order by sum(order_total) desc ) as rank1 
 from orders 
 group by date_format(order_time,"%Y") ;
##  Restaurant with highest revenue ranking
select restaurant_name, sum(order_total) as revenue , rank() over( order by sum(order_total ) desc) as rank1
 from orders group by restaurant_name order by sum(order_total) desc ; 
## Join order and item tables and find product combos using self join
select i.is_veg,i.name,o.restaurant_name,o.order_id,o.order_time from items i
join orders o on i.order_id=o.order_id; 
## find product combos using self join
SELECT a.order_id,a.name,b.name as name2,concat(a.name,"-",b.name) FROM items a
join items b on a.order_id=b.order_id
where a.name!=b.name
and a.name<b.name
