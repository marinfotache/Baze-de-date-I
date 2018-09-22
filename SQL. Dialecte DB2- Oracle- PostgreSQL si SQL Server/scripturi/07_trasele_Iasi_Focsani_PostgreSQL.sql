-- prima este (eventuala) rutã directã
SELECT d1.Loc1 AS Plecare, d1.Loc2 AS Sosire, 
	d1.Loc1 || '**' || d1.Loc2 AS Sir, 
	Distanta
FROM (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d1
WHERE Loc1='Iasi' AND Loc2='Focsani'  
UNION   
-- rute printr-o localitate intermediara
SELECT d1.Loc1, d2.Loc2, 
d1.Loc1 || '**' || d1.Loc2 || '**' || d2.Loc2,
 d1.Distanta + d2.Distanta
FROM (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d1 
	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d2 
ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 AND d2.Loc2='Focsani'
UNION
-- rute prin doua localitati intermediare
SELECT d1.Loc1, d3.Loc2, 
d1.Loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2,
  	d1.Distanta + d2.Distanta+d3.Distanta
FROM (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d1 
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 
      		AND d2.Loc2 <> d1.Loc1 AND d2.Loc2<>d1.Loc2 
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d3 ON d2.Loc2=d3.Loc1 AND d3.Loc2='Focsani' 
      		AND d3.Loc2 <> d2.Loc1 AND d3.Loc2<>d2.Loc2  
        		AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
UNION
-- rute prin trei localitati intermediare
SELECT d1.loc1, d4.Loc2, 
d1.loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2 || '**' || d4.Loc2,
  	d1.distanta + d2.distanta+d3.distanta+d4.distanta
FROM (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d1 
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 
    		AND d2.Loc2 <> d1.loc1 AND d2.Loc2<>d1.Loc2
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d3 ON d2.Loc2=d3.Loc1 
    		AND d3.Loc2 <> d2.loc1 AND d3.Loc2<>d2.loc2  
        		AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
    	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d4 ON d3.Loc2=d4.Loc1 AND d4.Loc2='Focsani' 
      		AND d4.Loc2 <> d3.loc1 AND d4.Loc2<>d3.loc2
        		AND d4.Loc2 <> d2.Loc1 AND d4.Loc2<>d2.Loc2
          		AND d4.Loc2 <> d1.Loc1 AND d4.Loc2<>d1.Loc2
UNION
-- rute prin patru localitati intermediare
SELECT d1.loc1, d5.Loc2, 
d1.loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2 || '**' || d4.Loc2 
|| '**' || d5.Loc2,
  	d1.distanta + d2.distanta+d3.distanta+d4.distanta+d5.distanta
FROM (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d1 
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 
    		AND d2.Loc2 <> d1.loc1 AND d2.Loc2<>d1.Loc2
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d3 ON d2.Loc2=d3.Loc1 
    		AND d3.Loc2 <> d2.loc1 AND d3.Loc2<>d2.loc2  
        		AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d4 ON d3.Loc2=d4.Loc1  
      		AND d4.Loc2 <> d3.loc1 AND d4.Loc2<>d3.loc2
        		AND d4.Loc2 <> d2.Loc1 AND d4.Loc2<>d2.Loc2
          		AND d4.Loc2 <> d1.Loc1 AND d4.Loc2<>d1.Loc2
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d5 ON d4.Loc2=d5.Loc1 AND d5.Loc2='Focsani' 
      		AND d5.Loc2 <> d4.loc1 AND d5.Loc2<>d4.loc2
        		AND d5.Loc2 <> d3.loc1 AND d5.Loc2<>d3.loc2
          		AND d5.Loc2 <> d2.Loc1 AND d5.Loc2<>d2.Loc2
            		AND d5.Loc2 <> d1.Loc1 AND d5.Loc2<>d1.Loc2
UNION
-- rute prin cinci localitati intermediare
SELECT d1.loc1, d6.Loc2, 
d1.loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2 || '**' || d4.Loc2 
|| '**' || d5.Loc2 || '**' || d6.Loc2,
  	d1.distanta + d2.distanta+d3.distanta+d4.distanta+d5.distanta+d6.distanta
FROM (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d1 
INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d2 ON d1.Loc1='Iasi' 
AND d1.Loc2=d2.Loc1 AND d2.Loc2 <> d1.loc1 AND d2.Loc2<>d1.Loc2
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d3 ON d2.Loc2=d3.Loc1 AND d3.Loc2 <> d2.loc1 AND
 d3.Loc2<>d2.loc2  AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d4 ON d3.Loc2=d4.Loc1 	AND d4.Loc2 <> d3.loc1 
AND d4.Loc2<>d3.loc2 AND d4.Loc2 <> d2.Loc1 AND d4.Loc2<>d2.Loc2
          		AND d4.Loc2 <> d1.Loc1 AND d4.Loc2<>d1.Loc2
  	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d5 ON d4.Loc2=d5.Loc1  AND d5.Loc2 <> d4.loc1 AND
 d5.Loc2<>d4.loc2 AND d5.Loc2 <> d3.loc1 AND d5.Loc2<>d3.loc2
          		AND d5.Loc2 <> d2.Loc1 AND d5.Loc2<>d2.Loc2
AND d5.Loc2 <> d1.Loc1 AND d5.Loc2<>d1.Loc2
 	INNER JOIN (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante) d6 ON d5.Loc2=d6.Loc1 AND d6.Loc2='Focsani' 
      		AND d6.Loc2 <> d5.loc1 AND d6.Loc2<>d5.loc2
        		AND d6.Loc2 <> d4.loc1 AND d6.Loc2<>d4.loc2
          		AND d6.Loc2 <> d3.loc1 AND d6.Loc2<>d3.loc2
            		AND d6.Loc2 <> d2.Loc1 AND d6.Loc2<>d2.Loc2
              		AND d6.Loc2 <> d1.Loc1 AND d6.Loc2<>d1.Loc2
ORDER BY 4
