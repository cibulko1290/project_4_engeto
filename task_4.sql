/*Task 4*/

with average_salary as 
(select	
	avg(avg_salary) as average_salary_all,
	payroll_year
from 
	t_lucia_luptakova_project_SQL_primary_final
group by
	payroll_year
order by  
	payroll_year),	
average_percentage_growth as
(select
	a_year,
	items,
	average_prices,
	(lead(average_prices,1) over (partition by items order by a_year ) / average_prices -1) * 100 as percentage_growth_price
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
case 
	when a_year between 2006 and 2017 then a_year + 1
	else Null
end as year_of_calculation,
	round (avg(percentage_growth_price) :: numeric, 2) as growth_all_categories_avg,
	round ((lead(average_salary_all ,1) over (order by a_year) / average_salary_all   -1) * 100 ::numeric, 2) as percentage_growth_salary
from
	average_percentage_growth apg
join average_salary asl
on asl.payroll_year = apg.a_year
group by 
	a_year,
	average_salary_all
having
	avg(percentage_growth_price) > 10	/*removing of clause having, the table with data will be shown*/
order by 
	a_year;