SELECT 
	ceny.rok,
	ceny.potravina,
	ceny.prumerna_cena,
	mzdy.prumerna_mzda,
	round(mzdy.prumerna_mzda / ceny.prumerna_cena) kolik 
FROM
(
	SELECT *
	FROM t_milan_weiter_project_SQL_primary_final
	WHERE kod IN ('111301', '114201')
) ceny
JOIN
(
	SELECT rok, prumerna_mzda
	FROM t_milan_weiter_project_SQL_primary_final
	WHERE odvetvi IS NULL
		AND prumerna_mzda IS NOT NULL
) mzdy
ON ceny.rok = mzdy.rok;