/*Task 3*/

WITH average_percentage_growth AS 
(SELECT 
	a_year,
	items,
	average_prices,
	(lead(average_prices, 1) OVER (PARTITION BY items ORDER BY a_year ) / average_prices - 1) * 100 AS percentage_growth
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
	items,
	round (avg(percentage_growth) ::numeric, 2) AS average_YoY_percetage_increase
FROM 
	average_percentage_growth
GROUP BY 
	items;
