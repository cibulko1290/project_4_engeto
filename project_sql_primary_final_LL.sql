create table t_primary_1 as 
select
	cp.industry_branch_code,
	cpib.name as name_branch,
	cp.payroll_year,
	round(avg(cp.value):: numeric, 2) as avg_salary
from
	czechia_payroll cp
join 
	czechia_payroll_industry_branch cpib
on 
	cp.industry_branch_code = cpib.code
where 
	value_type_code = 5958
group by 
	cp.industry_branch_code,
	cpib.name,
	cp.payroll_year;


create table t_primary_2 as 
select
	name as items,
	date_part ('year', date_from) as a_year,
	round (avg(value):: numeric, 2) as average_prices
from 
	czechia_price cp
join 
	czechia_price_category cpc
on 
	cp.category_code = cpc.code
and
	region_code is null
group by 
	a_year,
	items
order by 
	items,
	a_year;

create table t_primary_3 as
select
	year as b_year,	/*I do not like the name of collumn as name of function. I change it in my table for further using.*/
	gdp
from 
	economies
where 
	country = 'Czech Republic'
and
	year between 2006 and 2018;
	

create table t_lucia_luptakova_project_SQL_primary_final as
select 
	tp.*,
	tpp.*,
	tp3.gdp
from
	t_primary_1 tp
join 
	t_primary_2 tpp
on 
	tpp.a_year = tp.payroll_year
join 
	t_primary_3 tp3
on 
	tp3.b_year = tp. payroll_year;
