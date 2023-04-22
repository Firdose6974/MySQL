use zomato;
show tables;
use ipl;
show tables;




# uses of window functions
# 1) RANKING
select *
from (select battingteam, batter, sum(batsman_run) as 'total_runs',
dense_rank() over(partition by battingteam order by sum(batsman_run) desc) as 'rank_within_team'
from cricket
GROUP BY BATTINGTEAM, batter) t
where t.rank_within_team < 6
order by t.battingteam, t.rank_within_team;


# 2) cummulative sum
select *
from (select concat("Match-", cast(row_number() over(order by id) as char)) as 'match_no', sum(batsman_run) as 'runs_scored',
sum(sum(batsman_run)) over(rows between unbounded preceding and current row) as 'career_runs'
from cricket
where batter = 'V kohli'
group by id) t
where match_no = 'match-50' OR match_no = 'Match-100' OR match_no = 'Match-200';

