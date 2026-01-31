# SQL project from Engeto s.r.o. 

## Introduction 

The requirement of this project is to demonstrate the knowledge gained in the SQL course.
There are defined tables: czechia_payroll, czechia_payroll_calculation, czechia_payroll_industry_branch, czechia_payroll_unit, czechia_payroll_value_type, czechia_price, czechia_price_category ect. downloaded by Engeto from data.gov.cz
Five tasks are placed on the data from mentioned tables. Not all of the data are relevant. Some of the tables  are used to clarify the units of the main data. Therefore, the data set must be selected and processed before further analysis. 
Here is the list of the tasks:
1.	Do salaries increase over time across all sectors, or do they decline in some?
2.	How many litres of milk and kilograms of bread can be purchased in the first and last comparable periods in the available price and salary data?
3.	The price of which food category is increasing the slowest (i.e., has the lowest annual percentage increase)?
4.	Is there a year in which the annual increase in food price was significantly higher than salary growth (by more than 10%)?
5.	Does the acceleration in GDP growth lead to statistically significant increases in salaries and food prices, either contemporaneously or in the subsequent period? To what extent does GDP growth influence the changes in salaries and food prices? Specifically, does stronger GDP growth in a given year translate into higher salary growth and food prices inflation either in the same year or with a one-year lag?
One more important issue: salary data and data of food prices must be unified on the same comparable period. 

## Metodology 

It was recommended to process data in two main tables. The first one contains economic data about the salaries, prices and GDP in the Czech Republic. The second one contains data such as GDP, Gini coefficient and population of all European countries in the same comparable period as in the first table. 
In particular, the table czechia_payroll contains data from 2000 to 2021. Meanwhile,  the data in the table  czechia_price are from 2006 to 2018. In the end: the period, which is used in both tables, is between 2006 and 2018. Even the data sets for European countries are longer.
Three subordinate tables were used for creating the table *t_lucia_luptakova_project_SQL_primary_final*. The first one is built up using the data in Czechia_payroll, the second one in Czechia_price and the third uses data from table economies. All of them were unified by using **left join** to keep the instruction for same comparable period.

Metodology of tasks:
1.	This is the simplest task. The table uses data of average salaries from all the sectors between 2006 and 2018. The order is set by name of the sectors and the payroll year.    
2.	In this task, a calculation has been made of using the number of loaves of bread and litres of milk. In the calculation, the units of bread and milk were verified. First, the average salary in the given year was calculated for all sectors. Subsequently, the quantity of litres of milk and loaves of bread were calculated. The salary has been devided evenly (by half) to show how many items can by purchased respectively. Years and items are specified in the clause **Where**.
3.	In this task, a simplification has been adopted for the calculation of the annual price growth, as the average value over the given period of each individual items. The calculation was initiated by the **CTE**, in which the annual price growth has been calculated using a **windows function**. In the main part of script, the average annual price growth has been calculated.
4.	The task has been solved using the expanded **CTEs**. In the first subselect, the average salaries were calculated, in the second annual price growth. In the main part of the script, the annual salary growth is then further calculated. The **windows function** is used again. For clarity of the results, the clause **Case** is added, in which the corresponding year is assigned to the outcome. (The original column with the years could be left out, because the windows function caused a  upward shift by one row. The calculation was correct, but it did not correspond to the given year; instead, it was off by one year. This is why the Case has been adopted.) In the task, an important clause **Having** is included, that excludes all the data where the annual price growth is below 10%.
5.	This task derives from the previous one. Many rows of the script are shared. Clause **Having** is omitted. Additional data about GDP is included. 
> All the calculated results are rounded up two decimal points.

Finally, table *t_lucia_luptakova_project_SQL_secondary_final* based on the data in tables economies and countries has been created.  No tasks reference this table. This table is missing a lot of data that could cause doubt on the relevance of the conclusions. The missing data concern non-autonomous island (regions), principalities and in particular, the Balkan states.

## Conclusion 

The observed period (2006 - 2018) encompassed the Great Recession and its aftermath, providing an important macroeconomic context in which the recorded fluctuation in GDP, salaries and prices should be interpreted. 
With the help of SQL scripts, it is possible to answer all the tasks.
The results are as follows:
1.	Over the concerning period in 2009 – 2010, the salary growth stagnated across most sectors and even declined in some, including agriculture, forestry and fishing, mining and quarrying, accommodation and food service activities, and professional, scientific and technical activities. A decline and stagnation in salary growth also occurred in 2013, affecting electricity, gas, steam and air conditioning supply, construction, information and communication activities, and real estate activities. The largest decline has been recorded in the financial and insurance sector, approximately 10%.
2.	In terms of purchasing power, the number of units of bread and milk that could be purchased increased from 644 loaves of bread and 719 litres of milk in 2006 to 671 loavas and 821 litres in 2018.
3.	Among all commodities, sugar has seen the slowest price growth. The average annual price change was negative (-1.92%), suggesting that over the observed period, price decreases occurred more frequently than increases.
4.	Over the observed period, the average annual increase in prices across all commodities did not exceed 10% in any year.
5.	 In 2009, the decline in GDP coincided with a decrease in food prices and a slowdown in salary growth. Between 2011 and 2013, continued GDP contraction was associated with persistently low salary growth, culminating in a salary decline of 1.56% in 2013. Food price developments appeared to follow these trends with a time lag, with prices declining continuously over the subsequent three years. Although the observed patterns suggest interrelationships between economic performance, salaries, purchasing power and food prices, the results do not allow for definitive casual conclusion.
