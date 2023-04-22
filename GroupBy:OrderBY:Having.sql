show databases;
use Mobilephones;
show tables;

select *from smartphones;



# SORTING (ORDER BY, LIMIT)
select model, screen_size
from smartphones
where brand_name = 'samsung'
order by screen_size desc
limit 5;


select model, num_rear_cameras, num_front_cameras, num_rear_cameras + num_front_cameras as 'total_cameras'
from smartphones
order by total_cameras desc
limit 5;


SELECT model, sqrt(resolution_width * resolution_width +  resolution_height* resolution_height)/screen_size as ppi
 FROM Mobilephones.smartphones
 order by ppi asc;
 
 # find the phone with 2nd largest battery
 SELECT model, battery_capacity
 FROM Mobilephones.smartphones
 order by battery_capacity asc
 limit 1,1;  
 
 # find the name and rating of the worst rated apple phone
 select *from smartphones;
 select model, rating
 from smartphones
 where brand_name= 'apple'
 order by rating asc
 limit 1;
 
 # sort phones alphabetically and then on the basis of price in asc order
 select *
 from smartphones
 order by brand_name asc, price asc;
 
 
 # sort phones alphabetically and then on the basis of rating in desc order
 select *
 from smartphones
 order by brand_name asc, rating desc;
 
 
 
 
 
 # GROUPING (GROUP BY)
 select brand_name, count(*) as num_phones, round(avg(price),2) as 'avg_price', max(rating) as 'max_rating',
 round(avg(screen_size),2) as 'avg_screen_size', round(avg(battery_capacity),2) as 'avg_battery_capacity'
 from smartphones
 group by brand_name
 order by num_phones desc;
 
 
 # Group smartphones by whether they have an NFC and get the average price and rating
 SELECT  has_nfc, round(avg(price),2) as 'avg_price', round(avg(rating),2) as 'avg_rating'
 FROM Mobilephones.smartphones
 group by has_nfc;
 
 
 # Group smartphones by extended memory available and get the average price
 select extended_memory_available, avg(price)
from Mobilephones.smartphones
group by extended_memory_available;


# Group smartphones by the brand and processor_brand and get the count of models and the average primary camera resolution(rear)
select brand_name, processor_brand, count(*) as 'num_phones', round(avg(primary_camera_rear),2) as 'avg_camera_resolution'
from Mobilephones.smartphones
group by  brand_name, processor_brand
order by brand_name asc, processor_brand asc;


# find the 5 most costly phone brands
select brand_name, round(avg(price),2) as 'avg_price'
from smartphones
group by brand_name
order by avg_price desc
limit 5; 


# which brand makes the smallest screen smartphones
select brand_name, avg(screen_size) as 'avg_screen_size'
from smartphones
group by brand_name
order by avg_screen_size asc
limit 1;


# avg price of 5g versus avg price of non-5g
select has_5g, avg(price) as 'avg_price'
from smartphones
group by has_5g;


# Group smartphones by the brand, and find the brand with the highest number of models that have both NFC and IR blaster
select brand_name, count(*) as 'max_models'
from smartphones
where has_nfc = 'True' and has_ir_blaster = 'True'
group by brand_name
order by max_models desc
limit 1;


# find all samsung 5g enabled smartphones and find out the avg price for nfc and non_nfc phones
select brand_name, has_nfc, avg(price) as 'avg_price'
from smartphones
where brand_name = 'samsung' and has_5g = 'True'
group by has_nfc;


# find the phone name, price of the costliest phone
select model, price
from smartphones
order by price desc
limit 1;







# HAVING CLAUSE (having)
# find the avg rating of smartphones brands which have morethan 20 phones
select brand_name, round(avg(rating),2) as 'avg_rating', count(*) as count
from smartphones
group by brand_name
having count > 20
order by avg_rating desc; 


# find the top 3 brands with highest average ram that have a refresh rate of 90Hz 
# and fast charging available and dont consider brands which have less than 10 phones
select brand_name,  count(*) as count, round(avg(ram_capacity),2) as 'avg_ram'
from smartphones
where refresh_rate > 90 and fast_charging_available = 1
group by brand_name
having count > 10
order by avg_ram desc
limit 3;


# find the average price of all the phone brands with avg rating > 70 and num phones > 10 among all 5g enabled phones
select brand_name, count(*) as count,  avg(price), round(avg(rating),2) as 'avg_rating'
from smartphones
where has_5g = 'True'
group by brand_name
having avg_rating > 70 and count > 10;





 
 