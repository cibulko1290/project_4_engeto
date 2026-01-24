/*Task 2*/

select 
	payroll_year,
	round (avg(avg_salary):: numeric, 2) as average_salary,
	2*sum(average_prices)/count(average_prices ) as sum_bread_milk,
	round (avg(avg_salary) * count(average_prices) / ( 2 * sum(average_prices)) :: numeric, 0) as quantity_of_items
from 
	t_lucia_luptakova_project_SQL_primary_final
where 
	items in ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
group by 
	payroll_year
order by
	payroll_year;