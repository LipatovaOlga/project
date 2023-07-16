---написать запрос суммы очков с группировкой и сортировкой по годам
select year_game, sum(points)
from statistic
group by year_game
order by year_game

---написать cte показывающее тоже самое
with cte as(
	select year_game, sum(points)
	from statistic
	group by year_game
	order by year_game
)
select * from cte;

---используя функцию LAG вывести кол-во очков по всем игрокам за текущий год и за предыдущий
with cte as(
	select year_game, sum(points) as points
	from statistic
	group by year_game
	order by year_game
)
select 	year_game, 
		points as current_year_points, 
		lag (points, 1) over (order by year_game) as previous_year_points
from cte;
