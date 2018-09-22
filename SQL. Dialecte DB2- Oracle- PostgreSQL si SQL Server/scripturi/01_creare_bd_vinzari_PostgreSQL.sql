

DROP TABLE IF EXISTS incasfact CASCADE ;
DROP TABLE IF EXISTS incasari CASCADE;
DROP TABLE IF EXISTS liniifact CASCADE ;
DROP TABLE IF EXISTS facturi CASCADE;
DROP TABLE IF EXISTS produse CASCADE;
DROP TABLE IF EXISTS persclienti CASCADE;
DROP TABLE IF EXISTS persoane CASCADE;
DROP TABLE IF EXISTS clienti CASCADE;
DROP TABLE IF EXISTS coduri_postale CASCADE;
DROP TABLE IF EXISTS judete CASCADE;

CREATE TABLE judete (
    jud CHAR(2)
        CONSTRAINT pk_judete PRIMARY KEY
        CONSTRAINT ck_jud CHECK (jud=LTRIM(UPPER(jud))),
    judet VARCHAR(25)
        CONSTRAINT un_judet UNIQUE
        CONSTRAINT nn_judet NOT NULL
        CONSTRAINT ck_judet CHECK (judet=LTRIM(INITCAP(judet))),
    regiune VARCHAR(15)
        DEFAULT 'Moldova' CONSTRAINT nn_regiune NOT NULL
        CONSTRAINT ck_regiune CHECK (regiune IN ('Banat', 'Transilvania', 'Dobrogea',
            'Oltenia', 'Muntenia', 'Moldova'))
    ) ;

CREATE TABLE coduri_postale (
    codpost CHAR(6)
        CONSTRAINT pk_coduri_post PRIMARY KEY
        CONSTRAINT ck_codpost CHECK (codpost=LTRIM(codpost)),
    loc VARCHAR(25)
        CONSTRAINT nn_loc NOT NULL
        CONSTRAINT ck_loc CHECK (loc=LTRIM(INITCAP(loc))),
    jud CHAR(2)
        DEFAULT 'IS'
        CONSTRAINT fk_coduri_post_jud REFERENCES judete(jud) 
		ON DELETE RESTRICT ON UPDATE CASCADE
    ) ;


CREATE TABLE clienti (
    codcl SMALLINT NOT NULL
        CONSTRAINT pk_clienti PRIMARY KEY
        CONSTRAINT ck_codcl CHECK (codcl > 1000),
    dencl VARCHAR(30) NOT NULL
        CONSTRAINT ck_dencl CHECK (SUBSTR(dencl,1,1) = UPPER(SUBSTR(dencl,1,1))),
    codfiscal CHAR(9) NOT NULL
	CONSTRAINT un_codfiscal UNIQUE
        CONSTRAINT ck_codfiscal CHECK (SUBSTR(codfiscal,1,1) = UPPER(SUBSTR(codfiscal,1,1))),
    adresa VARCHAR(40)
        CONSTRAINT ck_adresa_clienti CHECK (SUBSTR(adresa,1,1) = UPPER(SUBSTR(adresa,1,1))),
    codpost CHAR(6) NOT NULL
        CONSTRAINT fk_clienti_cp REFERENCES coduri_postale(codpost)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    telefon VARCHAR(10)
    ) ;


CREATE TABLE persoane (
    cnp CHAR(14)
        CONSTRAINT pk_persoane PRIMARY KEY
        CONSTRAINT ck_cnp CHECK (cnp=LTRIM(UPPER(cnp))),
    nume VARCHAR(20) NOT NULL
        CONSTRAINT ck_nume CHECK (nume=LTRIM(INITCAP(nume))),
    prenume VARCHAR(20) NOT NULL
        CONSTRAINT ck_prenume CHECK (prenume=LTRIM(INITCAP(prenume))),
     adresa VARCHAR(50)
        CONSTRAINT ck_adresa_persoane CHECK (SUBSTR(adresa,1,1) = UPPER(SUBSTR(adresa,1,1))),
    sex CHAR(1) DEFAULT 'B' NOT NULL
        CONSTRAINT ck_sex CHECK (sex IN ('F','B')),
    codpost CHAR(6) NOT NULL
        CONSTRAINT fk_persoane_cp REFERENCES coduri_postale(codpost)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    telacasa VARCHAR(10),
    telbirou VARCHAR(10),
    telmobil VARCHAR(10),
    email VARCHAR(30)
    ) ;


