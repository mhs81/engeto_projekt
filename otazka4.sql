SELECT *,
	round((proc_narust_cen - proc_narust_mezd), 2) rozdil
FROM
(
	SELECT a.rok,
		avg(a.prumerna_cena) prumerna_cena,
		avg((a.prumerna_cena - b.prumerna_cena) / b.prumerna_cena * 100) proc_narust_cen
	FROM t_milan_weiter_project_SQL_primary_final a
	JOIN t_milan_weiter_project_SQL_primary_final b
	ON a.rok = b.rok + 1
		AND (a.kod = b.kod)
	GROUP BY a.rok 
) ceny
JOIN
(
	SELECT 
	a.rok,
	((a.prumerna_mzda - b.prumerna_mzda) / b.prumerna_mzda * 100) proc_narust_mezd
	FROM t_milan_weiter_project_SQL_primary_final a
	JOIN t_milan_weiter_project_SQL_primary_final b
	ON a.rok = b.rok + 1
	WHERE a.odvetvi IS NULL 
		AND b.odvetvi IS NULL 
		AND b.potravina IS NULL 
		AND a.potravina IS NULL
		AND a.HDP IS NULL
		AND b.HDP IS NULL
) mzdy
ON ceny.rok = mzdy.rok
ORDER BY rozdil DESC
LIMIT 1;