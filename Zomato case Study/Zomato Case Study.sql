create database zomato;
use zomato;
show tables;

# 1) count number of rows
select count(*) from orders;



-- 2) 2) return n random records
select *
from users
order by rand()
limit 5;

-- 3) find null values
select *from orders
where restaurant_rating = '';
# To replace null values with zero
-- update orders set restaurant_rating=0 where restaurant_rating ='';



-- 4) find number of orders placed by each customers
select  t2.name, count(*) as  'num_orders' 
from orders t1
join  users t2
on t1.user_id = t2.user_id
group by t2.user_id;



-- 5) find restaurants with most number of menu items
SELECT t1.r_name, COUNT(*) AS 'Num_items'
FROM restaurants t1
JOIN menu t2
ON t1.r_id = t2.r_id
GROUP BY t1.r_id
order by num_items desc
limit 1;



-- 6) find number of votes and average rating for all the restaurants
select r_name, count(*) as 'num_votes', round(avg(restaurant_rating),2) as 'avg_rating'
from restaurants t1
join orders t2
on t1.r_id = t2.r_id
group by t1.r_id
order by avg_rating desc;



-- 7) find the food that is being sold at most number of restaurants
select f_name, count(*) as count
from menu t1
join food t2
on t1.f_id = t2.f_id
group by t2.f_id
order by count desc;



-- 8) find restaurants with max revenue in a given month
select r_name, monthname(date) as 'month_name', sum(amount) as 'max_revenue'
from restaurants t1
join orders t2
on t1.r_id = t2.r_id
where monthname(date) = 'may'
group by t2.r_id
order by max_revenue desc
limit 1;



-- month by month revenue of a particular restuarant
select monthname(date) as 'month_name', sum(amount) as 'Revenue'
from restaurants t1
join orders t2
on t1.r_id = t2.r_id
where r_name = 'kfc'
group by month_name;



# 9) find restaurants with sales > x
select r_name, sum(amount) as 'sales'
from restaurants t1
join orders t2
on t1.r_id = t2.r_id
group by t2.r_id
having sales>1500;



# 10) find customers who had never ordered
select user_id, name from users
except
select t1.user_id, name from user_id t1
join users t2
on t1.user_id = t2.user_id;


-- 11) show order details of particular customer in a given date range
select t3.order_id, name, date, f_name
from orders t1
join users t2
on t1.user_id = t2.user_id
join order_details t3
on t1.order_id = t3.order_id
join food t4
on t3.f_id = t4.f_id
where (t1.user_id = 5) and (date between '2022-06-15' and '2022-07-15')
order by date asc;



-- 12) customer favourite food
select t1.user_id, name, t4.f_id, f_name, count(*) as 'num_times_ordered'
from users t1
join orders t2
on t1.user_id = t2.user_id
join order_details t3
on t2.order_id = t3.order_id
join food t4
on t3.f_id = t4.f_id
where t1.user_id = '4'
group by t4.f_name
order by num_times_ordered desc
limit 1;



-- 13) find most costly restaurant (avg price/dish)
select r_name, round(avg(price),2) as 'avg_price'
from restaurants t1
join menu t2
on t1.r_id = t2.r_id
group by t1.r_id
order by avg_price desc
limit 1;



-- 14) find delivery partner compensation using the formule (deliveries * 100 + 1000*avg_rating)
select t1.partner_id, t1.partner_name, round(((count(*)* 100) +  (1000*avg(delivery_rating))),2) as 'salary'
from delivery_partner t1
join orders t2
on t1.partner_id = t2.partner_id
group by t1.partner_id
order by salary desc;


-- 15) month by month revenue of a particular restuarant
select monthname(date) as 'month_name', sum(amount) as 'Revenue'
from restaurants t1
join orders t2
on t1.r_id = t2.r_id
where r_name = 'kfc'
group by month_name;



-- 16) find correlatin between delivery time and total_rating






-- 18) find all the veg restaurants
select r_name, type
from menu t1
join food t2
on t1.f_id = t2.f_id
join restaurants t3
on t1.r_id = t3.r_id
group by t1.r_id
having min(type) = 'veg' and max(type) = 'veg';



-- 19) find min and max order value for all the customers
select t1.user_id, name, min(amount) as 'min_order', max(amount) as 'max_order'
from users t1
join orders t2
on t1.user_id = t2.user_id
group by t1.user_id;



