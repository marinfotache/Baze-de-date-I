SELECT rute.*,    
    SUBSTR(traseu, INSTR(traseu,'**',1,1)+2, INSTR(traseu,'**',1,2) -3) AS L1,
	CASE 
	WHEN INSTR(traseu,'**',1,2) = 0 THEN NULL
        ELSE SUBSTR(traseu, INSTR(traseu,'**',1,2)+2, 
              CASE 
              WHEN INSTR(traseu, '**',1,3) > 0 THEN INSTR(traseu,'**',1,3) - INSTR(traseu,'**',1,2) -2 
              ELSE  LENGTH(traseu)     
              END )
	END AS L2,
        CASE 
	WHEN INSTR(traseu,'**',1,3) = 0 THEN NULL
        ELSE SUBSTR(traseu, INSTR(traseu,'**',1,3)+2, 
              CASE 
              WHEN INSTR(traseu, '**',1,4) > 0 THEN INSTR(traseu,'**',1,4) - INSTR(traseu,'**',1,3) -2 
              ELSE  LENGTH(traseu)     
              END )
	END AS L3,
        CASE 
	WHEN INSTR(traseu,'**',1,4) = 0 THEN NULL
        ELSE SUBSTR(traseu, INSTR(traseu,'**',1,4)+2, 
              CASE 
              WHEN INSTR(traseu, '**',1,5) > 0 THEN INSTR(traseu,'**',1,5) - INSTR(traseu,'**',1,4) -2 
              ELSE  LENGTH(traseu)     
              END )
	END AS L4,
        CASE 
	WHEN INSTR(traseu,'**',1,5) = 0 THEN NULL
        ELSE SUBSTR(traseu, INSTR(traseu,'**',1,5)+2, 
              CASE 
              WHEN INSTR(traseu, '**',1,6) > 0 THEN INSTR(traseu,'**',1,6) - INSTR(traseu,'**',1,5) -2 
              ELSE  LENGTH(traseu)     
              END )
	END AS L5,
        CASE 
	WHEN INSTR(traseu,'**',1,6) = 0 THEN NULL
        ELSE SUBSTR(traseu, INSTR(traseu,'**',1,6)+2, 
              CASE 
              WHEN INSTR(traseu, '**',1,7) > 0 THEN INSTR(traseu,'**',1,7) - INSTR(traseu,'**',1,6) -2 
              ELSE  LENGTH(traseu)     
              END )
	END AS L6,
        CASE 
	WHEN INSTR(traseu,'**',1,7) = 0 THEN NULL
        ELSE SUBSTR(traseu, INSTR(traseu,'**',1,7)+2, 
              CASE 
              WHEN INSTR(traseu, '**',1,8) > 0 THEN INSTR(traseu,'**',1,8) - INSTR(traseu,'**',1,7) -2 
              ELSE  LENGTH(traseu)     
              END )
	END AS L7
FROM	(
    SELECT  Ord, Traseu, (SELECT SUM(Distanta) 
                          FROM (  SELECT SYS_CONNECT_BY_PATH (Loc1, '**') || '**' || Loc2 AS Traseu, LEVEL AS Nivel, d.*, ROWNUM AS Ord
                                  FROM distante d 
                                  START WITH Loc1='Iasi' 
                                  CONNECT BY PRIOR Loc2 = Loc1 AND Loc1<>'Focsani' AND Level < 50
                                ORDER BY Ord ) t2   
                          WHERE tab.Traseu LIKE Traseu|| '%') AS Km 
    FROM 
        (SELECT SYS_CONNECT_BY_PATH (Loc1, '**') || '**' || Loc2 AS Traseu, LEVEL AS Nivel, 
            SYS_CONNECT_BY_PATH (Distanta, '+') AS Dist, d.*, ROWNUM AS Ord
        FROM distante d 
        START WITH Loc1='Iasi' 
        CONNECT BY PRIOR Loc2 = Loc1 AND Loc1<>'Focsani' AND Level < 50
        ORDER BY Ord
        ) tab
WHERE Traseu LIKE '**Iasi%Focsani'
    ORDER BY Km
    ) rute 
