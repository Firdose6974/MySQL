use sub_queries;
show tables;
select *from restaurants;
select *
from movies;



# INDEPENDENT SUB-QUERY - SCALAR SUb-QUERY(single value)

# 1) find the movie with highest profit
select *
from movies
where (gross-budget) = (select max(gross-budget) from movies);

#using order by
select *
from movies
order by (gross-budget) desc
limit 1;

# 2) Find how many movies have a rating > the avg of all the movie ratings (Find the count of above average movies)
select count(*)
from movies
where score > (select avg(score)
			from movies);
            
            
# 3) find the highest rated movie of 2000
select * from movies;

select *
from movies
where score = (select max(score) as 'highest_rated_movie_in_2018'
				from movies 
				where year = 1980);
                
	
# Find the highest rated movie among all movies whose votes are > the dataset avg votes
select *
from movies;

select *
from movies 
where score = (select max(score) from movies
				where votes > (select avg(votes)
				from movies));
                
                
                
                
			
# ROW SUBQUERY - ROW SUBQUERY(One col mutilple rows)

# 1) Find all users who never ordered 
select *
from users
where user_id not in (select distinct(user_id)
						from orders);
    
    
# 2) find all the movies made by top 3 directors (interms of total gross income)
select *
from movies
where director in (select director
					from movies
					group by director
					order by sum(gross) desc
					limit 3);  # use CT's here
  
# 3) find all movies of all those actors whose filmgraphy's avg rarting > 8(take 25000 votes as cutoff)
select *
from movies
where star in (select star
				from movies
				where votes > 25000
				group by star
				having avg(score) > 8);
                
select *
from movie
where (year, gross-budget) in (select year, max(gross-budget)
									from movie
									group by year);
  
  
# 2) find the highest rated movie of each genre votes cutoff of 25000
select *
from movie
where (genre, score) in (select genre, max(score)
						from movie
						where votes > 25000
						group by genre);
						;
									
# 3) find the highest grossing movie of top 5 actor/director combo in terms of total gross income
with top_duos as(select star, director,  max(gross) as 'max_gross'
						from movie
						group by star, director
						order by sum(gross) desc
						limit 5) 
select *
from movie 
where (star, director, gross) in (select * from top_duos);


# Correlated SubQuery

# 1) find all the movies that hace a rating higher than the average rating of movies  in the same genre.[animation]
select *
from movies m1
where score > (select  avg(score)
				from movies m2
				where m2.genre = m1.genre)
order by genre;


# 2) find the favourite food of the each customer
with fav_food as (select t2.user_id, name, f_name, count(*) as 'frequency'
					from users t1
					join orders t2 on t1.user_id = t2.user_id
					join order_details t3 on t2.order_id = t3.order_id
					join food t4 on t3.f_id = t4.f_id
					group by t2.user_id, t3.f_id
)
select *
from fav_food f1
where frequency = (select max(frequency)
					from fav_food f2
                    where f2.user_id = f1.user_id);




# USE OF SUB-QUERIES WITH SELECT 
# 1) get the percentage of votes for each movie compared to the total number of votes
select name, (votes / (select sum(votes) from movies))*100
from movies;

# find all movies name, genre, score, avg_score
select name, genre, score, (select avg(score) from movies m2 where m2.genre = m1.genre) as 'avg_score_genre'
 from movies m1;
 


# USAGE OF SUB-QURIES WITH FROM
# 1) display average rating of all the restaurants
select r_name, avg_rating
from (select r_id, avg(restaurant_rating) as 'avg_rating'
		from orders
		group by r_id) t1
join restaurants t2
on t1.r_id = t2.r_id;


# USAGE OF SUB-QURIES WITH HAVING
# 1) find genres having avg sore > avg score of all the movies


select genre, round(avg(score),2) as 'avg_score' from movies
group by genre
having avg_score > (select avg(score) from movies);


# creating loyal users table by populating it with customers who ordered more than 3 tmes
insert into loyal_users(user_id, name)
select t1.user_id, t1.name
from users t1
join orders t2
on t1.user_id = t2.user_id
group by user_id
having count(*) > 3 ;

select *
from loyal_users;


select t1.user_id, name, sum(amount)*0.1
from users t1
join orders t2
on t1.user_id = t2.user_id
group by user_id;

select user_id from users 
where user_id not in(select distinct(user_id)
						from orders);
update loyal_users
set money = (select sum(amount) * 0.1
			from orders
			where orders.user_id = loyal_users.user_id);





