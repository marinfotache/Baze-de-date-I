
DROP TABLE IF EXISTS incasari ;
DROP TABLE IF EXISTS comenzi ;
DROP TABLE IF EXISTS continut_cosuri ;
DROP TABLE IF EXISTS cosuri ;
DROP TABLE IF EXISTS rasfoiri_produse ;
DROP TABLE IF EXISTS recomandari_prod ;
DROP TABLE IF EXISTS recomandari ;
DROP TABLE IF EXISTS sesiuni_autentificate ;
DROP TABLE IF EXISTS sesiuni ;
DROP TABLE IF EXISTS adrese_IP ;
DROP TABLE IF EXISTS categorii_favorite ;
DROP TABLE IF EXISTS clienti ;
DROP TABLE IF EXISTS proprietati_produse ;
DROP TABLE IF EXISTS produse ;
DROP TABLE IF EXISTS proprietati_categorii ;
DROP TABLE IF EXISTS proprietati ;
DROP TABLE IF EXISTS categorii ;

CREATE TABLE categorii (
	IdCategorie INTEGER PRIMARY KEY,
	DenCategorie VARCHAR(50) NOT NULL,
	DescrCategorie VARCHAR(300),
	IdCategSuperioara INTEGER CONSTRAINT ref_categ_super REFERENCES categorii (IdCategorie)
	) ;

CREATE TABLE proprietati (
	IdProprietate INTEGER PRIMARY KEY,
	DenPropr VARCHAR(70) NOT NULL,
	ObsPropr VARCHAR(100) 
	) ;
	
CREATE TABLE proprietati_categorii (
	IdCategorie INTEGER 
		NOT NULL 
		CONSTRAINT ref_propr_categ_categ REFERENCES categorii (IdCategorie),
	IdProprietate INTEGER NOT NULL CONSTRAINT ref_propr_categ_propr REFERENCES proprietati (IdProprietate),
	ModSpecificare CHAR(1) DEFAULT 'O' NOT NULL CONSTRAINT ck_modspecif CHECK ( ModSpecificare IN ('O', 'F')),
	PRIMARY KEY (IdCategorie, IdProprietate)
	) ;
	
CREATE TABLE produse (
	IdProdus INTEGER PRIMARY KEY,
	DenProd VARCHAR(100) NOT NULL,
	UM VARCHAR(20),
	PretUnitarCrt NUMERIC (10,2),
	DataIntrodCatalog DATE DEFAULT CURRENT_DATE NOT NULL,
	DataStergereCatalog DATE,
	IdCategorieProdus INTEGER NOT NULL CONSTRAINT ref_produse_categ REFERENCES categorii (IdCategorie)
	) ;
	 
CREATE TABLE proprietati_produse (
	IdProdus INTEGER NOT NULL CONSTRAINT ref_propr_produse_produse REFERENCES produse (IdProdus),
	IdProprietate INTEGER NOT NULL CONSTRAINT ref_propr_produse_propr REFERENCES proprietati (IdProprietate),
	Valoare_Propr_Produs VARCHAR(100),
	PRIMARY KEY (IdProdus, IdProprietate) 
	) ;

CREATE TABLE clienti (
	IdClient INTEGER PRIMARY KEY,
	NumeCl VARCHAR(60) NOT NULL,
	AdresaCl VARCHAR(90),
	LocCl VARCHAR(35) NOT NULL,
	TaraCl VARCHAR(25) DEFAULT 'Romania' NOT NULL ,
	EMailCl VARCHAR(50) CONSTRAINT ck_emailcl CHECK (EmailCl LIKE '%@%.%'),
	TelCl VARCHAR(15),	
	Sex CHAR(1) DEFAULT 'F' NOT NULL CONSTRAINT ck_sex CHECK (Sex IN ('F', 'B')),
	DataNast DATE,
	UserCl VARCHAR(30) NOT NULL CONSTRAINT un_usercl UNIQUE,	
	pswdCl VARCHAR(30) NOT NULL
	) ;

