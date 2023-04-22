# WINDOW FUNCTIONS (similar to group by clause, but returns all the rows whereas in groupby returns the grouped results)

use zomato;
show tables;


CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);
select *
from marks;

select avg(marks)
from marks;

# window functions
select *, avg(marks) over() 
from marks;

select *, avg(marks) over(partition by branch)
from marks;

select *,
avg(marks) over(),
min(marks) over(),
max(marks) over(),
min(marks) over(partition by branch),
max(marks) over(partition by branch)
from marks;



# 1) find all the students who have marks higher than the avg marks of their respective branch
select *
from (select *, 
avg(marks) over(partition by branch) as 'branch_avg'
from marks) t
where t.marks > branch_avg ;





# IMPORTANT WINDOW FUNCTIONS
 -- RANK
 -- DENSE_RANK
 -- ROW_NUMBER
 
 select *,
 RANK() over(partition by branch order by marks desc)
 from marks;
 
 select *,
 dense_rank() over(partition by branch order by marks desc)
 from marks;
 
 
 # RANK and DENSE RANK
 select *,
 rank() over(partition by branch order by marks desc),
 dense_rank() over(partition by branch order by marks desc)
 from marks;
 
 # ROW NUMBER - assign row number
 select *,
 row_number() over(partition by branch)
 from marks;

select *,
row_number() over(partition by branch order by marks desc)
from marks;
 
 select *,
 concat(branch, '-', row_number() over(partition by branch))
 from marks;
 
 select *,
 concat(branch, '-', row_number() over(partition by branch order by marks desc)) as 'branch_number',
 dense_rank() over(partition by branch order by marks desc)
 from marks;
 
 
 
# find top 2 users in a month from zomato 
select *
from (select user_id, monthname(date) as 'month', sum(amount) as 'total',
		rank() over(partition by monthname(date) order by sum(amount) desc) as 'month_rank'
		from orders
		group by monthname(date), user_id
		order by month(date)) as t
        where t.month_rank < 3
        order by month desc, month_rank asc;
 

-- select *
-- from(select user_id, monthname(date), sum(amount) as 'total',
-- 		rank() over(partition by monthname(date) order by sum(amount) desc) as 'month_rank'
-- 		from orders
-- 		group by user_id, monthname(date)
-- 		order by monthname(date) desc) t
-- where t.month_rank < 3;



# FIRST_VALUE / LAST_VALUE / NTH_VALUE

# lets take the topper in the whole campus
select *, 
first_value(name) over(order by marks desc)
from marks;


# FRAMES

# lets take the lowest guy in the whole campus
select *,
last_value(name) over(partition by branch order by marks desc
			rows between unbounded preceding and unbounded following)
from marks;

select *,
last_value(name) over(order by marks desc
					rows between unbounded preceding and unbounded following)
from marks;

select *,
first_value(name) over(partition by branch order by marks desc
			rows between unbounded preceding and unbounded following)
from marks;

-- select *,
-- first_value(name) over(partition by branch order by marks desc
-- rows between unbounded preceding and unbounded following)
-- from marks;
                

select *,
nth_value(name, 3) over(partition by branch order by marks desc
						rows between unbounded preceding and unbounded following)
from marks;


-- select *,
-- dense_rank() over(partition by branch order by marks desc)
-- from marks;

# 1) find branch toppers
select name, branch, marks
from (select *,
		first_value(name) over(partition by branch order by marks desc) as 'topper_name',
		first_value(marks) over(partition by branch order by marks desc) as 'topper_marks'
		from marks) t
where t.name = t.topper_name and t.marks = t.topper_marks;

-- select distinct(name), branch, marks
-- from (
-- select *,
-- first_value(name) over(partition by branch order by marks desc) as 'branch_topper',
-- first_value(marks) over(partition by branch order by marks desc) as 'topper_marks'
-- from marks) t
-- where t.name = branch_topper and t.marks = topper_marks;

# 2) find last one in the branch
select name, branch, marks
from (select *,
		last_value(name) over(partition by branch order by marks desc rows between unbounded preceding and unbounded following) as 'last_name',
		last_value(marks) over(partition by branch order by marks desc rows between unbounded preceding and unbounded following) as 'last_marks'
		from marks) t
where t.name = t.last_name and t.marks = t.last_marks;

-- select distinct(name), branch, marks
-- from(select *,
-- 		last_value(name) over(partition by branch order by marks desc rows between unbounded preceding and unbounded following) as 'last_name',
-- 		last_value(marks) over(partition by branch order by marks desc rows between unbounded preceding and unbounded following) as 'least_marks'
-- 		from marks) t
-- where t.name = t.last_name and t.marks  = t.least_marks;



# LEAD & LAG FUNCTION
select *,
lag(marks) over(partition by branch order by student_id),
lead(marks) over(partition by branch order by student_id)
from marks;

select *,
lag(marks) over(partition by branch order by student_id)
from marks;


# Find month on month revenue growth of zomato (using lag)
select monthname(date) as 'month' , sum(amount) as 'total',
round(((sum(amount) - lag(sum(amount)) over(order by month(date))) / lag(sum(amount)) over(order by month(date)))*100, 2) as '%growth'
from orders
group by month(date);

-- select monthname(date) as 'month', sum(amount) as 'total',
-- ((sum(amount) - lag(sum(amount)) over(order by month(date))) / lag(sum(amount)) over(order by month(date))) *100 as '%growth'
-- from orders
-- group by month(date);