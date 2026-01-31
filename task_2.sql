/*Task 2*/

SELECT  
	items,
	payroll_year,
	round (avg(avg_salary):: numeric, 2) AS average_salary,
	average_prices,
	round (avg(avg_salary) / (2 * average_prices) :: numeric, 0) AS quantity_of_item
FROM 
	t_lucia_luptakova_project_SQL_primary_final
WHERE 
	items IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
	AND payroll_year in (2006, 2018)
GROUP BY 
	payroll_year,
	items,
	average_prices
ORDER BY 
	payroll_year;
