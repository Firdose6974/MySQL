use Task35;



# 1)Display the names of athletes who won a gold medal in the 2008 Olympics and whose height is greater than the
# average height of all athletes in the 2008 Olympics.
select *
from olympics
where (year = 2008) and (medal = 'Gold') and height > (select round(avg(height),2)
														from olympics
														where year = 2008);
                                                        

# 2) Display the names of athletes who won a medal in the sport of basketball in the 2016 Olympics and whose weight
# is less than the average weight of all athletes who won a medal in the 2016 Olympics.
select name
from olympics
where (sport = 'basketball') and (year = 2016) and medal is not null and weight < (select avg(weight)
															from olympics
															where (year = 2016) and (medal is not null));  
                                                            
											
# 3) Display the names of all athletes who have won a medal in the sport of swimming in both the 2008 and 2016 Olympics.
select distinct(name)
from olympics
where name in (select name
				from olympics
				where (sport = 'swimming') and year in (2008, 2016) and (medal in ('gold', 'silver', 'bronze')));
                
                
# 4) Display the names of all countries that have won more than 50 medals in a single year.
select country,  year, count(*)
from olympics
where (medal is not null) and (country is not null)
group by country, year
having count(*) > 5
order by year, country;


# 5) Display the names of all athletes who have won medals in more than one sport in the same year.
select distinct(name)
from olympics
where id in (select distinct(id)
				from olympics
				where (medal in('gold', 'silver', 'bronze'))
				group by id, sport, year
				having count(medal) > 1);
                
                
# 6) What is the average weight difference between male and female athletes in the Olympics who have won a medal in the same event?
with result as (select *
				from olympics 
				where medal in ('gold', 'silver', 'bronze'))
select avg(a.weight - b.weight)
from result a
join result b
on a.event = b.event
and a.sex != b.sex;



# 7) How many patients have claimed more than the average claim amount for patients who are smokers and have at least one child,
# and belong to the southeast region?
select count(patientID)
from ins_data
where claim > (select round(avg(claim),2)
				from ins_data
				where (smoker='yes') and (children >= 1) and (region = 'southeast'));
                
                
# 8) How many patients have claimed more than the average claim amount for patients who are not smokers and have a BMI greater than
# the average BMI for patients who have at least one child?
select count(PatientID)
from ins_data
where claim > (select avg(claim)
				from ins_data
				where (smoker= 'no') and bmi > (select round(avg(bmi),2)
												from ins_data
												where children >=1));



# 9) How many patients have claimed more than the average claim amount for patients who have a BMI greater than the average BMI 
# for patients who are diabetic, have at least one child, and are from the southwest region?
select count(patientID)
from ins_data
where claim >(select avg(claim)
				from ins_data
				where bmi > (select avg(bmi)
							from ins_data
							where diabetic='yes' and children>=1 and region = 'southwest'));
                            

# 10) What is the difference in the average claim amount between patients who are smokers and patients who are non-smokers,
# and have the same BMI and number of children?
SELECT AVG(A.claim - B.claim) FROM ins_data A
JOIN ins_data B
ON A.bmi = B.bmi
AND A.smoker != B.smoker 
AND A.children = B.children;



			





 
				

									