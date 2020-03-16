DROP TABLE incasari_facturi ;
DROP TABLE incasari_avans ;
DROP TABLE incasari ;
DROP TABLE facturi_comenzi ;
DROP TABLE facturi ;
DROP TABLE retururi_echipamente ;
DROP TABLE retururi_produse ;
DROP TABLE retururi ;
DROP TABLE deplasari_echipamente ;
DROP TABLE echipamente ;
DROP TABLE refuzuri_produse ;
DROP TABLE livrari_produse ;
DROP TABLE livrari ;
DROP TABLE transporturi ;
DROP TABLE angajati_comenzi ;
DROP TABLE angajati ;
DROP TABLE autovehicule ;
DROP TABLE comenzi_produse ;
DROP TABLE comenzi_anulate ;
DROP TABLE comenzi_contracte ;
DROP TABLE comenzi ;
DROP TABLE preparate ;
DROP TABLE produse ;
DROP TABLE contracte ;
DROP TABLE clienti_PJ ;
DROP TABLE clienti_PF ;
DROP TABLE clienti ;

CREATE TABLE clienti (	
	IdClient NUMERIC(7) PRIMARY KEY,
	NumeClient VARCHAR2(50) NOT NULL,
	AdresaClient VARCHAR2(100),
	LocClient VARCHAR2(30),
	JudClient CHAR(2),
	Telefon VARCHAR2(12),
	EMail VARCHAR2(50)
	) ;

CREATE TABLE clienti_PF (
	IdClient_PF NUMERIC(7) PRIMARY KEY REFERENCES clienti (IdClient),
	CNPClient NUMERIC(13) NOT NULL,
	Ocupatie VARCHAR2(30),
	Functie VARCHAR2(30)
	) ;

CREATE TABLE clienti_PJ (
	IdClient_PJ NUMERIC(7) PRIMARY KEY REFERENCES clienti (IdClient),
	CodFiscalClient VARCHAR(11) NOT NULL,
	NrAngajati NUMERIC(6),
	ProfilFirma VARCHAR2(30),
	IdPersContact NUMERIC(7) REFERENCES clienti_PF (IdClient_PF)
	) ;

CREATE TABLE contracte (
	IdContract NUMERIC(10) PRIMARY KEY,
	IdClient NUMERIC(7) NOT NULL REFERENCES clienti (IdClient),
	DataSemnContract DATE DEFAULT CURRENT_DATE NOT NULL,
	DataIntrVigContract DATE DEFAULT CURRENT_DATE NOT NULL,
	DataExpirareContract DATE,
	PeriodicitateLivrare VARCHAR2(30),
	ValMedieZilnica NUMERIC(12,2),
	NrMinimPortiiZilnice NUMERIC(4),
	NrMaximPortiiZilnice NUMERIC(4),
	RegimPlata VARCHAR2(20),
	ObsContract VARCHAR2(100)
	) ;

CREATE TABLE produse (
	IdProdus NUMERIC(10) PRIMARY KEY,
	DenProdus VARCHAR2(30) NOT NULL,
	UM VARCHAR2(15) NOT NULL,
	ClasaProdus VARCHAR2(30) NOT NULL,
	CantitateStandard NUMERIC(6,3),
	PretStandard NUMERIC (9,2),
	ApareInCatalog CHAR(1) DEFAULT 'D' NOT NULL 
		CONSTRAINT ck_apare CHECK (ApareInCatalog IN ('D','N'))
	) ;
	
CREATE TABLE preparate (
	IdProdusPreparat NUMERIC(10) NOT NULL REFERENCES produse (IdProdus),
	IdIngredient NUMERIC(10) NOT NULL REFERENCES produse (IdProdus),
	CantitateNecesara NUMERIC(6,3) DEFAULT 1 NOT NULL,
	PRIMARY KEY (IdProdusPreparat, IdIngredient) 
	) ;
	

