# Task for SQL DML session
show databases;
use insurance;
show tables;


select *
from ins_data;


# 1) Show records of 'male' patient from 'southwest' region.
select *
from insurance.ins_data
where gender = 'male' and region = 'southwest';


# 2) Show all records having bmi in range 30 to 45 both inclusive.
select *
from insurance.ins_data
where (bmi between 30 and 45);

# 3) Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
select min(bloodpressure) as MinBP, max(bloodpressure) as MaxBP
from insurance.ins_data
where diabetic = 'yes' and smoker = 'yes';


# 4) Find no of unique patients who are not from southwest region.
select count(distinct(patientID))
from insurance.ins_data
where region not in ('southwest');

# 5) Total claim amount from male smoker.
select sum(claim)
from insurance.ins_data
where gender = 'male' and smoker = 'yes';

# 6) Select all records of south region.
select *
from insurance.ins_data
where region in('southeast', 'southwest');

 # (or)
 
select *
from insurance.ins_data
where region like '%south%';


# 7) No of patient having normal blood pressure. Normal range[90-120]
select count(*)
from insurance.ins_data
where (bloodpressure between 90 and 120);


# 8) No of pateint belo 17 years of age having normal blood pressure as per below formula -
# BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)
# Note: Formula taken just for practice, don't take in real sense.
select count(*)
from insurance.ins_data
where (age < 17) and (bloodpressure between 80+(age * 2) and 100+(age*2) );


# 9) What is the average claim amount for non-smoking female patients who are diabetic?
select avg(claim)
from insurance.ins_data
where smoker = 'no' and gender = 'female' and diabetic='yes';


# 10) Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
update insurance.ins_data
set claim = '5000'
where patientID = '1234';


# 11) Write a SQL query to delete all records for patients who are smokers and have no children.
delete from insurance.ins_data
where smoker = 'yes' and children = '0';







