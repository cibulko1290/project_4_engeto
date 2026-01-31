/*Task 4*/

WITH average_salary AS  
(SELECT	
	avg(avg_salary) AS average_salary_all,
	payroll_year
FROM
	t_lucia_luptakova_project_SQL_primary_final
GROUP BY
	payroll_year
ORDER BY  
	payroll_year),	
average_percentage_growth AS
(SELECT
	a_year,
	items,
	average_prices,
	(lead(average_prices,1) OVER (PARTITION BY items ORDER BY a_year ) / average_prices - 1) * 100 AS percentage_growth_price
FROM
	t_lucia_luptakova_project_sql_primary_final tllpspf
GROUP BY 
	a_year,
	items,
	average_prices 
ORDER BY
	items,
	a_year)
SELECT 
CASE 
	WHEN a_year BETWEEN 2006 AND 2017 THEN a_year + 1
	ELSE NULL 
END AS year_of_calculation,
	round (avg(percentage_growth_price) :: numeric, 2) AS growth_all_categories_avg,
	round ((lead(average_salary_all ,1) OVER (ORDER BY a_year) / average_salary_all - 1) * 100 ::numeric, 2) AS percentage_growth_salary
FROM
	average_percentage_growth apg
JOIN average_salary asl
	ON asl.payroll_year = apg.a_year
GROUP BY  
	a_year,
	average_salary_all
HAVING
	avg(percentage_growth_price) > 10	/*removing of clause having, the table with data will be shown*/
ORDER BY
	a_year;
