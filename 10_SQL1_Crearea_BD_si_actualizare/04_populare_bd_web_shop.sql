
DELETE FROM incasari;
DELETE FROM comenzi;
DELETE FROM continut_cosuri;
DELETE FROM cosuri;
DELETE FROM rasfoiri_produse;
DELETE FROM recomandari_prod;
DELETE FROM recomandari;
DELETE FROM sesiuni_autentificate;
DELETE FROM sesiuni;
DELETE FROM adrese_IP;
DELETE FROM categorii_favorite ;
DELETE FROM clienti;
DELETE FROM proprietati_produse ;
DELETE FROM produse ;
DELETE FROM proprietati_categorii ;
DELETE FROM proprietati ;
DELETE FROM categorii ;

INSERT INTO categorii VALUES (101, 'CD', 'Compact discuri cu muzica', NULL) ;

INSERT INTO categorii VALUES (201, 'carti', 'carti in toate formatele (tiparite, electronice...)', NULL) ;
INSERT INTO categorii VALUES (202, 'carti tiparite', 'paperback si hardcover', 201) ;
INSERT INTO categorii VALUES (203, 'eBook', 'carti in format electronic', 201) ;
INSERT INTO categorii VALUES (204, 'audiobook', 'carti in format audio', 201) ;

INSERT INTO categorii VALUES (301, 'DVD', 'DVD-uri....', NULL) ;
INSERT INTO categorii VALUES (302, 'DVD educational', 'DVD-uri cu lectii, soft-uri educationale, cursuri', 301) ;
INSERT INTO categorii VALUES (303, 'software pe DVD ', 'sisteme de operare, aplicatii Office etc', 301) ;
INSERT INTO categorii VALUES (304, 'filme pe DVD', 'documentare, artistice', 301) ;
INSERT INTO categorii VALUES (305, 'muzica pe DVD', 'concerte', 301) ;
INSERT INTO categorii VALUES (306, 'filme artistice pe DVD', 'au distributie, regizori, producatori...', 304) ;


INSERT INTO categorii VALUES (401, 'calculatoare', 'PC-uri, Laptop-uri etc...', NULL) ;
INSERT INTO categorii VALUES (402, 'desktop', 'calculatoare de tip desktop', 401) ;
INSERT INTO categorii VALUES (403, 'laptop, notebook', 'laptop-ri, notebook-uri', 401) ;
INSERT INTO categorii VALUES (404, 'tabletPC', 'iPad-uri...', 401) ;

INSERT INTO categorii VALUES (501, 'periferice', 'imprimante, HDD-uri externe ....', NULL) ;
INSERT INTO categorii VALUES (502, 'imprimante', 'cu laser, jet de cerneala...', 501) ;
INSERT INTO categorii VALUES (503, 'imprimante cu laser', '...', 502) ;
INSERT INTO categorii VALUES (504, 'imprimante cu jet de cerneala', '...', 502) ;
INSERT INTO categorii VALUES (505, 'imprimante cu ace (matriciale)', '...', 502) ;
INSERT INTO categorii VALUES (511, 'HDD externe', 'hard discuri externe', 501) ;
INSERT INTO categorii VALUES (521, 'memorii flash', 'memorii flash', 501) ;
INSERT INTO categorii VALUES (531, 'eReadere', 'cititoare de documente pe baza tehnologiei eInk', 501) ;
INSERT INTO categorii VALUES (541, 'GPS', 'gps-uri', 501) ;


INSERT INTO proprietati VALUES (1001, 'Autori', 'se acepta valori neatomice, ex: Prutianu, S., Munteanu, C...' ) ;
INSERT INTO proprietati VALUES (1002, 'Titlu', '...pentru carti, cd-uri...' ) ;
INSERT INTO proprietati VALUES (1003, 'Denumire', '...pentru alte categorii decit carti si cd-uri' ) ;
INSERT INTO proprietati VALUES (1004, 'AnAparitie', NULL ) ;
INSERT INTO proprietati VALUES (1005, 'TipCoperta', 'pentru carti' ) ;
INSERT INTO proprietati VALUES (1006, 'DimensiuniCoperta', 'pentru carti' ) ;
INSERT INTO proprietati VALUES (1007, 'Numar pagini', 'pentru carti' ) ;
INSERT INTO proprietati VALUES (1008, 'Editura', 'pentru carti' ) ;
INSERT INTO proprietati VALUES (1009, 'Marime fisier in MB', null ) ;
INSERT INTO proprietati VALUES (1010, 'Marime memorie (RAM)', null ) ;
INSERT INTO proprietati VALUES (1011, 'Durata', null ) ;
INSERT INTO proprietati VALUES (1012, 'Format de inregistrare', null ) ;
INSERT INTO proprietati VALUES (1013, 'Greutate', null ) ;
INSERT INTO proprietati VALUES (1014, 'Distributie', 'pentru filme, se acepta valori neatomice...' ) ;
INSERT INTO proprietati VALUES (1015, 'Regizori', 'pentru filme, se acepta valori neatomice...' ) ;
INSERT INTO proprietati VALUES (1016, 'Producatori', 'pentru filme, se acepta valori neatomice...' ) ;
INSERT INTO proprietati VALUES (1017, 'Tip procesor', 'pentru calculatoare, in principal' ) ;
INSERT INTO proprietati VALUES (1018, 'Frecventa (viteza) procesor', 'pentru calculatoare...' ) ;
INSERT INTO proprietati VALUES (1019, 'Diagonala ecran (in cm)', 'pentru calculatoare...' ) ;
INSERT INTO proprietati VALUES (1020, 'Nr de pagini tiparite pe minut', 'pt. imprimante' ) ;
INSERT INTO proprietati VALUES (1021, 'Tip afisare/tiparire', 'doua valori: B/W si COLOR' ) ;
INSERT INTO proprietati VALUES (1022, 'Numar piese', 'pt. CD-uri, DVD-uri cu muzica' ) ;
INSERT INTO proprietati VALUES (1023, 'Regiune', 'pt. DVD-uri' ) ;
INSERT INTO proprietati VALUES (1024, 'Compania-producator', 'pt. software, CD-uri' ) ;


INSERT INTO proprietati_categorii  VALUES (101, 1001, 'O') ;
INSERT INTO proprietati_categorii  VALUES (101, 1002, 'O') ;
INSERT INTO proprietati_categorii  VALUES (101, 1003, 'O') ;
INSERT INTO proprietati_categorii  VALUES (101, 1011, 'O') ;
INSERT INTO proprietati_categorii  VALUES (101, 1012, 'O') ;
INSERT INTO proprietati_categorii  VALUES (101, 1022, 'O') ;

INSERT INTO proprietati_categorii  VALUES (201, 1001, 'O') ;
INSERT INTO proprietati_categorii  VALUES (201, 1002, 'O') ;
INSERT INTO proprietati_categorii  VALUES (201, 1004, 'O') ;
INSERT INTO proprietati_categorii  VALUES (202, 1005, 'O') ;
INSERT INTO proprietati_categorii  VALUES (202, 1006, 'O') ;
INSERT INTO proprietati_categorii  VALUES (201, 1007, 'O') ;
INSERT INTO proprietati_categorii  VALUES (201, 1008, 'O') ;

INSERT INTO proprietati_categorii  VALUES (203, 1009, 'F') ;
INSERT INTO proprietati_categorii  VALUES (203, 1012, 'O') ;

INSERT INTO proprietati_categorii  VALUES (204, 1012, 'O') ;

INSERT INTO proprietati_categorii  VALUES (301, 1001, 'O') ;
INSERT INTO proprietati_categorii  VALUES (301, 1011, 'O') ;
INSERT INTO proprietati_categorii  VALUES (301, 1023, 'O') ;

INSERT INTO proprietati_categorii  VALUES (302, 1024, 'O') ;
INSERT INTO proprietati_categorii  VALUES (303, 1024, 'O') ;


INSERT INTO proprietati_categorii  VALUES (304, 1015, 'O') ;   -- regizori, pentru toate categoriile de filme

INSERT INTO proprietati_categorii  VALUES (305, 1022, 'O') ;   -- nr piese, pt DVD cu muzica

INSERT INTO proprietati_categorii  VALUES (306, 1014, 'O') ;  -- distributie, pt. filme artistice
INSERT INTO proprietati_categorii  VALUES (306, 1016, 'O') ;  -- producatori, pt. filme artistice

INSERT INTO proprietati_categorii  VALUES (401, 1010, 'O') ;  -- Marime memorie (RAM), pt. calculatoare
INSERT INTO proprietati_categorii  VALUES (401, 1017, 'O') ;  --tip  procesor, pt. calculatoare
INSERT INTO proprietati_categorii  VALUES (401, 1018, 'O') ;  -- frecventa procesor, pt. calculatoare
INSERT INTO proprietati_categorii  VALUES (401, 1019, 'O') ;  -- diagonala ecran, pt. calculatoare

