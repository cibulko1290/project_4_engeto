/*Task 1*/

select
	name_branch,	
	avg_salary,
	payroll_year
from 
	t_lucia_luptakova_project_SQL_primary_final
group by
	payroll_year,
	name_branch,
	avg_salary
order by 
	name_branch, 
	payroll_year;