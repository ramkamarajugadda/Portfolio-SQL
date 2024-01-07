select * from mysql_projects.alexdata;
## Display SQL related  Videos
select * from alexdata where title_name like "%sql%";
## Display Excel related videos
select * from  alexdata where title_name like "%excel%";
## Display which videos got most views
select * from alexdata order by views desc;
## Likes to views ratio SQL
select * , (likes/views) as  likesratio  from alexdata order by  (likes/views) desc;
## Distinct months where videos are Posted
select distinct yearmonth from alexdata;
## Case Statement to See videos per Tool category
SELECT  case when title_name like '%ython%' then 'Python'
 when title_name like '%SQL%' then 'SQL'
 when title_name like '%ablea%' then 'Tableau'
 when title_name like '%xcel%' then 'Excel'
 when title_name like '%ower%' then 'Power BI'
else 'other' end as type,count(*)
 FROM alexdata
group by type;
## videos per month:
select   yearmonth,count(*)  from alexdata group by  yearmonth order by count(*) desc;
## videos with more than million views:
select yearmonth,sum(views)  from alexdata   group by yearmonth having sum(views )>1000000 order by yearmonth desc ;  
##  % Change in Number of views using lag function
select yearmonth,sum(views) as totalviews , lag(sum(views)) over (order by  yearmonth desc  )  from alexdata
 where   year=2020 and  month in (10,11)  group by yearmonth order by yearmonth ;

 ## (or)
/*with final as (
SELECT  yearmonth,sum(views) as totalviews
 FROM `sqlcsv.youtubeproject.Alexdata`
where year=2020 and month in (10,11)
group by yearmonth
order by yearmonth desc)
select yearmonth, totalviews,lag(totalviews) over (order by yearmonth desc)
from final*/


