/*Task 3*/

with average_percentage_growth as
(select
	a_year,
	items,
	average_prices,
	(lead(average_prices,1) over (partition by items order by a_year ) / average_prices -1) * 100 as percentage_growth
from
	t_lucia_luptakova_project_sql_primary_final tllpspf
group by
	a_year,
	items,
	average_prices 
order by
	items,
	a_year)
select
	items,
	round (avg(percentage_growth) ::numeric, 2) as average_YoY_percetage_increase
from
	average_percentage_growth
group by
	items;