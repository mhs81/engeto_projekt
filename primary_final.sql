CREATE OR REPLACE TABLE t_milan_weiter_project_SQL_primary_final AS
(SELECT 
	cp.payroll_year rok
	,cpib.name odvetvi
	,avg(cp.value) prumerna_mzda 
	,NULL AS potravina
	,NULL AS kod
	,NULL AS prumerna_cena
	,NULL AS HDP
FROM czechia_payroll cp
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code
WHERE
	cp.value_type_code = '5958'
	AND cp.calculation_code = '100'
GROUP BY cp.payroll_year, cp.industry_branch_code
)
UNION
(SELECT 
	YEAR(price.date_from) rok 
	,NULL as odvetvi
	,NULL as prumerna_mzda
	,p_code.name potravina
	,price.category_code
	,ROUND(AVG(price.value),2) prumerna_cena
	,NULL AS HDP
FROM czechia_price price
JOIN czechia_price_category p_code
	ON price.category_code = p_code.code
WHERE price.region_code IS NULL
GROUP BY rok, price.category_code
)
UNION
(SELECT e.year 
	,NULL as odvetvi
	,NULL as prumerna_mzda
	,NULL AS potravina
	,NULL AS kod
	,NULL AS prumerna_cena
	,e.GDP 
FROM economies e 
WHERE country = 'Czech Republic'
	AND e.GDP IS NOT NULL
);