CREATE TABLE trasee_localitati
AS

SELECT *
FROM 
(
SELECT Ord,Traseu, Dist, (SELECT SUM(Distanta) FROM 
(SELECT SYS_CONNECT_BY_PATH (Loc1, '**') || '**' || Loc2 AS Traseu, LEVEL AS Nivel, 
      SYS_CONNECT_BY_PATH (Distanta, '+') AS Dist, d.*, ROWNUM AS Ord
    FROM distante d 
    START WITH Loc1='Iasi' 
    CONNECT BY PRIOR Loc2 = Loc1 AND Loc1<>'Focsani' AND Level < 50
    ORDER BY Ord
    )
          t2 WHERE t1.Traseu LIKE Traseu|| '%') AS Km 
FROM 
    (SELECT SYS_CONNECT_BY_PATH (Loc1, '**') || '**' || Loc2 AS Traseu, LEVEL AS Nivel, 
      SYS_CONNECT_BY_PATH (Distanta, '+') AS Dist, d.*, ROWNUM AS Ord
    FROM distante d 
    START WITH Loc1='Iasi' 
    CONNECT BY PRIOR Loc2 = Loc1 AND Loc1<>'Focsani' AND Level < 50
    ORDER BY Ord
    ) t1 
WHERE Traseu LIKE '**Iasi%Focsani'
ORDER BY Km
)




--------------
CREATE OR REPLACE PACKAGE pac_numar AS
v_numar NUMBER(8) ; 
END ;
/

CREATE OR REPLACE FUNCTION f_eval (sir_ VARCHAR2) RETURN NUMBER 
IS
BEGIN 
  EXECUTE IMMEDIATE 'BEGIN SELECT ' || sir_ || ' INTO pac_numar.v_numar FROM dual ; END ;' ;
  RETURN pac_numar.v_numar ;
END ;
/

SELECT x.*, f_eval(Dist) AS Distanta
FROM 
  (SELECT d.*, SYS_CONNECT_BY_PATH (Loc1, '**') || '**' || Loc2 AS Traseu, LEVEL, 
      '0'||SYS_CONNECT_BY_PATH (Distanta, '+') AS Dist
    FROM distante d
    START WITH Loc1='Iasi'
    CONNECT BY PRIOR Loc2 = Loc1 AND Loc1<>'Focsani' AND Level < 50
  ) x
WHERE Traseu LIKE '%Focsani'


SELECT f_eval('2+5+7') FROM dual   

BEGIN 
  DBMS_OUTPUT.PUT_LINE(f_eval('2+5+7')) ;
END ;  


WITH distante_tot AS
  (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante)
-- ruta directa
SELECT d1.Loc1 AS Plecare, d1.Loc2 AS Sosire, d1.Loc1 || '**' || d1.Loc2 AS Sir, Distanta
FROM distante_tot d1
WHERE Loc1='Iasi' AND Loc2='Focsani'  


SELECT d.*, SYS_CONNECT_BY_PATH (Loc1, '**') || '**' || Loc2, LEVEL, 
  SYS_CONNECT_BY_PATH (Distanta, '+'),
  SYS_CONNECT_BY_PATH (Loc1, '**') || '**' || Loc2, LEVEL, 
  SYS_CONNECT_BY_PATH (Distanta, '+') 
FROM distante d
START WITH Loc1='Iasi'
CONNECT BY PRIOR Loc2 = Loc1 AND Loc1<>'Focsani' AND Level < 10


-- Iasi-Focsani
WITH distante_tot AS
  (SELECT Loc1, Loc2, Distanta FROM distante UNION SELECT Loc2, Loc1, Distanta FROM distante)
-- ruta directa
SELECT d1.Loc1 AS Plecare, d1.Loc2 AS Sosire, d1.Loc1 || '**' || d1.Loc2 AS Sir, Distanta
FROM distante_tot d1
WHERE Loc1='Iasi' AND Loc2='Focsani'  

UNION   
-- rute printr-o localitate intermediara
SELECT d1.Loc1, d2.Loc2, d1.Loc1 || '**' || d1.Loc2 || '**' || d2.Loc2,
  d1.Distanta + d2.Distanta
FROM distante_tot d1 INNER JOIN distante_tot d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 AND d2.Loc2='Focsani'
UNION
-- rute prin doua localitati intermediare
SELECT d1.Loc1, d3.Loc2, d1.Loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2,
  d1.Distanta + d2.Distanta+d3.Distanta
FROM distante_tot d1 
  INNER JOIN distante_tot d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 
      AND d2.Loc2 <> d1.Loc1 AND d2.Loc2<>d1.Loc2 
  INNER JOIN distante_tot d3 ON d2.Loc2=d3.Loc1 AND d3.Loc2='Focsani' 
      AND d3.Loc2 <> d2.Loc1 AND d3.Loc2<>d2.Loc2  
        AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
