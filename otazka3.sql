SELECT 
	a.potravina
	,a.rok
	,a.prumerna_cena 
	,b.rok
	,b.prumerna_cena
	,(a.prumerna_cena - b.prumerna_cena) zdrazeni
	,round (AVG((a.prumerna_cena - b.prumerna_cena) / b.prumerna_cena * 100), 2) prumer_procent
FROM t_milan_weiter_project_SQL_primary_final a
JOIN 
t_milan_weiter_project_SQL_primary_final b
	ON a.rok = b.rok +1
	AND a.kod = b.kod
GROUP BY a.potravina
ORDER BY prumer_procent;