INSERT INTO proprietati_categorii  VALUES (403, 1013, 'O') ;  -- greutate
INSERT INTO proprietati_categorii  VALUES (404, 1013, 'O') ;  -- greutate

INSERT INTO proprietati_categorii  VALUES (502, 1020, 'O') ;  -- numar de pagini tiparite pe minut - imprimante
INSERT INTO proprietati_categorii  VALUES (502, 1021, 'O') ;  -- tip afisare/tiparire- imprimante

INSERT INTO proprietati_categorii  VALUES (503, 1010, 'O') ;  -- memorie - imprimante cu laser
INSERT INTO proprietati_categorii  VALUES (504, 1010, 'O') ;  -- memorie - imprimante cu jet de cerneala

INSERT INTO proprietati_categorii  VALUES (511, 1010, 'O') ;  -- memorie - HDD externe
INSERT INTO proprietati_categorii  VALUES (521, 1010, 'O') ;  -- memorie - memorii flash
INSERT INTO proprietati_categorii  VALUES (531, 1010, 'O') ;  -- memorie - eReadere
INSERT INTO proprietati_categorii  VALUES (531, 1019, 'O') ;  -- Diagonala ecran - eReadere


-- primul produs este o carte: The Fifth Discipline scrisa de Peter Senge
INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (10011, 'The Fifth Discipline', 'buc', 42, 202) ;

-- proprietatile cartii The Fifth Discipline
INSERT INTO proprietati_produse VALUES (10011, 1001, 'Peter Senge') ;
INSERT INTO proprietati_produse VALUES (10011, 1002, 
	'The Fifth Discipline: The Art & Practice of The LO') ;
INSERT INTO proprietati_produse VALUES (10011, 1004, '2006') ;
INSERT INTO proprietati_produse VALUES (10011, 1005, 'Paperback') ;
INSERT INTO proprietati_produse VALUES (10011, 1006, '9 x 6.3 x 1.2 inches') ;
INSERT INTO proprietati_produse VALUES (10011, 1007, '445') ;
INSERT INTO proprietati_produse VALUES (10011, 1008, 'Broadway Business') ;


-- al doilea produs este un CD, Revolver, al formatiei Beatles
INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (10012, 'Revolver - Beatles - 1966 (remastered)', 'buc', 60, 101) ;

-- proprietati CD, Revolver, al formatiei Beatles
INSERT INTO proprietati_produse VALUES (10012, 1001, 'The Beatles') ;
INSERT INTO proprietati_produse VALUES (10012, 1002, 
	'Revolver (remastered)') ;
INSERT INTO proprietati_produse VALUES (10012, 1004, '1966/2009') ;
INSERT INTO proprietati_produse VALUES (10012, 1011, '45:00') ;
INSERT INTO proprietati_produse VALUES (10012, 1012, 'Audio CD') ;
INSERT INTO proprietati_produse VALUES (10012, 1022, '13') ;
INSERT INTO proprietati_produse VALUES (10012, 1024, 'EMI') ;


-- al 3-lea produs - carte: SQL. Dialecte DB2, Oracle, PostgreSQL si SQL Server (scuzati alaturarea cu produse celebre)
INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (10013, 'SQL. Dialecte DB2, Oracle, PostgreSQL si SQL Server', 'buc', 82, 202) ;

-- proprietatile cartii SQL
INSERT INTO proprietati_produse VALUES (10013, 1001, 'Marin Fotache') ;
INSERT INTO proprietati_produse VALUES (10013, 1002, 
	'SQL. Dialecte DB2, Oracle, PostgreSQL si SQL Server') ;
INSERT INTO proprietati_produse VALUES (10013, 1004, '2009') ;
INSERT INTO proprietati_produse VALUES (10013, 1005, 'Hardcover') ;
INSERT INTO proprietati_produse VALUES (10013, 1006, '160 x 235') ;
INSERT INTO proprietati_produse VALUES (10013, 1007, '880') ;
INSERT INTO proprietati_produse VALUES (10013, 1008, 'Polirom') ;


INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
		VALUES (5001, 'Master of Puppets', 'buc', 49, 101) ;

INSERT INTO proprietati_produse VALUES (5001, '1001', 'Metallica') ;
INSERT INTO proprietati_produse VALUES (5001, '1002', 'Master of Puppets') ;
INSERT INTO proprietati_produse VALUES (5001, '1003', 'Master of Puppets') ;
INSERT INTO proprietati_produse VALUES (5001, '1011', '46:36') ;
INSERT INTO proprietati_produse VALUES (5001, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5001, '1022', '8') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5002, 'The Wall', 'buc', 54, 101) ;

INSERT INTO proprietati_produse VALUES (5002, '1001', 'Pink Floyd') ;
INSERT INTO proprietati_produse VALUES (5002, '1002', 'The Wall') ;
INSERT INTO proprietati_produse VALUES (5002, '1003', 'The Wall') ;
INSERT INTO proprietati_produse VALUES (5002, '1011', '79') ;
INSERT INTO proprietati_produse VALUES (5002, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5002, '1022', '26') ;


INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5003, 'Highway to Hell', 'buc', 44, 101) ;

INSERT INTO proprietati_produse VALUES (5003, '1001', 'AC/DC') ;
INSERT INTO proprietati_produse VALUES (5003, '1002', 'Highway to Hell') ;
INSERT INTO proprietati_produse VALUES (5003, '1003', 'Highway to Hell') ;
INSERT INTO proprietati_produse VALUES (5003, '1011', '40') ;
INSERT INTO proprietati_produse VALUES (5003, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5003, '1022', '10') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5004, 'Sultans of Swing', 'buc', 49, 101) ;

INSERT INTO proprietati_produse VALUES (5004, '1001', 'Dire Straits') ;
INSERT INTO proprietati_produse VALUES (5004, '1002', 'Sultans of Swing: The Very Best of Dire Straits') ;
INSERT INTO proprietati_produse VALUES (5004, '1003', 'Sultans of Swing') ;
INSERT INTO proprietati_produse VALUES (5004, '1011', '77') ;
INSERT INTO proprietati_produse VALUES (5004, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5004, '1022', '16') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5005, 'Greatest Hits', 'buc', 59, 101) ;

INSERT INTO proprietati_produse VALUES (5005, '1001', 'Queen') ;
INSERT INTO proprietati_produse VALUES (5005, '1002', 'Greatest Hits Volumes 1 & 2') ;
INSERT INTO proprietati_produse VALUES (5005, '1003', 'Greatest Hits') ;
INSERT INTO proprietati_produse VALUES (5005, '1011', '67') ;
INSERT INTO proprietati_produse VALUES (5005, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5005, '1022', '20') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5006, 'Nevermind', 'buc', 39, 101) ;

INSERT INTO proprietati_produse VALUES (5006, '1001', 'Nirvana') ;
INSERT INTO proprietati_produse VALUES (5006, '1002', 'Nevermind') ;
INSERT INTO proprietati_produse VALUES (5006, '1003', 'Nevermind') ;
INSERT INTO proprietati_produse VALUES (5006, '1011', '43') ;
INSERT INTO proprietati_produse VALUES (5006, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5006, '1022', '12') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5007, 'Music for the Masses', 'buc', 42, 101) ;

INSERT INTO proprietati_produse VALUES (5007, '1001', 'Depeche Mode') ;
INSERT INTO proprietati_produse VALUES (5007, '1002', 'Music for the Masses') ;
INSERT INTO proprietati_produse VALUES (5007, '1003', 'Music for the Masses') ;
INSERT INTO proprietati_produse VALUES (5007, '1011', '61') ;
INSERT INTO proprietati_produse VALUES (5007, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5007, '1022', '14') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5008, 'Sting in the tail', 'buc', 52, 101) ;

INSERT INTO proprietati_produse VALUES (5008, '1001', 'Scorpions') ;
INSERT INTO proprietati_produse VALUES (5008, '1002', 'Sting in the tail') ;
INSERT INTO proprietati_produse VALUES (5008, '1003', 'Sting in the tail') ;
INSERT INTO proprietati_produse VALUES (5008, '1011', '43') ;
INSERT INTO proprietati_produse VALUES (5008, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5008, '1022', '11') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5009, 'Forever Faithless', 'buc', 41, 101) ;