UNION
-- rute prin trei localitati intermediare
SELECT d1.loc1, d4.Loc2, d1.loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2 || '**' || d4.Loc2,
  d1.distanta + d2.distanta+d3.distanta+d4.distanta
FROM distante_tot d1 
  INNER JOIN distante_tot d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 
    AND d2.Loc2 <> d1.loc1 AND d2.Loc2<>d1.Loc2
  INNER JOIN distante_tot d3 ON d2.Loc2=d3.Loc1 
    AND d3.Loc2 <> d2.loc1 AND d3.Loc2<>d2.loc2  
        AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
    INNER JOIN distante_tot d4 ON d3.Loc2=d4.Loc1 AND d4.Loc2='Focsani' 
      AND d4.Loc2 <> d3.loc1 AND d4.Loc2<>d3.loc2
        AND d4.Loc2 <> d2.Loc1 AND d4.Loc2<>d2.Loc2
          AND d4.Loc2 <> d1.Loc1 AND d4.Loc2<>d1.Loc2
UNION
-- rute prin patru localitati intermediare
SELECT d1.loc1, d5.Loc2, d1.loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2 || '**' || d4.Loc2 || '**' || d5.Loc2,
  d1.distanta + d2.distanta+d3.distanta+d4.distanta+d5.distanta
FROM distante_tot d1 
  INNER JOIN distante_tot d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 
    AND d2.Loc2 <> d1.loc1 AND d2.Loc2<>d1.Loc2
  INNER JOIN distante_tot d3 ON d2.Loc2=d3.Loc1 
    AND d3.Loc2 <> d2.loc1 AND d3.Loc2<>d2.loc2  
        AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
  INNER JOIN distante_tot d4 ON d3.Loc2=d4.Loc1  
      AND d4.Loc2 <> d3.loc1 AND d4.Loc2<>d3.loc2
        AND d4.Loc2 <> d2.Loc1 AND d4.Loc2<>d2.Loc2
          AND d4.Loc2 <> d1.Loc1 AND d4.Loc2<>d1.Loc2
  INNER JOIN distante_tot d5 ON d4.Loc2=d5.Loc1 AND d5.Loc2='Focsani' 
      AND d5.Loc2 <> d4.loc1 AND d5.Loc2<>d4.loc2
        AND d5.Loc2 <> d3.loc1 AND d5.Loc2<>d3.loc2
          AND d5.Loc2 <> d2.Loc1 AND d5.Loc2<>d2.Loc2
            AND d5.Loc2 <> d1.Loc1 AND d5.Loc2<>d1.Loc2
UNION
-- rute prin cinci localitati intermediare
SELECT d1.loc1, d6.Loc2, d1.loc1 || '**' || d1.Loc2 || '**' || d2.Loc2 || '**' || d3.Loc2 || '**' || d4.Loc2 || '**' || d5.Loc2
  || '**' || d6.Loc2,
  d1.distanta + d2.distanta+d3.distanta+d4.distanta+d5.distanta+d6.distanta
FROM distante_tot d1 
  INNER JOIN distante_tot d2 ON d1.Loc1='Iasi' AND d1.Loc2=d2.Loc1 
    AND d2.Loc2 <> d1.loc1 AND d2.Loc2<>d1.Loc2
  INNER JOIN distante_tot d3 ON d2.Loc2=d3.Loc1 
    AND d3.Loc2 <> d2.loc1 AND d3.Loc2<>d2.loc2  
        AND d3.Loc2 <> d1.Loc1 AND d3.Loc2<>d1.Loc2
  INNER JOIN distante_tot d4 ON d3.Loc2=d4.Loc1  
      AND d4.Loc2 <> d3.loc1 AND d4.Loc2<>d3.loc2
        AND d4.Loc2 <> d2.Loc1 AND d4.Loc2<>d2.Loc2
          AND d4.Loc2 <> d1.Loc1 AND d4.Loc2<>d1.Loc2
  INNER JOIN distante_tot d5 ON d4.Loc2=d5.Loc1  
      AND d5.Loc2 <> d4.loc1 AND d5.Loc2<>d4.loc2
        AND d5.Loc2 <> d3.loc1 AND d5.Loc2<>d3.loc2
          AND d5.Loc2 <> d2.Loc1 AND d5.Loc2<>d2.Loc2
            AND d5.Loc2 <> d1.Loc1 AND d5.Loc2<>d1.Loc2
 INNER JOIN distante_tot d6 ON d5.Loc2=d6.Loc1 AND d6.Loc2='Focsani' 
      AND d6.Loc2 <> d5.loc1 AND d6.Loc2<>d5.loc2
        AND d6.Loc2 <> d4.loc1 AND d6.Loc2<>d4.loc2
          AND d6.Loc2 <> d3.loc1 AND d6.Loc2<>d3.loc2
            AND d6.Loc2 <> d2.Loc1 AND d6.Loc2<>d2.Loc2
              AND d6.Loc2 <> d1.Loc1 AND d6.Loc2<>d1.Loc2
ORDER BY 4