CREATE TABLE comenzi (
	IdComanda NUMERIC(12) PRIMARY KEY,
	DataOraComanda TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	IdClient NUMERIC(7) NOT NULL REFERENCES clienti (IdClient),
	ModPreluare VARCHAR2(20) DEFAULT 'telefon' NOT NULL 
		CONSTRAINT ck_modpreluare CHECK (ModPreluare IN 
		('telefon','fax','email', 'web', 'face-to-face')),
	DataOraLivrarii TIMESTAMP NOT NULL,
	AdresaLivrare VARCHAR2(40),
	LocLicrare VARCHAR2(30),
	ModLivrare VARCHAR2(40) DEFAULT 'La domiciliul/sediul clientului',
	ValComanda NUMERIC(12,2) NOT NULL,
	DiscountComanda NUMERIC (12,2) DEFAULT 0 NOT NULL,
	ModPlata VARCHAR2(25) DEFAULT 'numerar'
	) ;
	 
CREATE TABLE comenzi_contracte (
	IdComanda NUMERIC(12) PRIMARY KEY
		REFERENCES comenzi (IdComanda),
	IdContract NUMERIC(10) NOT NULL REFERENCES contracte (IdContract)
	) ;

CREATE TABLE comenzi_anulate (
	IdCmdAnulata NUMERIC(12) PRIMARY KEY REFERENCES comenzi (IdComanda),
	DataOraAnulare TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	MotivAnulare VARCHAR2(30),
	PenalitatiAC NUMERIC(12,2) DEFAULT 0 NOT NULL 	
	) ;
	
CREATE TABLE comenzi_produse (
	IdComanda NUMERIC(12) NOT NULL REFERENCES comenzi (IdComanda),
	IdProdus NUMERIC(10) NOT NULL REFERENCES produse (IdProdus),
	CantitateComandata NUMERIC(7,3) DEFAULT 1 NOT NULL,
	PretUnitar NUMERIC(9,2) NOT NULL
	); 

CREATE TABLE autovehicule (
	IdAuto NUMERIC(5) PRIMARY KEY,
	ProducatorAuto VARCHAR2(20) NOT NULL,
	Model VARCHAR2(15) NOT NULL,
	AnFabricatie NUMERIC(4) DEFAULT EXTRACT (YEAR FROM CURRENT_DATE) NOT NULL,
	DataAchizitionarii DATE,
	ModAchizitionare VARCHAR2(25) DEFAULT 'leasing',
	ObsAuto VARCHAR2(50)
	) ;

CREATE TABLE angajati (
	CodAngajat NUMERIC(5) PRIMARY KEY,
	NumeAngajat VARCHAR2(60) NOT NULL,
	DataAngajarii DATE DEFAULT CURRENT_DATE NOT NULL,
	Post VARCHAR2(25) NOT NULL
	) ;

CREATE TABLE angajati_comenzi (
	IdAngajatComanda NUMERIC(10) PRIMARY KEY,
	CodAngajat NUMERIC(5) NOT NULL REFERENCES angajati (CodAngajat),
	IdComanda NUMERIC(12) NOT NULL REFERENCES comenzi (IdComanda),
	NrOreLucrate NUMERIC(4) NOT NULL,
	AtributiiAC VARCHAR2(30) NOT NULL,
	ObsAC VARCHAR2(50)
	) ;
	
CREATE TABLE transporturi (
	IdTransport NUMERIC(7) PRIMARY KEY,
	IdAuto NUMERIC(5) NOT NULL REFERENCES autovehicule(IdAuto),
	DataOraPlecare TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	DataOraSosire TIMESTAMP,
	CodSofer NUMERIC(5) NOT NULL REFERENCES angajati (CodAngajat),
	ObsTransport VARCHAR2(50)
	) ;
	
CREATE TABLE livrari (
	IdLivrare NUMERIC(10) PRIMARY KEY,
	DataOraLivrare TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	IdComanda NUMERIC(12) NOT NULL REFERENCES comenzi (IdComanda),
	AvizExpeditie VARCHAR2(12),
	IdTransport NUMERIC(7) REFERENCES transporturi (IdTransport),
	ObsLivrare VARCHAR2(50)
	) ;
	
CREATE TABLE livrari_produse (
	IdLivrare NUMERIC(10) NOT NULL REFERENCES livrari (IdLivrare) ,
	IdProdus NUMERIC(10) NOT NULL REFERENCES produse (IdProdus),
	CantitateLivrata NUMERIC(7,3) DEFAULT 1 NOT NULL,
	PRIMARY KEY (IdLivrare, IdProdus)
	) ;
		
