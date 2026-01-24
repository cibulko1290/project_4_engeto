create table t_lucia_luptakova_project_SQL_secondary_final as
select
	e.country,
	e.year as selected_years,
	e.gdp,
	e. gini,
	c.population
from  
	economies e
join 
	countries c 
on 
	e.country = c.country 
and
	year between 2006 and 2018
and 
	continent = 'Europe'
order by
	country,
	year;