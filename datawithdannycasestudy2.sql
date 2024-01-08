## In the first week after a customer joins the program (including their join date) 
## they earn 2x points on all items, not just sushi - 
## how many points do customer A and B have at the end of January?

select * from sales;
##productid-menu,, sales
## customer-id-members.sales
WITH ranking AS (
    SELECT
        a.customer_id,
        a.order_date,
        c.product_name,
        c.price,
        CASE
            WHEN a.order_date < b.join_date THEN 'N'
            WHEN b.join_date IS NULL THEN 'N'
            ELSE 'Y'
        END AS member
    FROM
        sales a
    JOIN
        menu c ON a.product_id = c.product_id
    LEFT JOIN
        members b ON a.customer_id = b.customer_id
)
, ranked_data AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY customer_id, member ORDER BY order_date) AS rankcalc
    FROM
        ranking
)
SELECT *
FROM ranked_data;
----
## If each $1 spent equates to 10 points and sushi has a 2x points multiplier -
## how many points would each customer have?

with finalpoints as (
select a.customer_id,a.order_date,c.product_name,c.price,
case when product_name='sushi' then 2*c.price
when a.order_date between b.join_date 
and (b.join_date+ interval 6 day) then 2*c.price
else c.price end as newprice
 from sales a
 join menu c
 on a.product_id=c.product_id
  join members b
 on a.customer_id=b.customer_id
 where a.order_date<='2021-01-31'
)
select customer_id,sum(newprice)*10 from finalpoints
group by customer_id


