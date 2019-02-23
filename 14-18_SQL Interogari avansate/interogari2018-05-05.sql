-- ce facturi contin MACAR produsele din factura 1117
-- solutie noua
with p1117 as 
	(select codpr 
	from liniifact
	where nrfact = 1117)
select nrfact, count (distinct liniifact.codpr)
from liniifact 
	inner join p1117 on liniifact.codpr = p1117.codpr
group by nrfact
having count (distinct liniifact.codpr) = 
	(select count(*) from p1117)
order by 1	


-- solutie copiata de pe slide-ul 53 (prezentare 15_...)
WITH 	
	facturi_prod1117 AS (
		SELECT lf1.NrFact, lf1.CodPr
		FROM liniifact lf1 
			INNER JOIN liniifact lf2 ON lf1.CodPr=lf2.CodPr AND lf2.NrFact=1117),
	nrproduse_1117	AS ( 
		SELECT COUNT(DISTINCT CodPr) AS Nr
		FROM liniifact 
		WHERE NrFact=1117)		
SELECT NrFact 
FROM facturi_prod1117
GROUP BY NrFact
HAVING COUNT(DISTINCT CodPr) = (SELECT Nr
 					               FROM nrproduse_1117)

-- structura ierarhica
WITH RECURSIVE ierarhie ( Marca, NumePren, Compart, 
		MarcaSef, Nivel_Ierarhic) AS (
SELECT Marca, NumePren, Compart, MarcaSef, 0 AS Nivel
 FROM personal
 WHERE MarcaSef IS NULL
UNION ALL
 SELECT p.Marca, p.NumePren, p.Compart, 
		p.MarcaSef, Nivel_Ierarhic + 1
 FROM personal p INNER JOIN ierarhie 
		ON p.MarcaSef=ierarhie.Marca 
) 		
SELECT * FROM ierarhie

-- liniarizarea continutului fiecarei facturi din sept 2013
WITH RECURSIVE ierarhie ( NrFact, Linie, CodPr, Cantitate, 
						 PretUnit, Nivel, DenPr) AS (
	SELECT NrFact, Linie, lf.CodPr, Cantitate, PretUnit, 0 AS Nivel, 
		CAST ('-\\-' || DenPr  AS VARCHAR(500))
	FROM liniifact lf INNER JOIN produse p ON lf.CodPr=p.CodPr
 	WHERE Linie=1 AND NrFact IN (SELECT NrFact FROM facturi  WHERE EXTRACT 
		(YEAR FROM DataFact)=2013 AND EXTRACT (MONTH FROM DataFact)=9)
UNION ALL
 	SELECT lf.NrFact, lf.Linie, lf.CodPr, lf.Cantitate, 
		lf.PretUnit, Nivel + 1, CAST (ierarhie.DenPr || 
		' -\\- ' || p.DenPr AS VARCHAR(500))
 	FROM liniifact lf INNER JOIN ierarhie ON lf.NrFact = ierarhie.NrFact AND 
		lf.Linie=ierarhie.Linie+1 INNER JOIN produse p ON lf.CodPr=p.CodPr
 	WHERE lf.NrFact IN 
				(SELECT NrFact 
				 FROM facturi  WHERE EXTRACT (YEAR FROM 	DataFact)=2013 AND 
				 		EXTRACT (MONTH FROM DataFact)=9)    )
SELECT i1.NrFact, linie AS NrLinii, DenPr AS Lista_Produse 
FROM ierarhie i1
WHERE Linie = (SELECT MAX(Linie) FROM ierarhie WHERE NrFact=i1.NrFact)
ORDER BY 1