CREATE TABLE refuzuri_produse (
	IdLivrare NUMERIC(10) NOT NULL REFERENCES livrari (IdLivrare) ,
	IdProdus NUMERIC(10) NOT NULL REFERENCES produse (IdProdus),
	CantitateRefuzata NUMERIC(7,3) DEFAULT 1 NOT NULL,
	MotivRefuz VARCHAR2(30) DEFAULT 'produs deteriorat' NOT NULL,
	PRIMARY KEY (IdLivrare, IdProdus)
	) ;

CREATE TABLE echipamente (
	IdEchipament NUMERIC(5) PRIMARY KEY,
	DenEchpament VARCHAR2(30) NOT NULL,
	CategEchipament VARCHAR2(40) DEFAULT 'expresoare cafea',
	Datachizionarii DATE DEFAULT CURRENT_DATE,
	ObsEchipament VARCHAR2(50)
	) ;

CREATE TABLE deplasari_echipamente (
	IdLivrare NUMERIC(10) NOT NULL REFERENCES livrari (IdLivrare) ,
	IdEchipament NUMERIC(5) NOT NULL REFERENCES echipamente (IdEchipament),
	ObsTranspEchipament VARCHAR2(50),
	PRIMARY KEY (IdLivrare, IdEchipament)
	);

CREATE TABLE retururi (
	IdRetur NUMBER(7) PRIMARY KEY,
	DataOraRetur TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CodSofer NUMERIC(5) NOT NULL REFERENCES angajati (CodAngajat),
	IdComanda NUMERIC(12) NOT NULL REFERENCES comenzi (IdComanda),
	ObsRetur VARCHAR2(50)
	) ;
	
CREATE TABLE retururi_produse (
	IdRetur NUMBER(7) NOT NULL REFERENCES retururi (IdRetur),
	IdProdus NUMERIC(10) NOT NULL REFERENCES produse (IdProdus),
	CantitateReturnata NUMBER(7,3),
	PRIMARY KEY (IdRetur, Idprodus)	
	);

CREATE TABLE retururi_echipamente (
	IdRetur NUMBER(7) NOT NULL REFERENCES retururi (IdRetur),
	IdEchipament NUMERIC(5) NOT NULL REFERENCES echipamente (IdEchipament),
	ObsReturEchipament VARCHAR2(50),
	PRIMARY KEY (IdRetur, IdEchipament)		
	);

CREATE TABLE facturi (
	IdFactura NUMERIC(10) PRIMARY KEY,
	NrFactura NUMERIC(8) NOT NULL,
	DataOraFact TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ValFactura NUMERIC(12,2),
	TVAFactura NUMERIC(11,2),
	CheltAditionaleFact NUMBER(10,2),
	DiscountFactura NUMERIC (11,2),
	DiscountFinanciar NUMERIC (10,2)
	);

CREATE TABLE facturi_comenzi (
	IdFactura NUMERIC(10) NOT NULL REFERENCES facturi (IdFactura),
	IdComanda NUMERIC(12) NOT NULL REFERENCES comenzi (IdComanda),
	SumaFacturataCmd NUMERIC (12,2) NOT NULL,		
	PRIMARY KEY (IdFactura, IdComanda) 
	) ;

CREATE TABLE incasari (
	IdIncasare NUMERIC(10) PRIMARY KEY,
	DataOraIncasare TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	TipDocIncas VARCHAR2(15)  DEFAULT 'chitanta' NOT NULL,
	SerieNrDocIncas VARCHAR2(20) NOT NULL,
	SumaIncas NUMERIC(12,2) NOT NULL
	);

CREATE TABLE incasari_avans (
	IdIncas_Avans NUMERIC(10) PRIMARY KEY REFERENCES incasari (IdIncasare),
	IdComanda NUMERIC(12) NOT NULL REFERENCES comenzi (IdComanda)
	) ;
	
CREATE TABLE incasari_facturi (
	IdIncas_Fact NUMERIC(10) NOT NULL REFERENCES incasari (IdIncasare),
	IdFactura NUMERIC(12) NOT NULL REFERENCES facturi (IdFactura),
	Transa NUMBER(12,2),
	PRIMARY KEY (IdIncas_Fact, IdFactura)
	) ;


 