INSERT INTO proprietati_produse VALUES (5009, '1001', 'Faithless') ;
INSERT INTO proprietati_produse VALUES (5009, '1002', 'Forever Faithless: The Greatest Hits') ;
INSERT INTO proprietati_produse VALUES (5009, '1003', 'Forever Faithless: The Greatest Hits') ;
INSERT INTO proprietati_produse VALUES (5009, '1011', '77') ;
INSERT INTO proprietati_produse VALUES (5009, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5009, '1022', '16') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5010, 'Joshua Tree', 'buc', 55, 101) ;

INSERT INTO proprietati_produse VALUES (5010, '1001', 'U2') ;
INSERT INTO proprietati_produse VALUES (5010, '1002', 'Joshua Tree: Deluxe Edition 2CD') ;
INSERT INTO proprietati_produse VALUES (5010, '1003', 'Joshua Tree: Deluxe Edition 2CD') ;
INSERT INTO proprietati_produse VALUES (5010, '1011', '1987') ;
INSERT INTO proprietati_produse VALUES (5010, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5010, '1022', '18') ;


INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) VALUES (5011, 'Best of', 'buc', 55, 101) ;

INSERT INTO proprietati_produse VALUES (5011, '1001', 'The Cardigans') ;
INSERT INTO proprietati_produse VALUES (5011, '1002', 'Best of') ;
INSERT INTO proprietati_produse VALUES (5011, '1003', 'Best of') ;
INSERT INTO proprietati_produse VALUES (5011, '1011', '67') ;
INSERT INTO proprietati_produse VALUES (5011, '1012', 'audio') ;
INSERT INTO proprietati_produse VALUES (5011, '1022', '20') ;



INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (4001,  'Pe aripile vantului', 'buc', 50, 304) ;
INSERT INTO proprietati_produse VALUES (4001, 1011,'2h' );
INSERT INTO proprietati_produse VALUES (4001, 1013,'50g' );
INSERT INTO proprietati_produse VALUES (4001, 1009,'785MB' );
INSERT INTO proprietati_produse VALUES (4001, 1015,'Ion Popa' );
INSERT INTO proprietati_produse VALUES (4001, 1016,'Broadway' );

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (4002,  'Crusing', 'buc', 30, 304) ;
INSERT INTO proprietati_produse VALUES (4002, 1011,'2h' );
INSERT INTO proprietati_produse VALUES (4002, 1013,'50g' );
INSERT INTO proprietati_produse VALUES (4002, 1009,'800MB' );
INSERT INTO proprietati_produse VALUES (4002, 1015,'Marian Teodorache' );
INSERT INTO proprietati_produse VALUES (4002, 1016,'CinemaFilm' );

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (4003,  'Notebook', 'buc', 70, 304) ;
INSERT INTO proprietati_produse VALUES (4003, 1011,'2h15m' );
INSERT INTO proprietati_produse VALUES (4003, 1013,'70g' );
INSERT INTO proprietati_produse VALUES (4003, 1009,'790MB' );
INSERT INTO proprietati_produse VALUES (4003, 1015,'Violeta Sulic' );
INSERT INTO proprietati_produse VALUES (4003, 1016,'ProCinema' );

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (4004,  'Twilight', 'buc', 75, 304) ;
INSERT INTO proprietati_produse VALUES (4004, 1011,'2h20m' );
INSERT INTO proprietati_produse VALUES (4004, 1013,'65g' );
INSERT INTO proprietati_produse VALUES (4004, 1009,'815MB' );
INSERT INTO proprietati_produse VALUES (4004, 1015,'Teodora Anton ' );
INSERT INTO proprietati_produse VALUES (4004, 1016,'ProCinema' );


INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (3001, 'Laptop Apple MacBook Pro 13', 'buc', 4999, 403);
INSERT INTO proprietati_produse  VALUES (3001, 1010, '4GB');
INSERT INTO proprietati_produse  VALUES (3001, 1017, 'Intel Core 2 Duo');
INSERT INTO proprietati_produse  VALUES (3001, 1018, '2400MHz');
INSERT INTO proprietati_produse  VALUES (3001, 1019, '13.3 inch');
INSERT INTO proprietati_produse  VALUES (3001, 1013, '2,94 kg');

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (3002, 'Laptop HP Compaq 610', 'buc', 1899, 403);
INSERT INTO proprietati_produse  VALUES (3002, 1010, '3GB');
INSERT INTO proprietati_produse  VALUES (3002, 1017, 'Intel Core 2 Duo');
INSERT INTO proprietati_produse  VALUES (3002, 1018, '2000MHz');
INSERT INTO proprietati_produse  VALUES (3002, 1019, '15.6 inch');
INSERT INTO proprietati_produse  VALUES (3002, 1013, '2,59 kg');

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (3003, 'Laptop Asus K50IJ-SX285L', 'buc', 1899, 403);
INSERT INTO proprietati_produse  VALUES (3003, 1010, '4GB');
INSERT INTO proprietati_produse  VALUES (3003, 1017, 'Intel Pentium Dual Core');
INSERT INTO proprietati_produse  VALUES (3003, 1018, '2200MHz');
INSERT INTO proprietati_produse  VALUES (3003, 1019, '15.6 inch');
INSERT INTO proprietati_produse  VALUES (3003, 1013, '2,6 kg');


INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (3004, 'Laptop Sony Vaio VGN-NW320F/T', 'buc', 2799, 403);
INSERT INTO proprietati_produse  VALUES (3004, 1010, '8GB');
INSERT INTO proprietati_produse  VALUES (3004, 1017, 'Intel Core 2 Duo');
INSERT INTO proprietati_produse  VALUES (3004, 1018, '2500MHz');
INSERT INTO proprietati_produse  VALUES (3004, 1019, '15.6 inch');
INSERT INTO proprietati_produse  VALUES (3004, 1013, '2,6 kg');

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (3005, 'Laptop HP ProBook 4520s', 'buc', 2499, 403);
INSERT INTO proprietati_produse  VALUES (3005, 1010, '3GB');
INSERT INTO proprietati_produse  VALUES (3005, 1017, 'Intel CoreTM i3');
INSERT INTO proprietati_produse  VALUES (3005, 1018, '2130MHz');
INSERT INTO proprietati_produse  VALUES (3005, 1019, '15.6 inch');
INSERT INTO proprietati_produse  VALUES (3005, 1013, '2,39 kg');

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (3006, 'Laptop Acer Extensa', 'buc', 1699, 403);
INSERT INTO proprietati_produse  VALUES (3006, 1010, '4GB');
INSERT INTO proprietati_produse  VALUES (3006, 1017, 'Intel Pentium Dual Core');
INSERT INTO proprietati_produse  VALUES (3006, 1018, '2200MHz');
INSERT INTO proprietati_produse  VALUES (3006, 1019, '15.6 inch');
INSERT INTO proprietati_produse  VALUES (3006, 1013, '2,5 kg');


INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (2001, 'Baze de date Marketing', 'buc', 35, 202) ;
INSERT INTO proprietati_produse VALUES (2001,1001,'Marin Fotache') ;
INSERT INTO proprietati_produse VALUES (2001,1002,'Baze de date in marketing') ;
INSERT INTO proprietati_produse VALUES (2001,1004,'2008') ;
INSERT INTO proprietati_produse VALUES (2001,1005,'Paper back') ;
INSERT INTO proprietati_produse VALUES (2001,1006,'16*20*2') ;
INSERT INTO proprietati_produse VALUES (2001,1007,'145') ;
INSERT INTO proprietati_produse VALUES (2001,1008,'Editura Polirom') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (2002, 'Analiza financiara', 'buc', 24, 202) ;
INSERT INTO proprietati_produse VALUES (2002,1001,'Sorin Anton') ;
INSERT INTO proprietati_produse VALUES (2002,1002,'Analiza finaciara') ;
INSERT INTO proprietati_produse VALUES (2002,1004,'2009') ;
INSERT INTO proprietati_produse VALUES (2002,1005,'Paper back') ;
INSERT INTO proprietati_produse VALUES (2002,1006,'18*22*3') ;
INSERT INTO proprietati_produse VALUES (2002,1007,'182') ;
INSERT INTO proprietati_produse VALUES (2002,1008,'Editura Polirom') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (2003, 'Relatii Publice', 'buc', 42, 202) ;
INSERT INTO proprietati_produse VALUES (2003,1001,'Zait Adriana') ;
INSERT INTO proprietati_produse VALUES (2003,1002,'Relatii Publice') ;
INSERT INTO proprietati_produse VALUES (2003,1004,'2007') ;
INSERT INTO proprietati_produse VALUES (2003,1005,'Paper back') ;
INSERT INTO proprietati_produse VALUES (2003,1006,'18*20*3') ;
INSERT INTO proprietati_produse VALUES (2003,1007,'105') ;
INSERT INTO proprietati_produse VALUES (2003,1008,'Editura Polirom') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (2004, 'Publicitate', 'buc', 50, 202) ;
INSERT INTO proprietati_produse VALUES (2004,1001,'Corneliu Munteanu') ;
INSERT INTO proprietati_produse VALUES (2004,1002,'Carte de publicitate') ;
INSERT INTO proprietati_produse VALUES (2004,1004,'2006') ;
INSERT INTO proprietati_produse VALUES (2004,1005,'Paper back') ;
INSERT INTO proprietati_produse VALUES (2004,1006,'15*25*3') ;
INSERT INTO proprietati_produse VALUES (2004,1007,'245') ;
INSERT INTO proprietati_produse VALUES (2004,1008,'Editura Comotor') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (2005, 'Cercetari de marketing', 'buc', 30, 202) ;
INSERT INTO proprietati_produse VALUES (2005,1001,'Tudor Jijie') ;
INSERT INTO proprietati_produse VALUES (2005,1002,'Cercetari de marketing') ;
INSERT INTO proprietati_produse VALUES (2005,1004,'2008') ;
INSERT INTO proprietati_produse VALUES (2005,1005,'Paper back') ;
INSERT INTO proprietati_produse VALUES (2005,1006,'15*20*3') ;
INSERT INTO proprietati_produse VALUES (2005,1007,'145') ;
INSERT INTO proprietati_produse VALUES (2005,1008,'Editura Studius ') ;

