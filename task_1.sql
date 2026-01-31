/*Task 1*/

WITH base AS (
SELECT 
	name_branch,	
	avg_salary,
	payroll_year
FROM 
	t_lucia_luptakova_project_SQL_primary_final
WHERE 1 = 1
	AND payroll_year BETWEEN 2006 AND 2018
GROUP BY
	payroll_year,
	name_branch,
	avg_salary
)
SELECT 
	nex.payroll_year AS selected_year,
	nex.name_branch,
	nex.avg_salary AS avgerage_salary,
--	nex.avg_salary - curr.avg_salary AS diff_salary,
	CASE
		WHEN nex.avg_salary - curr.avg_salary > 0 THEN 'Increase'
		WHEN nex.avg_salary - curr.avg_salary < 0 then 'Decrease'
 		ELSE NULL 
 	END AS descr
 FROM 
 		base curr
 LEFT JOIN 
 	base nex
 	ON curr.name_branch = nex.name_branch
 	AND curr.payroll_year + 1 = nex.payroll_year
 GROUP by
 	nex.payroll_year,
 	nex.name_branch,
 	nex.avg_salary,
 	curr.avg_salary
HAVING nex.avg_salary - curr.avg_salary < 0;