CREATE TABLE categorii_favorite (
	IdClient INTEGER NOT NULL CONSTRAINT ref_categ_fav_clienti REFERENCES clienti (IdClient),
	CategFavor_Nr SMALLINT DEFAULT 1 NOT NULL,
	IdCateg_Favor INTEGER NOT NULL CONSTRAINT ref_categ_fav_categ REFERENCES categorii (IdCategorie),
	PRIMARY KEY (IdClient, CategFavor_Nr)
	) ;

CREATE TABLE adrese_IP (
	Adresa_IP VARCHAR(20)PRIMARY KEY,
	Loc_adresa_IP VARCHAR(25) NOT NULL,
	Tara_adresa_IP VARCHAR(25) DEFAULT 'Romania' NOT NULL
	) ;

CREATE TABLE sesiuni (
	IdSesiune INTEGER PRIMARY KEY,
	DataOraIncepSes TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	DataOraFinalizSes TIMESTAMP,
	Adresa_IP VARCHAR(20) NOT NULL CONSTRAINT ref_ses_adrese_ip REFERENCES adrese_IP (Adresa_IP),
	CONSTRAINT ck_sesiuni_ore CHECK 
		(DataOraIncepSes <= COALESCE(DataOraFinalizSes, CURRENT_TIMESTAMP ))
	);

CREATE TABLE sesiuni_autentificate (
	IdSesiune INTEGER NOT NULL PRIMARY KEY CONSTRAINT ref_ses_autent_sesiuni REFERENCES sesiuni (IdSesiune),
	IdClient INTEGER NOT NULL CONSTRAINT ref_ses_autentif_clienti REFERENCES clienti (IdClient)
	);
	
CREATE TABLE recomandari (
	IdRecomandare INTEGER PRIMARY KEY,
	IdSesiune INTEGER NOT NULL CONSTRAINT ref_recom_sesiuni REFERENCES sesiuni (IdSesiune)
	 );

CREATE TABLE recomandari_prod (
	IdRecomandare INTEGER NOT NULL CONSTRAINT ref_recom_prod_recom REFERENCES recomandari (IdRecomandare),
	Recomandare_Nr SMALLINT DEFAULT 1 NOT NULL,
	IdProd_Recomandat INTEGER NOT NULL CONSTRAINT ref_recom_produse_produse REFERENCES produse (IdProdus),
	PRIMARY KEY (IdRecomandare, Recomandare_Nr)
	 );

CREATE TABLE rasfoiri_produse (
	IdRasfoireProd INTEGER PRIMARY KEY,
	IdSesiune INTEGER NOT NULL CONSTRAINT ref_rasf_prod_sesiuni REFERENCES sesiuni (IdSesiune),
	DataOraIncepRasf TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	DataOraFinalizRasf TIMESTAMP NOT NULL,
	IdProdus INTEGER NOT NULL CONSTRAINT ref_recom_produse_produse REFERENCES produse (IdProdus)
	) ;

CREATE TABLE cosuri (
	IdCos INTEGER PRIMARY KEY,
	DataOraInitializareCos TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	DataOraFinalizareCos TIMESTAMP NOT NULL,
	IdSesiune INTEGER NOT NULL CONSTRAINT ref_cosuri_sesiuni REFERENCES sesiuni (IdSesiune)
	) ;

CREATE TABLE continut_cosuri (
	IdCos INTEGER NOT NULL CONSTRAINT ref_continut_cos_cos REFERENCES cosuri (IdCos),
	IdProdus INTEGER NOT NULL CONSTRAINT ref_continut_cos_prod REFERENCES produse (IdProdus),
	CantitateCos NUMERIC(6) DEFAULT 1,
	PretUnitarCos NUMERIC (12,2),
	PRIMARY KEY (IdCos, IdProdus)
	) ;	

CREATE TABLE comenzi (
	IdComanda INTEGER PRIMARY KEY,
	IdCos INTEGER NOT NULL CONSTRAINT ref_continut_cos_cos REFERENCES cosuri (IdCos)
	) ;

CREATE TABLE incasari (
	IdIncasare INTEGER PRIMARY KEY,
	DataOraIncasare TIMESTAMP NOT NULL,
	IdComanda INTEGER NOT NULL CONSTRAINT ref_incas_comenzi REFERENCES comenzi (IdComanda),
	SumaIncasata NUMERIC(14,2)
	) ;
	
	

