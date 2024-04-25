SELECT *
FROM (SELECT a.rok
	,round ((a.HDP - b.HDP)) AS narust_HDP
	FROM t_milan_weiter_project_SQL_primary_final a
	JOIN t_milan_weiter_project_SQL_primary_final b
	ON a.rok = b.rok +1
	AND a.HDP IS NOT NULL
	AND b.HDP IS NOT NULL) HDP
JOIN
	(SELECT a.rok
		,round (AVG(a.prumerna_cena), 2)
		,round (AVG((a.prumerna_cena - b.prumerna_cena) / b.prumerna_cena * 100), 2) proc_narust_cen
	FROM t_milan_weiter_project_SQL_primary_final a
	JOIN 
	t_milan_weiter_project_SQL_primary_final b
	ON a.rok = b.rok +1
	AND a.kod = b.kod
	GROUP BY a.rok
	) ceny
ON HDP.rok = ceny.rok
JOIN
	(SELECT 
		a.rok rok2
		,round(((a.prumerna_mzda - b.prumerna_mzda)/ b.prumerna_mzda *100), 2) proc_narust_mezd
	FROM t_milan_weiter_project_SQL_primary_final a
	JOIN 
	t_milan_weiter_project_SQL_primary_final b
	ON a.rok = b.rok +1
	WHERE a.odvetvi IS NULL 
	AND b.odvetvi IS NULL 
	AND b.potravina IS NULL 
	AND a.potravina IS NULL
	AND a.HDP IS NULL
	AND b.HDP IS NULL
	) mzdy
ON ceny.rok = mzdy.rok2;