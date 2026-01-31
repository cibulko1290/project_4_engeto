CREATE TABLE t_lucia_luptakova_project_SQL_primary_final AS (
WITH t_primary_1 as ( 
SELECT
	cp.industry_branch_code,
	cpib.name AS name_branch,
	cp.payroll_year,
	round(avg(cp.value):: numeric, 2) AS avg_salary
FROM
	czechia_payroll cp
JOIN 
	czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958
GROUP BY 
	cp.industry_branch_code,
	cpib.name,
	cp.payroll_year
),
t_primary_2 AS (
SELECT
	name AS items,
	date_part ('year', date_from) AS a_year,
	round (avg(value):: numeric, 2) AS average_prices
FROM 
	czechia_price cp
JOIN 
	czechia_price_category cpc
	ON cp.category_code = cpc.code
	AND
	region_code IS NULL
GROUP BY 
	a_year,
	items
ORDER BY 
	items,
	a_year
),
t_primary_3 AS (
SELECT
	year AS b_year,
	gdp
FROM 
	economies
WHERE 
	country = 'Czech Republic'
	AND year BETWEEN 2006 AND 2018
)
SELECT 
	tp.*,
	tpp.*,
	tp3.gdp
FROM
	t_primary_1 tp
LEFT JOIN 
	t_primary_2 tpp
	ON tpp.a_year = tp.payroll_year
LEFT JOIN 
	t_primary_3 tp3
	ON tp3.b_year = tp. payroll_year
);
