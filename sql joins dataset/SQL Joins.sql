show databases;
use sql_joins;
show tables;


select *from group_s;
select *from users1;


# CROSS - JOIN
select *
from users1 as t1
cross join group_s as t2; 



# INNER - JOIN
select *from users1;
select *from membership;

select *
from membership as t1
inner join users1 as t2
on t1.user_id = t2.user_id;



# LEFT-JOIN
select *
from membership as t1
left join users1 as t2
on t1.user_id = t2.user_id;


# RIGHT-JOIN
select *
from membership as t1
right join users1 as t2
on t1.user_id = t2.user_id;


# UNION
select *from person1
union
select *from person2;

# UNION all
select *from person1
union all
select *from person2;

# FULL-OUTER JOIN = LEFT-JOIN UNION RIGHT JOIN
select *
from membership t1
left join users1 t2
on t1.user_id = t2.user_id
union
select *
from membership t1
right join users1 t2
on t1.user_id = t2.user_id; 



# SELF-JOIN - (Same table treated as 2 different tables) to get the information from same table we use self join
select * 
from users1 t1
join users1 t2
on t1.emergency_contact = t2.user_id;




# Joining more than one columns
select *from students;
select *from class;

select *
from students t1
join class t2
on t1.class_id = t2.class_id and t1.enrollment_year = t2.class_year;



# Joining more than 2 tables
select *from users;
select *from orders;
select *from order_details;
select *from category;

select *
from order_details t1
join orders t2
on t1.order_id = t2.order_id
join users t3
on t2.user_id = t3.user_id;


# filtering columns
select t1.order_id, t1.amount, t1.profit, t3.name
from order_details t1
join orders t2
on t1.order_id = t2.order_id
join users t3
on t2.user_id = t3.user_id;

# 1) Find order_id, name and city by joining users and orders
select t2.order_id, t1.name, t1.city
from users t1
join orders t2
on t1.user_id = t2.user_id;

# 2) find order_id, product_category
select *from category;
select *from order_details;

select t1.category, t2.order_id
from category t1
join order_details t2
on t1.category_id = t2.category_id;



# Filtering rows
select *from orders;
select *from users;


# 1) Find all the orders placed in pune;
select *
from users t1
join orders t2
on t1.user_id = t2.user_id
where t1.city = 'pune';


# 2) Find all orders under chair category
select *from order_details;
select *from category;

select *
from order_details t1
join category t2
on t1.category_id = t2.category_id
where vertical = 'Chairs';





# Practice questions

# 1) Find all profitable orders
select  t1.order_id, sum(t2.profit) as profit
from orders t1
join order_details t2
on t1.order_id = t2.order_id
group by t1.order_id
having profit > 0;

# 2) Find all customer who has placed max number of orders
select name, count(*) as 'max_orders'
from users t1
join orders t2
on t1.user_id = t2.user_id
group by name
order by max_orders desc
limit 1;

# which is the most profitable category
select vertical, sum(profit) as 'max_profit_category'
from category t1
inner join order_details t2
on t1.category_id = t2.category_id
group by t1.vertical
order by max_profit_category desc
limit 1;


# which is the most profitable state
select state, sum(profit) as 'most_profitable_state'
from users t1
join orders t2
on t1.user_id = t2.user_id
join order_details t3
on t2.order_id = t3.order_id
group by state
order by most_profitable_state desc
limit 1;


# find all categories with profit greater than 3000
select *from category;
select *from order_details;

select vertical, sum(profit) as 'max_profit'
from category t1
join order_details t2
on t1.category_id = t2.category_id
group by t1.vertical
having max_profit > 3000;



