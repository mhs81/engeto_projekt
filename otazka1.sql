SELECT 
	 a.odvetvi
	 ,a.rok
	,a.prumerna_mzda
	,b.rok
	,b.prumerna_mzda
	,a.prumerna_mzda-b.prumerna_mzda rozdil
FROM t_milan_weiter_project_SQL_primary_final a
JOIN t_milan_weiter_project_SQL_primary_final b
ON a.rok = b.rok + 1 AND a.odvetvi = b.odvetvi
WHERE a.potravina IS NULL
	AND a.prumerna_mzda-b.prumerna_mzda < 0
ORDER BY rozdil;