INSERT INTO produse (IdProdus, DenProd, UM, PretUnitarCrt, IdCategorieProdus) 
	VALUES (2006, 'Marketing', 'buc', 20, 202) ;
INSERT INTO proprietati_produse VALUES (2006,1001,'Emil Maxim') ;
INSERT INTO proprietati_produse VALUES (2006,1002,'Marketing') ;
INSERT INTO proprietati_produse VALUES (2006,1004,'2005') ;
INSERT INTO proprietati_produse VALUES (2006,1005,'Paper back') ;
INSERT INTO proprietati_produse VALUES (2006,1006,'15*25*3') ;
INSERT INTO proprietati_produse VALUES (2006,1007,'175') ;
INSERT INTO proprietati_produse VALUES (2006,1008,'Editura Alunel ') ;



-- blanari,lupu,para, petrea

INSERT INTO clienti (IdClient, NumeCl, AdresaCl, LocCl,TaraCl, EMailCl, TelCl, Sex, DataNast, UserCl, pswdCl) 
VALUES (501, 'Ionescu George', 'Str. Frumoasa nr.1', 'Iasi', 'Romania', 'ionescu.george@yahoo.com', '0746736263', 'B', date'1987-03-21', 'ionescugeorge', 'qwert');
INSERT INTO clienti (IdClient, NumeCl,AdresaCl,LocCl,TaraCl,EMailCl,TelCl, Sex, DataNast, UserCl, pswdCl)  
VALUES (502, 'Florea Maria', 'Str. Pacurari nr.34', 'Vaslui', 'Romania', 'mariaflorea@gmail.com', '0744783723', 'F', date'12-07-1987', 'mariaflorea', 'asdffg');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EMailCl,TelCl, Sex, DataNast, UserCl, pswdCl) 
VALUES (503, 'Ioana Petrea', 'Str. Libertatii nr.4', 'Constanta', 'Romania', 'ioana.petrea@yahoo.com', '0734567345', 'F', date'23-11-1984', 'ioanapetrea', 'poiuy');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EMailCl,TelCl, Sex, DataNast, UserCl, pswdCl) 
VALUES (504, 'Vasilescu Andreea', 'Str. Vasile Alecsandri', 'Chisinau', 'Moldova', 'vasilescuandreea@yahoo.com', '0698234234', 'F', date'1985-12-21', 'vasilescuandreea','yhnmju');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EMailCl,TelCl, Sex, DataNast, UserCl, pswdCl)
VALUES (505, 'Leonid Rudenko', 'Str. Leningrad', 'Moscova', 'Rusia', 'leonid.rudenko@gmail.ru', '03562829203', 'B', date'1961-02-21', 'leonidrudenko', 'asdfg');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EMailCl,TelCl, Sex, DataNast, UserCl, pswdCl) 
VALUES (506, 'Gao Ninji', 'Str. Titu Maiorescu', 'Bucuresti', 'Romania', 'gao.ninji@yahoo.com', '0723456834', 'B', date'1972-04-01', 'gaonininji', 'ujnhy');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EMailCl,TelCl, Sex, DataNast, UserCl, pswdCl) 
VALUES (507, 'Stefanescu Alin', 'Str. Unirii', 'Timisoara', 'Romania', 'alin.stefanescu@gmail.com', '072987234', 'B', date'1985-08-23', 'alinstefanescu', 'plkoij') ;


INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (501,1, 202);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (501,2, 306);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (501,3, 305);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (502, 1, 402);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (502, 2, 521);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (502, 3, 305);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (503, 1, 201);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (503, 2, 306);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (503, 3, 521);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (504, 1, 402);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (504, 2, 504);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (504, 3, 303);    
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (505, 1, 203);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (505, 2, 305);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (505, 3, 541);    
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (506, 1, 204);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (506, 2, 402);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (506, 3, 505); 
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (507, 1, 301);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (507, 2, 402);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr, IdCateg_Favor) VALUES (507, 3, 503);


INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('12.23.25.5.555.6', 'Iasi','Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('34.12.234.12.12', 'Bucuresti', 'Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('334.321.23.45.2', 'Timisoara', 'Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('345.23.34.35.70', 'Iasi', 'Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('567.23.34.21.12', 'Iasi', 'Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('729.834.23.23.4', 'Chisinau', 'Moldova');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('23.12.65.32.12.5', 'Moscova', 'Rusia');


-- lipseste INSERT INTO SESIUNI ()...

INSERT INTO sesiuni VALUES (245, TIMESTAMP '2012-03-11 23:11:20', TIMESTAMP '2012-03-12 02:45:23', '12.23.25.5.555.6');
INSERT INTO sesiuni VALUES (246, TIMESTAMP '2012-04-02 10:34:21', TIMESTAMP '2012-04-02 11:22:22', '12.23.25.5.555.6');
INSERT INTO sesiuni VALUES (247, TIMESTAMP '2012-04-03 13:23:23', TIMESTAMP '2012-04-03 13:32:43', '34.12.234.12.12'); 
INSERT INTO sesiuni VALUES (345, TIMESTAMP '2012-01-05 18:23:45', TIMESTAMP '2012-01-05 20:00:01', '334.321.23.45.2');
INSERT INTO sesiuni VALUES (346, TIMESTAMP '2012-02-13 13:23:45', TIMESTAMP '2012-02-13 14:12:23', '345.23.34.35.70');
INSERT INTO sesiuni VALUES (347, TIMESTAMP '2012-03-01 12:39:38', TIMESTAMP '2012-03-01 12:51:22', '34.12.234.12.12');
INSERT INTO sesiuni VALUES (348, TIMESTAMP '2012-04-04 19:23:43', TIMESTAMP '2012-04-04 20:24:21', '567.23.34.21.12');
INSERT INTO sesiuni VALUES (123, TIMESTAMP '2012-05-05 13:49:23', TIMESTAMP '2012-05-05 14:20:23', '729.834.23.23.4');
INSERT INTO sesiuni VALUES (124, TIMESTAMP '2012-05-07 20:23:23', TIMESTAMP '2012-05-07 21:00:00', '23.12.65.32.12.5');
INSERT INTO sesiuni VALUES (125, TIMESTAMP '2012-05-08 11:32:45', TIMESTAMP '2012-05-08 13:00:02', '334.321.23.45.2');
INSERT INTO sesiuni VALUES (145, TIMESTAMP '2012-04-23 13:53:23', TIMESTAMP '2012-04-23	14:32:34', '729.834.23.23.4');
INSERT INTO sesiuni VALUES (146, TIMESTAMP '2012-04-25 18:34:54', TIMESTAMP '2012-04-25 19:23:23',  '345.23.34.35.70');
INSERT INTO sesiuni VALUES (248, TIMESTAMP '2012-01-02 19:23:43', TIMESTAMP '2012-01-02 20:45:23', '334.321.23.45.2');
INSERT INTO sesiuni VALUES (655, TIMESTAMP '2012-01-20 13:59:23', TIMESTAMP '2012-01-20 15:23:21',  '567.23.34.21.12');

INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('245',501);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('246',501);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('247',501); 
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('345',502);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('346',502);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('347',502);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('348',503);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('123',504);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('124',504);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('125',504);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('145',505);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('146',505);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('248',506);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES ('655',507);

INSERT INTO rasfoiri_produse   
	VALUES (550, 245, TIMESTAMP '2012-03-11 23:11:20', TIMESTAMP '2012-03-12 02:45:23', 2001);
INSERT INTO rasfoiri_produse   
	VALUES (551, 246, TIMESTAMP '2012-04-02 10:34:21', TIMESTAMP '2012-04-02 11:22:22', 2002);
INSERT INTO rasfoiri_produse   
	VALUES (552, 247, TIMESTAMP '2012-04-03 13:23:23', TIMESTAMP '2012-04-03 13:32:43', 2003 );
INSERT INTO rasfoiri_produse   
	VALUES (562, 345, TIMESTAMP '2012-01-05 18:23:45', TIMESTAMP '2012-01-05 20:00:01', 2001);
INSERT INTO rasfoiri_produse   
	VALUES (553, 346, TIMESTAMP '2012-02-13 13:23:45', TIMESTAMP '2012-02-13 14:12:23', 2004); 
INSERT INTO rasfoiri_produse   
	VALUES (554, 347, TIMESTAMP '2012-03-01 12:39:38', TIMESTAMP '2012-03-01 12:51:22', 3001); 
INSERT INTO rasfoiri_produse   
	VALUES (555, 348, TIMESTAMP '2012-04-04 19:23:43', TIMESTAMP '2012-04-04 20:24:21', 3002); 
INSERT INTO rasfoiri_produse   
	VALUES (556, 123, TIMESTAMP '2012-05-05 13:49:23', TIMESTAMP '2012-05-05 14:20:23', 4001); 
INSERT INTO rasfoiri_produse   
	VALUES (557, 124, TIMESTAMP '2012-05-07 20:23:23', TIMESTAMP '2012-05-07 21:00:00', 4002); 
INSERT INTO rasfoiri_produse   
	VALUES (558, 125, TIMESTAMP '2012-05-08 11:32:45', TIMESTAMP '2012-05-08 13:00:02', 5001); 
INSERT INTO rasfoiri_produse   
	VALUES (559, 145, TIMESTAMP '2012-04-23 13:53:23', TIMESTAMP '2012-04-23	14:32:34', 5002); 
INSERT INTO rasfoiri_produse   
	VALUES (560, 146, TIMESTAMP '2012-04-25 18:34:54', TIMESTAMP '2012-04-25 19:23:23', 5003); 
INSERT INTO rasfoiri_produse   
	VALUES (561, 248, TIMESTAMP '2012-01-02 19:23:43', TIMESTAMP '2012-01-02 20:45:23', 5001);
INSERT INTO rasfoiri_produse   
	VALUES (563, 655, TIMESTAMP '2012-01-20 13:59:23', TIMESTAMP '2012-01-20 15:23:21', 2001);

INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune) 
	VALUES (51, TIMESTAMP '2012-03-11 23:20:23', TIMESTAMP '2012-03-12 02:00:00', 245);
INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune) 
	VALUES (52, TIMESTAMP '2012-04-04 19:30:33', TIMESTAMP '2012-04-04 20:23:22', 348);
INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune) 
	VALUES (53, TIMESTAMP '2012-05-08 11:39:33', TIMESTAMP '2012-05-08 12:45:22', 125);
INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune) 
	VALUES (54, TIMESTAMP '2012-04-25 18:44:23', TIMESTAMP '2012-04-25 19:14:23', 146);
INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune) 
	VALUES (55, TIMESTAMP '2012-01-02 19:30:22', TIMESTAMP '2012-01-02 20:33:33', 248);

INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (51,2001, 1, 34) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (51,2002, 1, 2850) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (51,2003, 2, 85) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (52,3001, 1, 68) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (52,2001, 1, 45) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (53,2002, 1, 320) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (53,4001, 1, 80) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (53,4002, 1, 24) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (54,5001, 1, 140) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (54,5002, 1, 1200) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (54,2001, 1, 120) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (55,2003, 1, 1950) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (55,5002, 1, 1350) ;
INSERT INTO continut_cosuri (IdCos, IdProdus,  CantitateCos, PretUnitarCos) VALUES (55,5003, 1, 64) ;

INSERT INTO comenzi VALUES (10001, 51) ;
INSERT INTO comenzi VALUES (10002, 52) ;
INSERT INTO comenzi VALUES (10003, 53) ;
INSERT INTO comenzi VALUES (10004, 54) ;
INSERT INTO comenzi VALUES (10005, 55) ;

INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) 
	VALUES (32, TIMESTAMP'2012-05-21', 10001, 2969) ;
INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) 
	VALUES (33, TIMESTAMP'2012-06-23', 10002, 113) ;
INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) 
	VALUES (34, TIMESTAMP'2012-06-28', 10003, 424) ;
INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) 
	VALUES (35, TIMESTAMP'2012-08-31', 10004, 1460) ;
INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) 
	VALUES (36, TIMESTAMP'2012-10-06', 10005, 3364) ;

-- end of blanari,lupu,para, petrea

-- Aneculaesei_Doroftea_Mihailescu
INSERT INTO clienti (IdClient, NumeCl, AdresaCL, LocCl, TaraCl, EMailCl, TelCl, Sex, DataNast, UserCl, pswdCl)
	VALUES (301, 'Popescu Ion', 'Str. Nicolae Iorga, Nr. 21', 'Iasi', 'Romania', 
		'popescu.ion@yahoo.com', '0751.078.129', 'B', '1986/03/04', 'popescu.i', 'pion');

INSERT INTO categorii_favorite (IdClient, CategFavor_Nr,IdCateg_Favor) VALUES (301,1,101);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr,IdCateg_Favor) VALUES (301,2,305);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr,IdCateg_Favor) VALUES (301,3,403);

INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('142.784.19.1','Iasi','Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('442.424.59.2','Cluj','Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('722.414.75.9','Timisoara','Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_IP) VALUES ('562.084.19.3','Bucuresti','Romania');

INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (46, TIMESTAMP'2012-01-05 10:15:34',TIMESTAMP'2012-01-05 10:18:34', '562.084.19.3');
INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (47, TIMESTAMP'2012-01-13 15:26:14',TIMESTAMP'2012-01-13 15:49:30', '442.424.59.2');
INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (48, TIMESTAMP'2012-02-01 17:29:10',TIMESTAMP'2012-02-01 18:15:45', '142.784.19.1');
INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (49, TIMESTAMP'2012-02-15 20:26:19',TIMESTAMP'2012-02-15 21:30:21', '562.084.19.3');
INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (50, TIMESTAMP'2012-03-10 13:26:14',TIMESTAMP'2012-03-10 13:34:15', '142.784.19.1');
INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (51, TIMESTAMP'2012-03-17 18:43:25',TIMESTAMP'2012-03-17 18:59:00', '442.424.59.2');
INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (52, TIMESTAMP'2012-04-02 19:55:18',TIMESTAMP'2012-04-02 20:24:52', '142.784.19.1');
INSERT INTO sesiuni (IdSesiune, DataOraIncepSes,DataOraFinalizSes, Adresa_IP) 
	VALUES (53, TIMESTAMP'2012-04-20 20:45:22',TIMESTAMP'2012-04-20 21:00:30', '722.414.75.9');

INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES (46,301);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES (47,301);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES (48,301);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES (49,301);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES (50,301);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES (51,301);
INSERT INTO sesiuni_autentificate (IdSesiune, IdClient) VALUES (53,301);

INSERT INTO rasfoiri_produse (IdRasfoireProd, IdSesiune, DataOraIncepRasf, DataOraFinalizRasf, IdProdus) 
VALUES (1,47,TIMESTAMP'2012-01-13 15:26:14', TIMESTAMP'2012-01-13 15:49:30',2001);
INSERT INTO rasfoiri_produse (IdRasfoireProd, IdSesiune, DataOraIncepRasf, DataOraFinalizRasf, IdProdus) 
VALUES (2,48,TIMESTAMP'2012-02-01 17:29:10',TIMESTAMP'2012-02-01 18:15:45',2003);
INSERT INTO rasfoiri_produse (IdRasfoireProd, IdSesiune, DataOraIncepRasf, DataOraFinalizRasf, IdProdus) 
VALUES (3,49,TIMESTAMP'2012-02-15 20:26:19',TIMESTAMP'2012-02-15 21:30:21',3001);
INSERT INTO rasfoiri_produse (IdRasfoireProd, IdSesiune, DataOraIncepRasf, DataOraFinalizRasf, IdProdus)
VALUES (4,50,TIMESTAMP'2012-03-10 13:26:14',TIMESTAMP'2012-03-10 13:34:15',4001);
INSERT INTO rasfoiri_produse (IdRasfoireProd, IdSesiune, DataOraIncepRasf, DataOraFinalizRasf, IdProdus)
VALUES (5,51,TIMESTAMP'2012-03-17 18:43:25',TIMESTAMP'2012-03-17 18:59:00',5001);

-- end of Aneculaesei_Doroftea_Mihailescu


-- Alina_Pitariu

INSERT INTO clienti (IdClient, NumeCl, AdresaCl, LocCl, TaraCl, EmailCl,
		TelCl, Sex, DataNast, UserCl, pswdCl) 
	VALUES (201,'Popescu Ionut','Str.Lupascu nr.3,bl.453,sc.A,et.3,ap.15','Ploiesti','Romania','popescui@hotmail.com',
	'0746567567','B',DATE'1980-10-10', 'i_pope', 'iiipopescu');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EmailCl,TelCl,Sex,DataNast,UserCl,pswdCl) 
	VALUES (202,'Anton Mara','Str. Morii nr.65,bl.A5,sc.C,et2,ap.10','Brasov','Romania','mara.anton@gmail.com',
		'0741118119', 'F', DATE'1984-06-06','mara_para','mariuca');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EmailCl,TelCl,Sex,DataNast,UserCl,pswdCl) 
	VALUES (203,'Neamtu Horatiu','Str.Pacii,nr.3,bl.540,sc.D,et.7,ap.31','Suceava','Romania',
		'horatiu_neamtu@hotmail.com','0744569879','B', DATE'1979-12-12','horica','starwars');
