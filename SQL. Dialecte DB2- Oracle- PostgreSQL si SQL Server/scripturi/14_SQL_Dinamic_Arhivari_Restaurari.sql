--===============================================================================
-- pachetul pac_arhivare este cel care exemplifica o serie de optiuni de tip
--	SQL dinamic
--================================================================================
CREATE OR REPLACE PACKAGE PAC_ARHIVARE AUTHID CURRENT_USER AS

-- procedura P_ARHIVARE_TABELA creaza o arhiva a unei tabele "tranzactionale"
-- cu inregistrarile pe un an si luna, apoi sterge din tabela principala inregistrarile
-- arhivate (de ex. FACTURI pentru luna 8 din 2006 - se creeaza FACTURI_2006_8
-- se muta acolo toate facturile emise (DataFact) in luna august 2006

PROCEDURE p_arhivare_tabela (tabela_ VARCHAR2, an_ NUMBER, luna_ NUMBER) ;


-- o functie "supraincarcata" ce verifica existenta unei tabele

FUNCTION f_exista_tabela (tabela_ VARCHAR2, an_ NUMBER, luna_ NUMBER) 
	RETURN BOOLEAN ;
	
FUNCTION f_exista_tabela (tabela_ VARCHAR2) RETURN BOOLEAN ;


--------------------------------------------------------------------------------------
-- urmeaza citeva proceduri, functii si tipuri pentru "recompunerea" dinanica
-- a inregistrarilor arhivate


-- varianta 1 de reconstituire facturi : tabela virtuala
PROCEDURE p_fuziune_facturi1 (datai DATE, dataf DATE)  ;

FUNCTION f_sir_facturi (datai DATE, dataf DATE) RETURN VARCHAR2 ;

-- varianta 2 de reconstituire facturi : functie ce returneaza un NESTED TABLE;
-- in prealabil trebuie create tipurile T_R_facturi si T_facturi

/*
-- acestea sunt comenzi SQL ce trebuie lansate direct
DROP TYPE t_r_facturi FORCE 
/
CREATE TYPE t_r_facturi AS OBJECT (
    nrfact NUMBER(8),
    datafact DATE,
    codcl NUMBER(6),
    Obs VARCHAR2(50), 
    tvafact NUMBER(12,2),	
    valfact NUMBER(12,2),
    reducfin NUMBER(12,2),
    valincas NUMBER(12,2),
    valreglata NUMBER(12,2)				
    ) ;

   ) 
/   
DROP TYPE t_facturi FORCE 
/
CREATE TYPE t_facturi AS TABLE OF t_r_facturi ;
/
*/
FUNCTION f_fuziune_facturi2 (datai DATE, dataf DATE) RETURN t_facturi ;

-- o alta varianta a F_FUZIUNE_facturi2 cu variabile cursor si PIPELINED
FUNCTION f_fuziune_facturi3 (datai DATE, dataf DATE) RETURN t_facturi PIPELINED ;

END pac_arhivare ;
--====================================================================================



--===================================================================================
	CREATE OR REPLACE PACKAGE BODY "PAC_ARHIVARE" AS
--===================================================================================
PROCEDURE p_arhivare_tabela(tabela_ VARCHAR2,   an_ NUMBER,   luna_ NUMBER) IS
  v_tabela VARCHAR2(100);
  v_unu NUMBER(1);
  v_atribut VARCHAR2(100);
  v_sir VARCHAR2(1024);
  BEGIN
    v_atribut := CASE UPPER(tabela_) WHEN 'FACTURI' THEN 'DATAFACT'
  END;

  -- la inceput se creaza tabelele (iar daca sunt deja create se declanseaza eroare) 
  -- 		si se insereaza inregistrarile 

  -- exemplificam pe tabela FACTURI
  v_tabela := tabela_ || '_' || LTRIM(to_char(an_,   '9999')) || '_' || LTRIM(to_char(luna_,   '99'));

  IF NOT f_exista_tabela(tabela_,   an_,   luna_) THEN
    EXECUTE IMMEDIATE ' CREATE TABLE ' || v_tabela || ' AS SELECT * FROM ' || tabela_ || ' WHERE 1=2';
  ELSE
    raise_application_error(-20120,   'A fost facuta deja arhivarea pe luna ' || luna_ || ', anul ' || an_);
  END IF;

  EXECUTE IMMEDIATE 'INSERT INTO ' || v_tabela || ' SELECT * FROM ' || 
    tabela_ || ' WHERE EXTRACT (YEAR FROM ' || v_atribut || ' ) = ' || an_ || 
    ' AND EXTRACT (MONTH FROM ' || v_atribut || ' ) = ' || luna_;

  EXECUTE IMMEDIATE 'DELETE FROM ' || tabela_ || ' WHERE EXTRACT (YEAR FROM ' 
    || v_atribut || ') = ' || an_ || ' AND EXTRACT (MONTH FROM ' || v_atribut || ') = ' || luna_;

END p_arhivare_tabela;
----------------------------------------------------------------------------------

-------------------------------------------------------------------------	
FUNCTION f_exista_tabela(tabela_ VARCHAR2,   an_ NUMBER,   luna_ NUMBER) 
  RETURN boolean 
IS 
  v_tabela VARCHAR2(100);
  v_unu NUMBER(1);
BEGIN
  v_tabela := UPPER(tabela_) || '_' || LTRIM(to_char(an_,   '9999')) || '_' || LTRIM(to_char(luna_,   '99'));
  
  SELECT 1 INTO v_unu FROM user_tables 
  WHERE TABLE_NAME = v_tabela;
  RETURN TRUE;

EXCEPTION
WHEN no_data_found THEN
  RETURN FALSE;
END f_exista_tabela;
-----------------------------------------------------	

-------------------------------------------------------------------------	
FUNCTION f_exista_tabela(tabela_ VARCHAR2) RETURN boolean IS v_tabela VARCHAR2(100);
v_unu NUMBER(1);
BEGIN
  v_tabela := UPPER(tabela_);
  SELECT 1 INTO v_unu FROM user_tables WHERE TABLE_NAME = v_tabela;
  RETURN TRUE;

EXCEPTION
WHEN no_data_found THEN
  RETURN FALSE;
END f_exista_tabela;
-----------------------------------------------------	

--= = = = = = = = = = = = == = = = = = = = = == = = = = = = = = = = 
PROCEDURE p_fuziune_facturi1(datai DATE,   dataf DATE) 
IS
  v_sir VARCHAR2(2056) := ' ';
  v_luna_initiala NUMBER(2);
  v_luna_finala NUMBER(2);
  v_an_initial NUMBER(4) := EXTRACT(YEAR FROM datai);
  v_an_final NUMBER(4) := EXTRACT(YEAR FROM dataf);
BEGIN
  FOR v_an IN v_an_initial .. v_an_final
  LOOP
    IF v_an = v_an_initial THEN
      v_luna_initiala := EXTRACT(MONTH
      FROM datai);
    ELSE
      v_luna_initiala := 1;
    END IF;

    IF v_an = v_an_final THEN
      v_luna_finala := EXTRACT(MONTH
      FROM dataf);
    ELSE
      v_luna_finala := 12;
    END IF;

    FOR v_luna IN v_luna_initiala .. v_luna_finala
    LOOP
      -- verificam daca exista arhiva pt. aceasta luna

      IF pac_arhivare.f_exista_tabela('FACTURI',   v_an,   v_luna) THEN

        IF v_sir <> ' ' THEN
          v_sir := v_sir || ' UNION ';
        END IF;

        IF v_luna = v_luna_initiala THEN
          v_sir := v_sir || ' SELECT * FROM facturi_' || v_an || '_' || RTRIM(v_luna) ||
		 ' WHERE datacazare >= DATE''' || to_char(datai,   'YYYY-MM-DD') || '''';
        ELSE
          v_sir := v_sir || ' SELECT * FROM facturi_' || v_an || '_' || RTRIM(v_luna);
        END IF;

      END IF;

    END LOOP;
  END LOOP;

  IF v_sir <> ' ' THEN
    -- exista macar o factura in lista dorita
    v_sir := v_sir || ' UNION ';
  END IF;

  v_sir := v_sir || ' SELECT * FROM facturi ';

  --DBMS_OUTPUT.PUT_LINE(v_sir) ;

  IF pac_arhivare.f_exista_tabela('TEMP_facturi') THEN
    DELETE FROM temp_facturi;
    EXECUTE IMMEDIATE 'INSERT INTO temp_facturi SELECT * FROM (' || v_sir || ')  ';
  ELSE
    EXECUTE IMMEDIATE 
      'CREATE GLOBAL TEMPORARY TABLE temp_facturi ON COMMIT PRESERVE ROWS AS SELECT * FROM (' || 
          v_sir || ')  ';
  END IF;

  -- dupa lansarea acestei proceduri, se face un SELECT pe tabela virtuala TEMP_facturi  
  -- SELECT * FROM temp_facturi 
END p_fuziune_facturi1;

------------------------------------------------------------------------------------
FUNCTION f_sir_facturi(datai DATE, dataf DATE) 
    RETURN VARCHAR2 
IS 
  v_sir VARCHAR2(2056) := ' ';
  v_luna_initiala NUMBER(2);
  v_luna_finala NUMBER(2);
  v_an_initial NUMBER(4) := EXTRACT(YEAR FROM datai);
  v_an_final NUMBER(4) := EXTRACT(YEAR FROM dataf);
BEGIN
  FOR v_an IN v_an_initial .. v_an_final  LOOP
    IF v_an = v_an_initial THEN
      v_luna_initiala := EXTRACT(MONTH FROM datai);
    ELSE
      v_luna_initiala := 1;
    END IF;
    IF v_an = v_an_final THEN
      v_luna_finala := EXTRACT(MONTH FROM dataf);
    ELSE
      v_luna_finala := 12;
    END IF;

    FOR v_luna IN v_luna_initiala .. v_luna_finala LOOP
      -- verificam daca exista arhiva pt. aceasta luna
      IF pac_arhivare.f_exista_tabela('facturi',   v_an,   v_luna) THEN
        IF v_sir <> ' ' THEN
          v_sir := v_sir || ' UNION ';
        END IF;
        IF v_luna = v_luna_initiala AND v_an = v_an_initial THEN
          v_sir := v_sir || ' SELECT * FROM facturi_' || v_an || '_' || RTRIM(v_luna) || 
              ' WHERE datacazare >= DATE''' || to_char(datai,   'YYYY-MM-DD') || '''';
        ELSE
          IF v_luna = v_luna_finala AND v_an = v_an_final THEN
            v_sir := v_sir || ' SELECT * FROM facturi_' || v_an || '_' || RTRIM(v_luna) ||
		 ' WHERE datacazare <= DATE''' || to_char(dataf,   'YYYY-MM-DD') || '''';
          ELSE
            v_sir := v_sir || ' SELECT * FROM facturi_' || v_an || '_' || RTRIM(v_luna);
          END IF;
        END IF;
      END IF;
    END LOOP;
  END LOOP;
  IF v_sir <> ' ' THEN
    -- exista macar o factura in lista dorita
    v_sir := v_sir || ' UNION ';
  END IF;
  RETURN v_sir || ' SELECT * FROM facturi WHERE dataFACT <= DATE''' ||
    to_char(dataf,   'YYYY-MM-DD') || '''';

END f_sir_facturi;
------------------------------------------------------------------------------------

-- = = = = = = =  + + + + + + + -------------------------------------------------
FUNCTION f_fuziune_facturi2(datai DATE,   dataf DATE) RETURN t_facturi 
IS 
  v_facturi t_facturi := t_facturi();
  v_sir VARCHAR2(2056) := ' ';
  TYPE trefcursor IS REF CURSOR;
  vrefcursor trefcursor;
  v_o_cazare facturi % rowtype;
BEGIN
  v_sir := f_sir_facturi(datai,   dataf);
  -- ar fi fost frumos, dar aceasta comanda nu functioneaza !!!
  --EXECUTE IMMEDIATE 'SELECT * BULK COLLECT INTO v_facturi FROM (' || v_sir || ')'  ;	

  -- asa ca folosim REFCURSOR
  OPEN vrefcursor FOR v_sir;
  LOOP
    FETCH vrefcursor INTO v_o_cazare;
    EXIT WHEN vrefcursor % NOTFOUND;
  -- DBMS_OUTPUT.PUT_LINE(v_o_cazare.idcazare) ;
    v_facturi.extend;
    v_facturi(v_facturi.COUNT) := t_r_facturi(v_o_cazare.idcazare,   v_o_cazare.datacazare,   
      v_o_cazare.datadecazare,   v_o_cazare.costcazare,   v_o_cazare.discount,  
      v_o_cazare.nrcamera,   v_o_cazare.idclient_pf);
  END LOOP;
  CLOSE vrefcursor;

  RETURN v_facturi;

-- aceasta functie se poate apela in orice SELECT dupa modelul:
-- SELECT * FROM TABLE (pac_arhivare.f_fuziune_facturi2(DATE'2006-08-15', DATE'2006-11-15'))

END f_fuziune_facturi2;

-----------------------------------------------------------------------------------------
-- = = = = = = =  + + + + + + + -------------------------------------------------
FUNCTION f_fuziune_facturi3(datai DATE, dataf DATE) RETURN t_facturi PIPELINED 
IS 
  --v_facturi t_facturi ; --:= t_facturi() ; -- nu mai avem nevoie de variabila colectie,
  --                            deoarece liniile se returneaza pe rind (PIPELINED)
  v_sir VARCHAR2(2056) := ' ';
  TYPE tRefCursor IS REF CURSOR;
  vRefCursor tRefCursor;
  v_o_cazare facturi%ROWTYPE  ;
  v_cazare_p t_r_facturi ;  --:= t_r_facturi() ;
BEGIN
  v_sir := f_sir_facturi(datai, dataf);
  OPEN vrefcursor FOR v_sir;
  LOOP
    FETCH vRefCursor INTO v_o_cazare;
    EXIT WHEN vRefCursor%NOTFOUND ;
    v_cazare_p := t_r_facturi (v_o_cazare.IDCAZARE, v_o_cazare.DATACAZARE, 
        v_o_cazare.DATADECAZARE, v_o_cazare.COSTCAZARE, v_o_cazare.DISCOUNT, 
        v_o_cazare.NRCAMERA, v_o_cazare.IDCLIENT_PF) ;
    PIPE ROW(v_cazare_p);
  END LOOP;
  CLOSE vrefcursor;
  RETURN ;

  -- aceasta functie de poate apela in orice SELECT dupa modelul:
  -- SELECT * FROM TABLE (pac_arhivare.f_fuziune_facturi3(DATE'2006-08-15', DATE'2006-11-15'))

END f_fuziune_facturi3;


END pac_arhivare;
--=================================================================================================    

