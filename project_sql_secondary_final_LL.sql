CREATE TABLE t_lucia_luptakova_project_SQL_secondary_final as
SELECT
	e.country,
	e.year AS selected_years,
	e.gdp,
	e.gini,
	c.population
FROM
	economies e
JOIN 
	countries c 
	ON e.country = c.country 
	AND year BETWEEN 2006 AND 2018
	AND continent = 'Europe'
ORDER BY
	country,
	year;
