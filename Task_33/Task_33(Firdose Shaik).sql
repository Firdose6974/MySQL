use Task33;
show tables;

select *from sleep_efficiency;

# 1) Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5.
-- select ID,  avg(sleep_duration) as 'avg_sleep_duration'
-- from sleep_efficiency
-- where gender = 'male'
-- group by ID
-- having avg_sleep_duration >=7.5
-- order by avg_sleep_duration desc 
-- limit 15;

select * from sleep_efficiency;
select avg(sleep_duration)
from sleep_efficiency
where Gender='Male' and sleep_duration >=7.5
order by sleep_duration desc
limit 15; 



# 2) Show avg deep sleep time for both gender. Round result at 2 decimal places.
# Note: sleep time and deep sleep percentage will give you, deep sleep time.
select gender, round(avg(sleep_duration * (Deep_sleep_percentage/100)),2) as 'avg_deep_sleep'
from sleep_efficiency
group by gender;


# 3) Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45.
# Display age, light sleep percentage and deep sleep percentage columns only.
select age, light_sleep_percentage, deep_sleep_percentage
from sleep_efficiency
where (deep_sleep_percentage between 25 and 45)
order by light_sleep_percentage asc
limit 10, 20;


# 4) Group by on exercise frequency and smoking status and show average deep sleep time, average light sleep time and avg rem sleep time.
# Note the differences in deep sleep time for smoking and non smoking status
select Exercise_frequency, smoking_status, round(avg(sleep_duration * (Deep_sleep_percentage/100)),2) as 'avg_deep_sleep_time',
round(avg(sleep_duration * (Light_sleep_percentage/100)),2) as 'avg_light_sleep_time',
round(avg(sleep_duration * (REM_sleep_percentage/100)),2) as 'avg_rem_sleep_time'
from sleep_efficiency
group by Exercise_frequency, Smoking_status
order by avg(sleep_duration * (Deep_sleep_percentage/100)) asc;
#from above query it seems to be the person with smoking status (yes->has less deep sleep time) and smoking status (No-> more deep sleep time)


# 5) Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for people
#  who do exercise atleast 3 days a week. Show result in descending order awekenings
select Awakenings, avg(caffeine_consumption) as 'avg_caffeine',
avg(sleep_duration * (deep_sleep_percentage/100)) as 'avg_deep_sleep_time', avg(alcohol_consumption) as 'avg_alcohol'
from sleep_efficiency
where exercise_frequency >= 3
group by Awakenings
order by Awakenings desc;


# 6) Display those power stations which have average 'Monitored Cap.(MW)' (display the values) between 1000 and 2000
# and the number of occurance of the power stations (also display these values) are greater than 200. Also sort the result in ascending order.
select power_Station, count(*) as 'occurance', avg(Monitored_Cap) as 'avg_monitored_cap'
from powergeneration
group by power_Station
having (avg_monitored_cap between 1000 and 2000)and  occurance > 200
order by avg_monitored_cap asc;



# 7) Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 and type is 'Public In-State'.
# Also the number of occurance should be between 6 to 10. Display the average value upto 2 decimal places, state names and the occurance
# of the states.
select state, round(avg(value),2) as 'avg_value', count(*) as 'occurance'
from us_undergrad
where (year in('2013', '2017', '2021')) and (type = 'Public In-State')
group by state
having (occurance between 6 and 10)
order by avg_value asc
limit 10;


# 8) Best state in terms of low education cost (Tution Fees) in 'Public' type university.
select state, avg(value) as 'avg_value'
from us_undergrad
where (Type like '%Public%') and Expense like '%Tuition%'
group by state
order by avg_value asc
limit 1;


# 9) 2nd Costliest state for Private education in year 2021. Consider, Tution and Room fee both.
select state, avg(value) as 'avg_cost'
from us_undergrad
where (type like  '%Private%') and (year ='2021')
group by state
order by avg_cost desc
limit 1,1;


# 10) Display total and average values of Discount_offered for all the combinations of 'Mode_of_Shipment' (display this feature)
# and 'Warehouse_block' (display this feature also) for all male ('M') and 'High' Product_importance.
# Also sort the values in descending order of Mode_of_Shipment and ascending order of Warehouse_block.
select Mode_of_Shipment, Warehouse_block, sum(Discount_offered) as 'total_discount', avg(Discount_offered) as 'avg_discount'
from ecommerce
where (Product_importance = 'high') and (Gender = 'M')
group by Mode_of_Shipment, Warehouse_block
order by Mode_of_Shipment desc, warehouse_block asc;



