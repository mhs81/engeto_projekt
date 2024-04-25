CREATE OR REPLACE TABLE t_milan_weiter_project_SQL_second_final AS
SELECT c.country 
	,c. population 
	,e.year
	,e.GDP 
	,e.gini 	
FROM countries c 
JOIN economies e 
ON c.country = e.country
WHERE c.continent  = "Europe"
	AND YEAR >=2006
ORDER BY c.country, e.YEAR;