INSERT INTO clienti (IdClient,NumeCl,AdresaCl,LocCl,TaraCl,EmailCl,TelCl,Sex,DataNast,UserCl,pswdCl) 
	VALUES (204,'Tudoran Otilia','Str.Papucului,nr.24,bl.792,sc.D,et.3,ap.12','Iasi','Romania',
		'otilia.tudoran91@yahoo.fr', '0743254345', 'F', DATE'1991-09-04','oti_tudo','carpediem');

INSERT INTO categorii_favorite (IdClient,CategFavor_Nr,IdCateg_Favor) VALUES (201,1,101);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr,IdCateg_Favor) VALUES (201,2,201);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr,IdCateg_Favor) VALUES (201,3,301);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr,IdCateg_Favor) VALUES (202,1,401);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr,IdCateg_Favor) VALUES (203,1,402);
INSERT INTO categorii_favorite (IdClient,CategFavor_Nr,IdCateg_Favor) VALUES (204,1,501);

INSERT INTO adrese_IP (Adresa_IP, Loc_Adresa_IP, Tara_adresa_IP) 
	VALUES ('24356178263541627','Paris','Franta');
INSERT INTO adrese_IP (Adresa_IP, Loc_Adresa_IP, Tara_adresa_IP) 
	VALUES ('14563726583','Focsani','Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_Adresa_IP, Tara_adresa_IP) 
	VALUES ('52314253678','Ploiesti','Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_Adresa_IP, Tara_adresa_IP) 
	VALUES ('22334565671','Caracal','Romania');

INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (12,TIMESTAMP'2012-04-05 12:02:02',TIMESTAMP'2012-04-05 12:10:00','22334565671');
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (6,TIMESTAMP'2012-09-11 21:35:04',TIMESTAMP'2012-09-11 22:00:00','22334565671');
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (23,TIMESTAMP'2012-01-01 13:22:12',TIMESTAMP'2012-01-01 14:10:45','22334565671');
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (15,TIMESTAMP'2012-09-04 02:22:12',TIMESTAMP'2012-09-04 05:47:35','22334565671');
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (100,TIMESTAMP'2012-06-08 17:22:12',TIMESTAMP'2012-06-08 18:10:18','22334565671');
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (29,TIMESTAMP'2012-06-08 18:22:12',TIMESTAMP'2012-06-08 19:10:12','22334565671');
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (67,TIMESTAMP'2012-06-08 19:22:12',TIMESTAMP'2012-06-08 22:16:35','22334565671');
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (21,TIMESTAMP'2012-06-08 20:22:12',TIMESTAMP'2012-06-08 23:14:45','22334565671');


INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (12,201);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (6,201);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (23,201);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (100,204);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (67,203);

INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (17,15);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (26,29);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (13,100);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (18,21);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (20,12);

INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (17,1,10011);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (26,2,10012);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (13,3,10013);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (18,4,5001);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (20,5,5004);


INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (21,23,TIMESTAMP'2012-06-08 20:22:12',TIMESTAMP'2012-06-08 23:14:45',10011);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (56,6,TIMESTAMP'2012-09-11 21:35:04',TIMESTAMP'2012-09-11 22:00:00',5009);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (11,12,TIMESTAMP'2012-06-08 20:22:12',TIMESTAMP'2012-06-08 23:14:45',5007);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (26,15,TIMESTAMP'2012-09-04 02:22:12',TIMESTAMP'2012-09-04 05:47:35',3005);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (41,100,TIMESTAMP'2012-06-08 17:22:12',TIMESTAMP'2012-06-08 18:10:18',10013);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (66,29,TIMESTAMP'2012-06-08 18:22:12',TIMESTAMP'2012-06-08 19:10:12',4001);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (33,67,TIMESTAMP'2012-06-08 19:22:12',TIMESTAMP'2012-06-08 22:16:35',3006);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (88,21,TIMESTAMP'2012-06-08 20:22:12',TIMESTAMP'2012-06-08 23:14:45',5004);

INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) VALUES (21,TIMESTAMP'2012-06-08 20:35:54',TIMESTAMP'2012-06-08 20:54:08',12);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) VALUES (25,TIMESTAMP'2012-09-03 10:06:29',TIMESTAMP'2012-09-03 10:47:22',6);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) VALUES (11,TIMESTAMP'2009-11-12 14:55:14',TIMESTAMP'2009-11-12 15:26:57',23);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) VALUES (44,TIMESTAMP'2012-08-11 23:45:00',TIMESTAMP'2012-08-12 00:09:08',100);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) VALUES (48,TIMESTAMP'2012-02-02 22:14:36',TIMESTAMP'2012-02-02 23:59:59',67);

INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (44,5001,1,49);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (44,5008,2,104);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (44,3001,1,4999);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (44,3003,1,1899);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (11,2004,3,150);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (11,2001,2,70);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (25,3004,2,5598);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (25,10012,2,120);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (21,10013,1,82);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (21,3006,1,1699);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (21,5011,8,440);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (48,4003,3,210);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (48,3005,1,2499);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (48,5003,2,88);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (48,2006,15,300);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (48,3002,2,3798);

INSERT INTO comenzi (IdComanda,IdCos) VALUES (147,44);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (235,21);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (109,11);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (37,25);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (88,48);

INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (2134,TIMESTAMP'2012-06-11 10:15:34',147,1051);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (12546,TIMESTAMP'2012-06-12 13:02:20',147,6000);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (3546,TIMESTAMP'2009-12-02 11:23:54',109,150);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (1435,TIMESTAMP'2009-12-07 14:36:45',109,70);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (899,TIMESTAMP'2012-06-08 20:35:54',88,4000);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (1212,TIMESTAMP'2012-06-08 20:35:54',235,2221);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (4000,TIMESTAMP'2012-06-08 20:35:54',37,5718);

-- end of Alina_Pitariu


-- andreea_zaharescu
INSERT INTO clienti (IdClient, NumeCl, AdresaCl, LocCl, TaraCL, EmailCl, TelCl, Sex, DataNast, UserCl, pswdCl) 
	VALUES (701,'Apetrei Monica','Str. Arcu Nr. 23','Bucuresti','Romania',
		'monica@gmail.com',0743367877, 'F', DATE'1985-08-23','mona_ap','parolagenerala');

INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (701,1,202);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (701,2,101);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (701,3,305);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (701,4,304);

INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('19774883399','Bucuresti','Romania');
INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('15688883399','Bucuresti','Romania');
INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('12454883399','Iasi','Romania');
INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('13945566233','Suceava','Romania');

INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (101,TIMESTAMP'2012-02-14 20:40:00',TIMESTAMP'2012-02-14 21:20:50',19774883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (111,TIMESTAMP'2012-02-21 19:00:30',TIMESTAMP'2012-02-21 19:06:00',19774883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (121,TIMESTAMP'2012-02-27 14:40:30',TIMESTAMP'2012-02-27 14:56:00',15688883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (131,TIMESTAMP'2012-03-10 19:20:30',TIMESTAMP'2012-03-10 19:56:00',19774883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (141,TIMESTAMP'2012-03-14 21:12:40',TIMESTAMP'2012-03-14 21:31:24',19774883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (151,TIMESTAMP'2012-03-15 07:00:30',TIMESTAMP'2012-03-15 07:05:09',15688883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (161,TIMESTAMP'2012-04-10 07:12:30',TIMESTAMP'2012-04-10 07:20:39',12454883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (171,TIMESTAMP'2012-05-10 19:58:50',TIMESTAMP'2012-05-10 20:30:19',13945566233);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (181,TIMESTAMP'2012-05-23 23:00:30',TIMESTAMP'2012-05-23 23:10:49',12454883399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (191,TIMESTAMP'2012-05-24 13:50:27',TIMESTAMP'2012-05-24 14:15:34',15688883399);

INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (101,701);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (121,701);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (131,701);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (141,701);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (151,701);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (161,701);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (171,701);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (181,701);

INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (221,101);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (222,131);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (223,141);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (224,161);

INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat)
	VALUES (221,2,10011);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat)
	VALUES (222,2,5005);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat)
	VALUES (223,2,5011);

INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2211,101,TIMESTAMP'2012-02-14 20:45:00',TIMESTAMP'2012-02-14 21:00:50',5007);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2212,101,TIMESTAMP'2012-02-14 21:00:10',TIMESTAMP'2012-02-14 21:03:50',5010);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2213,101,TIMESTAMP'2012-02-14 21:03:55',TIMESTAMP'2012-02-14 21:06:55',2004);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2214,101,TIMESTAMP'2012-02-14 21:07:10',TIMESTAMP'2012-02-14 21:10:50',2005);
	
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2225,111,TIMESTAMP'2012-02-21 19:01:30',TIMESTAMP'2012-02-21 19:06:00',5008);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2246,121,TIMESTAMP'2012-02-27 14:43:30',TIMESTAMP'2012-02-27 14:56:00',2003);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2257,131,TIMESTAMP'2012-03-10 19:25:30',TIMESTAMP'2012-03-10 19:40:00',5010);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2268,141,TIMESTAMP'2012-02-21 19:02:30',TIMESTAMP'2012-02-21 19:06:00',3001);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2279,151,TIMESTAMP'2012-03-15 07:01:30',TIMESTAMP'2012-03-15 07:05:09',2001);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2281,161,TIMESTAMP'2012-04-10 07:14:30',TIMESTAMP'2012-04-10 07:16:39',4003);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (2292,161,TIMESTAMP'2012-04-10 07:13:50',TIMESTAMP'2012-04-10 07:15:39',2006);

INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) 
	VALUES (111,TIMESTAMP'2012-02-14 21:10:50',TIMESTAMP'2012-02-10 21:20:50', 101);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) 
	VALUES (112,TIMESTAMP'2012-03-10 19:41:30',TIMESTAMP'2012-02-21 19:56:00',131);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) 
	VALUES (113,TIMESTAMP'2012-04-10 07:16:00',TIMESTAMP'2012-04-21 07:20:39',161);

INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (111,5007,1,46);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (111,5010,2,69);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (111,2004,3,30);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (111,2005,1,29);

INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (112,5008,1,50);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (112,2003,2,34);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (112,5010,2,69);

INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (113,3001,1,2000);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (113,2001,2,35);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (113,4003,3,64);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (113,2006,1,30);

INSERT INTO comenzi (IdComanda,IdCos) VALUES (1111,111);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (1112,112);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (1113,113);

INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (333,TIMESTAMP'2012-02-10 21:25:50',1111,174);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (334,TIMESTAMP'2012-02-21 20:00:00',1112,153);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) VALUES (335,TIMESTAMP'2012-04-21 07:26:39',1113,2129);


INSERT INTO clienti (IdClient, NumeCl, AdresaCl, LocCl, TaraCL, EmailCl, TelCl, Sex, DataNast, UserCl, pswdCl) 
	VALUES (702,'Gonzalez Eduardo','Felicidad numero 13','Sevilla','Spania',
		'eduardo@gmail.com',6558806689,'B', DATE'1971-05-11','e.gonzalez','felicidad13');

INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (702,1,101);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (702,2,403);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (702,3,202);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (702,4,305);

INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('17599020293','Bucuresti','Romania');
INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('15749218399','Sevilla','Spania');
INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('24499239008','Barcelona','Spania');
INSERT INTO adrese_IP (Adresa_IP,Loc_adresa_IP,Tara_adresa_IP) VALUES ('21949402949','Sevilla','Spania');

INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2088,TIMESTAMP'2012-02-14 22:40:00',TIMESTAMP'2012-02-14 22:59:50',17599020293);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2188,TIMESTAMP'2012-02-16 21:00:30',TIMESTAMP'2012-02-16 21:36:00',15749218399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2288,TIMESTAMP'2012-02-23 13:45:30',TIMESTAMP'2012-02-27 14:34:00',15749218399);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2388,TIMESTAMP'2012-03-02 10:20:30',TIMESTAMP'2012-03-02 12:00:00',24499239008);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2488,TIMESTAMP'2012-03-06 21:12:40',TIMESTAMP'2012-03-06 21:31:24',21949402949);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2588,TIMESTAMP'2012-03-15 09:00:30',TIMESTAMP'2012-03-15 10:00:09',21949402949);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2688,TIMESTAMP'2012-04-04 17:24:30',TIMESTAMP'2012-04-04 17:57:19',24499239008);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2788,TIMESTAMP'2012-05-01 19:58:50',TIMESTAMP'2012-05-01 20:30:19',21949402949);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2888,TIMESTAMP'2012-05-15 23:00:30',TIMESTAMP'2012-05-15 23:23:57',21949402949);
INSERT INTO sesiuni (IdSesiune,DataOraIncepSes,DataOraFinalizSes,Adresa_IP) 
	VALUES (2988,TIMESTAMP'2012-05-24 15:50:27',TIMESTAMP'2012-05-24 16:15:34',17599020293);

INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2088,702);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2288,702);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2388,702);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2488,702);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2588,702);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2688,702);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2788,702);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (2988,702);

INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (241,2088);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (242,2388);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (243,2488);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (244,2688);

INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat)VALUES (241,2,10011);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat)VALUES (243,2,5001);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat)VALUES (244,2,5006);

INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (231,2088,TIMESTAMP'2012-02-14 22:40:00',TIMESTAMP'2012-02-14 22:45:50',5001);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (232,2088,TIMESTAMP'2012-02-14 22:45:55',TIMESTAMP'2012-02-14 22:48:44',5006);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (233,2088,TIMESTAMP'2012-02-14 22:49:00',TIMESTAMP'2012-02-14 22:51:55',2004);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (234,2088,TIMESTAMP'2012-02-14 22:52:10',TIMESTAMP'2012-02-14 22:54:50',2002);

INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (235,2188,TIMESTAMP'2012-02-16 21:00:30',TIMESTAMP'2012-02-16 21:16:00',5008);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (236,2188,TIMESTAMP'2012-02-16 21:16:30',TIMESTAMP'2012-02-16 21:20:00',2003);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (237,2188,TIMESTAMP'2012-02-16 21:23:12',TIMESTAMP'2012-02-16 21:25:00',5010);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (238,2388,TIMESTAMP'2012-03-02 10:20:30',TIMESTAMP'2012-03-02 10:31:23',5002);	
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (239,2388,TIMESTAMP'2012-03-02 10:31:30',TIMESTAMP'2012-03-02 10:45:00',5010);
	
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (240,2588,TIMESTAMP'2012-03-15 09:00:30',TIMESTAMP'2012-03-15 09:35:09',10012);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (241,2588,TIMESTAMP'2012-03-15 09:36:30',TIMESTAMP'2012-03-15 09:46:09',3003);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (242,2688,TIMESTAMP'2012-04-04 17:25:30',TIMESTAMP'2012-04-04 17:37:19',4003);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (243,2788,TIMESTAMP'2012-05-01 19:59:59',TIMESTAMP'2012-05-01 20:20:00',5011);

INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) 
	VALUES (141,TIMESTAMP'2012-02-10 22:54:50',TIMESTAMP'2012-02-10 22:59:50',2088);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) 
	VALUES (142,TIMESTAMP'2012-03-02 10:57:00',TIMESTAMP'2012-02-21 12:00:00',2388);
INSERT INTO cosuri (IdCos,DataOraInitializareCos,DataOraFinalizareCos,IdSesiune) 
	VALUES (143,TIMESTAMP'2012-05-01 20:22:00',TIMESTAMP'2012-05-01 20:30:00',2788);

INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (141,5001,3,59);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (141,5006,4,70);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (141,2004,1,30);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (141,2002,1,29);

INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (142,5008,5,50);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (142,2003,2,34);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (142,5010,1,69);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (142,5002,1,69);

INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (143,10012,3,100);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (143,3003,2,2309);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (143,4003,2,1800);
INSERT INTO continut_cosuri (IdCos,IdProdus,CantitateCos,PretUnitarCos) VALUES (143,5011,1,50);

INSERT INTO comenzi (IdComanda,IdCos) VALUES (2111,141);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (2112,142);
INSERT INTO comenzi (IdComanda,IdCos) VALUES (2113,143);

INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) 
    VALUES (433,TIMESTAMP'2012-02-10 23:05:50',2111,516);
INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) 
    VALUES (434,TIMESTAMP'2012-02-21 12:06:00',2112,452);
--INSERT INTO incasari (IdIncasare,DataOraIncasare,IdComanda,SumaIncasata) 
--    VALUES (435,TIMESTAMP'2012-05-01 20:36:46',2113,4259);

-- end of andreea_zaharescu

-- andreea caloian
INSERT INTO clienti (IdClient, NumeCl, AdresaCl, LocCl, TaraCl, EmailCl, TelCl, Sex, DataNast, UserCl, pswdCl)
VALUES (101, 'Popescu Ion', 'Str. Doinei, Nr.16', 'Marasesti', 'Romania', 'popescu.ion@yahoo.com', '0722.342.342', 'B', date'1987-02-15', 'Popescu.Ion', 'parola');

INSERT INTO clienti (IdClient, NumeCl, AdresaCl, LocCl, TaraCl, EmailCl, TelCl, Sex, DataNast, UserCl, pswdCl)
VALUES (102, 'Poprican Maria', 'Str. Florilor, Nr.20', 'Timisoara', 'Romania', 'poprican.maria@hotmail.com', '0734.021.777', 'F', date'1976-02-12', 'Poprican.Maria', 'popricanmaria');

INSERT INTO clienti (IdClient, NumeCl, AdresaCl, LocCl, TaraCl, EmailCl, TelCl, Sex, DataNast, UserCl, pswdCl)
VALUES (103, 'Cretu Marian', 'Str. Timis, Nr. 52', 'Iasi', 'Romania', 'cretu.marian@hotmail.com', '0232.232.323', 'B', date'1967-05-24', 'Cretu.Marian', 'nustiu');


INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (101, 1, 501);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (101, 2, 502);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (101, 3, 503);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (101, 4, 504);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (101, 5, 505);

INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (102, 1, 201);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (102, 2, 202);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (102, 3, 203);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (102, 4, 204);

INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (103, 1, 301);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (103, 2, 302);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (103, 3, 303);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (103, 4, 304);
INSERT INTO categorii_favorite (IdClient, CategFavor_Nr, IdCateg_Favor) VALUES (103, 5, 305);


INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_ip) VALUES ('81.232.777.222', 'Iasi', 'Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_ip) VALUES ('82.000.232.001', 'Focsani', 'Romania');
INSERT INTO adrese_IP (Adresa_IP, Loc_adresa_IP, Tara_adresa_ip) VALUES ('81.232.000.000', 'Bacau', 'Romania');


INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21111, TIMESTAMP'2012-12-23 07:15:20', TIMESTAMP'2012-12-23 07:55:44', '81.232.777.222');
INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21112, TIMESTAMP'2013-02-03 06:33:00', TIMESTAMP'2013-02-03 06:50:00','81.232.777.222');
INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21113, TIMESTAMP'2013-04-03 09:03:23', TIMESTAMP'2013-04-03 10:23:12', '81.232.777.222');

INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21114, TIMESTAMP'2013-04-05 13:23:33', TIMESTAMP'2013-04-05 23:22:33', '82.000.232.001');
INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21115, TIMESTAMP'2013-04-06 12:02:23', TIMESTAMP'2013-04-06 22:02:00', '82.000.232.001');
INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21116, TIMESTAMP'2013-04-07 23:00:00', TIMESTAMP'2013-04-07 23:40:00', '82.000.232.001');

INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21117, TIMESTAMP'2013-04-08 14:02:34', TIMESTAMP'2013-04-08 14:23:33', '81.232.000.000');
INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21118, TIMESTAMP'2013-04-08 14:45:32', TIMESTAMP'2013-04-08 15:02:00', '81.232.000.000');
INSERT INTO sesiuni (IdSesiune,	DataOraIncepSes, DataOraFinalizSes, Adresa_IP)
	VALUES (21119, TIMESTAMP'2013-04-08 15:03:00', TIMESTAMP'2013-04-08 16:00:00', '81.232.000.000');


INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (21112, 101);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (21114, 102);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (21115, 103);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (21116, 103);
INSERT INTO sesiuni_autentificate (IdSesiune,IdClient) VALUES (21117, 101);


INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (3111, 21112);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (3112, 21114);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (3113, 21115);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (3114, 21116);
INSERT INTO recomandari (IdRecomandare,IdSesiune) VALUES (3115, 21117);

INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (3111, 1, 10011);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (3111, 2, 10012);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (3111, 3, 10013);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (3112, 1, 5001);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (3113, 1, 5002);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (3114, 1, 5003);
INSERT INTO recomandari_prod (IdRecomandare,Recomandare_Nr,IdProd_Recomandat) VALUES (3114, 2, 5004);
 
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,	DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (41111, 21112, TIMESTAMP'2013-02-03 06:33:00', TIMESTAMP'2013-02-03 06:50:00',10011);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,	DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (41112, 21114, TIMESTAMP'2013-04-05 13:23:33', TIMESTAMP'2013-04-05 23:22:33', 10012);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,	DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (41113, 21115, TIMESTAMP'2013-04-06 12:02:23', TIMESTAMP'2013-04-06 22:02:00', 5002);
INSERT INTO rasfoiri_produse (IdRasfoireProd,IdSesiune,	DataOraIncepRasf,DataOraFinalizRasf,IdProdus) 
	VALUES (41114, 21117, TIMESTAMP'2013-04-08 14:02:34', TIMESTAMP'2013-04-08 14:23:33', 5004);

INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune)
	VALUES (51111, TIMESTAMP'2013-02-03 06:40:00', TIMESTAMP'2013-02-03 06:50:00', 21112);
INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune)
	VALUES (51112, TIMESTAMP'2013-04-05 13:40:00', TIMESTAMP'2013-04-05 14:50:00', 21114);
INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune)
	VALUES (51113, TIMESTAMP'2013-04-06 12:40:00', TIMESTAMP'2013-04-06 16:58:40', 21115);
INSERT INTO cosuri (IdCos, DataOraInitializareCos, DataOraFinalizareCos, IdSesiune)
	VALUES (51114, TIMESTAMP'2013-04-08 14:10:00', TIMESTAMP'2013-04-08 06:20:00', 21117);

INSERT INTO continut_cosuri (IdCos, IdProdus, CantitateCos, PretUnitarCos) VALUES (51111, 10012, 2, 120);
INSERT INTO continut_cosuri (IdCos, IdProdus, CantitateCos, PretUnitarCos) VALUES (51112, 10011, 1, 156);
INSERT INTO continut_cosuri (IdCos, IdProdus, CantitateCos, PretUnitarCos) VALUES (51112, 10012, 1, 156);
INSERT INTO continut_cosuri (IdCos, IdProdus, CantitateCos, PretUnitarCos) VALUES (51112, 5002, 1, 156);
INSERT INTO continut_cosuri (IdCos, IdProdus, CantitateCos, PretUnitarCos) VALUES (51113, 2002, 1, 116);
INSERT INTO continut_cosuri (IdCos, IdProdus, CantitateCos, PretUnitarCos) VALUES (51113, 2003, 1, 116);
INSERT INTO continut_cosuri (IdCos, IdProdus, CantitateCos, PretUnitarCos) VALUES (51113, 2004, 1, 116);

INSERT INTO comenzi (IdComanda,	IdCos) VALUES (61111, 51111);
INSERT INTO comenzi (IdComanda, IdCos) VALUES (61112, 51112);
INSERT INTO comenzi (IdComanda, IdCos) VALUES (61113, 51113);

INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) VALUES (71111, TIMESTAMP'2013-03-03 07:03:44', 61111, 120);
INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) VALUES (71112, TIMESTAMP'2013-04-05 15:03:33', 61112, 156);
INSERT INTO incasari (IdIncasare, DataOraIncasare, IdComanda, SumaIncasata) VALUES (71113, TIMESTAMP'2013-04-06 17:34:22', 61113, 116);

-- end of andreea caloian


--COMMIT ;



