
DROP TABLE IF EXISTS incasfact  ;
DROP TABLE IF EXISTS incasari  ;
DROP TABLE IF EXISTS liniifact ;
DROP TABLE IF EXISTS facturi  ;
DROP TABLE IF EXISTS produse  ;
DROP TABLE IF EXISTS persclienti  ;
DROP TABLE IF EXISTS persoane  ;
DROP TABLE IF EXISTS clienti  ;
DROP TABLE IF EXISTS coduri_postale  ;
DROP TABLE IF EXISTS judete  ;

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
    )  ;

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
    )  ;


CREATE TABLE clienti (
    codcl NUMERIC(6)
        CONSTRAINT pk_clienti PRIMARY KEY
        CONSTRAINT ck_codcl CHECK (codcl > 1000),
    dencl VARCHAR(30)
        CONSTRAINT ck_dencl CHECK (SUBSTR(dencl,1,1) = UPPER(SUBSTR(dencl,1,1))),
    codfiscal CHAR(9)
        CONSTRAINT ck_codfiscal CHECK (SUBSTR(codfiscal,1,1) = UPPER(SUBSTR(codfiscal,1,1))),
    adresa VARCHAR(40)
        CONSTRAINT ck_adresa_clienti CHECK (SUBSTR(adresa,1,1) = UPPER(SUBSTR(adresa,1,1))),
    codpost CHAR(6)
        CONSTRAINT fk_clienti_coduri_postale REFERENCES coduri_postale(codpost),
    telefon VARCHAR(10)
    )  ;


CREATE TABLE persoane (
    cnp CHAR(14)
        CONSTRAINT pk_persoane PRIMARY KEY
        CONSTRAINT ck_cnp CHECK (cnp=LTRIM(UPPER(cnp))),
    nume VARCHAR(20)
        CONSTRAINT ck_nume CHECK (nume=LTRIM(INITCAP(nume))),
    prenume VARCHAR(20)
        CONSTRAINT ck_prenume CHECK (prenume=LTRIM(INITCAP(prenume))),
     adresa VARCHAR(40)
        CONSTRAINT ck_adresa_persoane 
            CHECK (SUBSTR(adresa,1,1) = UPPER(SUBSTR(adresa,1,1))),
    sex CHAR(1) DEFAULT 'B'
        CONSTRAINT ck_sex CHECK (sex IN ('F','B')),
    codpost CHAR(6)
        CONSTRAINT fk_persoane_coduri_postale REFERENCES coduri_postale(codpost),
    telacasa VARCHAR(10),
    telbirou VARCHAR(10),
    telmobil VARCHAR(10),
    email VARCHAR(50)
    )  ;


CREATE TABLE persclienti (
    cnp CHAR(14)
        CONSTRAINT fk_persclienti_persoane REFERENCES persoane(cnp),
    codcl NUMERIC(6)
        CONSTRAINT fk_persclienti_clienti REFERENCES clienti(codcl),
    functie VARCHAR(25)
        CONSTRAINT ck_functie CHECK (SUBSTR(functie,1,1) = 
              UPPER(SUBSTR(functie,1,1))),
    CONSTRAINT pk_persclienti PRIMARY KEY (cnp, codcl, functie)
    )  ;

CREATE TABLE produse (
    codpr NUMERIC(6)
        CONSTRAINT pk_produse PRIMARY KEY
        CONSTRAINT ck_codpr CHECK (codpr > 0),
    denpr VARCHAR(30) CONSTRAINT ck_denpr
        CHECK (SUBSTR(denpr,1,1) = UPPER(SUBSTR(denpr,1,1))),
    um VARCHAR(10),
    grupa VARCHAR(15) CONSTRAINT ck_produse_grupa
        CHECK (SUBSTR(grupa,1,1) = UPPER(SUBSTR(grupa,1,1))),
    procTVA NUMERIC(2,2) DEFAULT .24
    )  ;

CREATE TABLE facturi (
    nrfact NUMERIC(8)
        CONSTRAINT pk_facturi PRIMARY KEY,
    datafact DATE DEFAULT CURRENT_DATE,
        CONSTRAINT ck_datafact CHECK 
          (datafact >= TO_DATE('01/08/2010','DD/MM/YYYY')
            AND datafact <= TO_DATE('31/12/2015','DD/MM/YYYY')),
    codcl NUMERIC(6)
        CONSTRAINT fk_facturi_clienti REFERENCES clienti(codcl) ,
    Obs VARCHAR(50) 
	)   ;


CREATE TABLE liniifact (
    nrfact NUMERIC(8)
        CONSTRAINT fk_liniifact_facturi REFERENCES facturi(nrfact),
    linie NUMERIC(2)
        CONSTRAINT ck_linie CHECK (linie > 0),
    codpr NUMERIC(6) CONSTRAINT fk_liniifact_produse REFERENCES produse(codpr),
    cantitate NUMERIC(8),
    pretunit NUMERIC (9,2),
    CONSTRAINT pk_liniifact PRIMARY KEY (nrfact,linie)
    )  ;


CREATE TABLE incasari (
    codinc NUMERIC(8)
        CONSTRAINT pk_incasari PRIMARY KEY,
    datainc DATE DEFAULT CURRENT_DATE
        CONSTRAINT ck_datainc CHECK (datainc >= TO_DATE('01/08/2010','DD/MM/YYYY')
            AND datainc <= TO_DATE('31/12/2015','DD/MM/YYYY')),
    coddoc CHAR(4)
        CONSTRAINT ck_coddoc CHECK(coddoc=UPPER(LTRIM(coddoc))),
    nrdoc VARCHAR(16),
    datadoc DATE DEFAULT CURRENT_DATE - 7
        CONSTRAINT ck_datadoc CHECK (datadoc >= TO_DATE('01/01/2010','DD/MM/YYYY')
            AND datadoc <= TO_DATE('31/12/2015','DD/MM/YYYY'))
    )  ;


CREATE TABLE incasfact (
    codinc NUMERIC(8) CONSTRAINT fk_incasfact_incasari REFERENCES incasari(codinc) ,
    nrfact NUMERIC(8) CONSTRAINT fk_incasfact_facturi REFERENCES facturi(nrfact),
    transa NUMERIC(16,2) NOT NULL,
    CONSTRAINT pk_incasfact PRIMARY KEY (codinc, nrfact)
     )  ;

