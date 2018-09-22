DROP TABLE triaj ;
DROP TABLE pacienti ;
DROP TABLE garzi ;
DROP TABLE doctori ;

CREATE TABLE doctori (
  iddoctor NUMBER(8) CONSTRAINT pk_doctori PRIMARY KEY,
  numedoctor VARCHAR2(50) NOT NULL,
  specialitate VARCHAR2(40) NOT NULL,
  datanasterii DATE
  );

CREATE TABLE garzi (
  iddoctor NUMBER(8) NOT NULL REFERENCES doctori (iddoctor),
  inceput_garda TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  sfirsit_garda TIMESTAMP,
  CONSTRAINT pk_garzi PRIMARY KEY (iddoctor, inceput_garda)
  ) ;

CREATE TABLE pacienti (
  idpacient NUMBER(10) CONSTRAINT pk_pacienti PRIMARY KEY,
  numepacient VARCHAR2(60),
  CNP NUMBER(13),
  adresa VARCHAR2(100),
  loc VARCHAR2(30),
  judet CHAR(2),
  tara VARCHAR2(30) DEFAULT 'Romania',
  serie_nr_act_identitate VARCHAR2(20)
  ); 
  
CREATE TABLE triaj (
  idexaminare NUMBER(12) CONSTRAINT pk_internari PRIMARY KEY,
  dataora_examinare TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  idpacient NUMBER(10) NOT NULL CONSTRAINT fk_internari_pacienti
    REFERENCES pacienti (idpacient),
  simptome VARCHAR2(500) NOT NULL,
  tratament_imediat VARCHAR2(500),
  sectie_destinatie VARCHAR2(30)
  );  