CREATE TABLE persclienti (
    cnp CHAR(14) NOT NULL
        CONSTRAINT fk_persclienti_persoane REFERENCES persoane(cnp)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    codcl SMALLINT NOT NULL
        CONSTRAINT fk_persclienti_clienti REFERENCES clienti(codcl)
	ON DELETE RESTRICT ON UPDATE CASCADE,
    functie VARCHAR(25) NOT NULL
        CONSTRAINT ck_functie CHECK (SUBSTR(functie,1,1) = UPPER(SUBSTR(functie,1,1))),
    CONSTRAINT pk_persclienti PRIMARY KEY (cnp, codcl, functie)
    ) ;

CREATE TABLE produse (
    codpr SMALLINT NOT NULL
        CONSTRAINT pk_produse PRIMARY KEY
        CONSTRAINT ck_codpr CHECK (codpr > 0),
    denpr VARCHAR(30) NOT NULL CONSTRAINT ck_denpr
        CHECK (SUBSTR(denpr,1,1) = UPPER(SUBSTR(denpr,1,1))),
    um VARCHAR(10) NOT NULL,
    grupa VARCHAR(15) CONSTRAINT ck_produse_grupa
        CHECK (SUBSTR(grupa,1,1) = UPPER(SUBSTR(grupa,1,1))),
    procTVA NUMERIC(2,2) DEFAULT .19 NOT NULL
    ) ;

CREATE TABLE facturi (
    	nrfact INTEGER
        		CONSTRAINT pk_facturi PRIMARY KEY,
    	datafact DATE DEFAULT CURRENT_DATE,
        		CONSTRAINT ck_datafact CHECK (datafact >= TO_DATE('2007-01-01',
 			'YYYY-MM-DD') 	AND datafact <= DATE'2015-12-31'),
    	codcl SMALLINT
        		CONSTRAINT fk_facturi_clienti REFERENCES clienti(codcl) 
			ON UPDATE CASCADE,
    	obs VARCHAR(50) 
	) ;


CREATE TABLE liniifact (
    nrfact INTEGER
        CONSTRAINT fk_liniifact_facturi REFERENCES facturi(nrfact)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    linie SMALLINT NOT NULL
        CONSTRAINT ck_linie CHECK (linie > 0),
    codpr SMALLINT NOT NULL
	CONSTRAINT fk_liniifact_produse REFERENCES produse(codpr)
	ON DELETE RESTRICT ON UPDATE CASCADE,
    cantitate NUMERIC(8) NOT NULL,
    pretunit NUMERIC (9,2) NOT NULL,
    CONSTRAINT pk_liniifact PRIMARY KEY (nrfact,linie),
    CONSTRAINT un_liniifact UNIQUE (nrfact,codpr)
    ) ;


CREATE TABLE incasari (
    	codinc BIGINT NOT NULL
        		CONSTRAINT pk_incasari PRIMARY KEY,
    	datainc DATE DEFAULT CURRENT_DATE
        		CONSTRAINT ck_datainc CHECK (datainc >= '2007-01-01'
            			AND datainc <= TO_DATE('31/12/2015','DD/MM/YYYY')),
    	coddoc CHAR(4)
        		CONSTRAINT ck_coddoc CHECK(coddoc=UPPER(LTRIM(coddoc))),
    	nrdoc VARCHAR(16),
    	datadoc DATE DEFAULT CURRENT_DATE - 7
        		CONSTRAINT ck_datadoc CHECK (datadoc >= DATE'2007-01-01'
            		AND datadoc <= DATE'2010-12-31')
    	) ;

CREATE TABLE incasfact (
    codinc BIGINT CONSTRAINT fk_incasfact_incasari 
	REFERENCES incasari(codinc) ON DELETE RESTRICT ON UPDATE CASCADE,
    nrfact INTEGER CONSTRAINT fk_incasfact_facturi 
	REFERENCES facturi(nrfact) ON DELETE RESTRICT ON UPDATE CASCADE,
    transa NUMERIC(11,2) NOT NULL,
	    CONSTRAINT pk_incasfact PRIMARY KEY (codinc, nrfact)
     ) ;

ALTER TABLE incasari ADD CONSTRAINT ck_date_incdoc CHECK (DataInc >= DataDoc) ;

