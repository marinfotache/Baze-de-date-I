-- 						Interogari BD Chinook - IE si SPE:
--
-- SQL 01: Filtrare simpla, regular expressions, structuri CASE
--
-- ultima actualizare: 2019-04-14


-- ############################################################################ 
-- 					In ce ani s-au inregistrat vanzari?
-- ############################################################################ 

-- prima notatie pentru ordonare (specificarea expresiei de calcul a atributului de ordonare)
select distinct extract (year from invoicedate) as an
from invoice
order by extract (year from invoicedate)

-- a doua notatie pentru ordonare (specificarea atributului (calculat) de ordonare)
select distinct extract (year from invoicedate) as an
from invoice
order by an

-- a treia notatie pentru ordonare (specificarea pozitiei in rezultat a atributului de ordonare)
select distinct extract (year from invoicedate) as an
from invoice
order by 1



-- ############################################################################ 
--  Extrageti lunile calendaristice (si anii) in care s-au inregistrat vanzari
-- ############################################################################ 

select distinct extract (year from invoicedate) as an,
	extract (month from invoicedate) as luna
from invoice
order by 1,2




-- ############################################################################ 
-- 			Care este lungimea numelui pentru fiecare artist/formatie?
-- ############################################################################ 

select artist.*, length(name) as lungime_nume
from artist


--
-- Sa se afiseze artistii in ordinea descrescatoare a lungimii numelui
--
select artist.*, length(name) as lungime_nume
from artist
order by length(name) desc 


-- ############################################################################ 
-- Sa se afiseze numele formatat al artistilor, conform urmatoarei cerinte:
-- 1. pentru artistii cu numele lung de pana la 11 caractere, 
--		se afiseaza numele intreg
-- 2. pentru artistii cu numele mai lung de 11 caracterese se extrag cinci 
--   	caractere, se adauga `...` la mijloc si se finalizeaza cu 
-- 		ultimele cinci caractere
-- ############################################################################ 

-- solutie bazata pe LEFT si RIGHT
select artist.*, 
	case 
		when length(name) <= 11 then name
		else left(name, 5) || '...' || right(name, 5)
	end as nume_formatat,  
	length(name) as lungime_nume
from artist

-- solutie bazata pe SUBSTRING
select artist.*, 
	case 
		when length(name) <= 11 then name
		else substring(name, 1, 5) || '...' || 
			substring(name, length(name)-4, length(name))
		end as nume_formatat,  
	length(name) as lungime_nume
from artist


-- ############################################################################ 
-- Care sunt artistii sau formatiile cu numele alcatuit dintr-un singur cuvant?
-- 					(adica numele nu contine niciun spatiu)
-- ############################################################################ 

-- solutie bazata pe operatorul `LIKE`
select *
from artist
where name not like '% %'

-- solutie bazata pe operatorii `LIKE` si CASE
select *
from artist
where case when name like '% %' then false else true end 

-- soluție cu POSITION
SELECT *
FROM artist
WHERE POSITION(' ' IN NAME) = 0

-- soluție cu SPLIT_PART
SELECT *, 
	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant
FROM artist
WHERE SPLIT_PART(name, ' ', 2) = ''

-- prima soluție cu REPLACE
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii
FROM artist
WHERE name = REPLACE(name, ' ', '')

-- a doua soluție cu REPLACE
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
FROM artist
WHERE LENGTH(name) = LENGTH(REPLACE(name, ' ', ''))


-- ############################################################################ 
-- Care sunt artistii sau formatiile cu numele alcatuit din 
-- cel putin doua cuvinte? (adica numele contine cel putin un singur spatiu)
-- ############################################################################ 

-- solutie bazata pe operatorul `LIKE`
select *
from artist
where name like '% %' 

-- soluție cu POSITION
SELECT *, POSITION(' ' IN NAME)
FROM artist
WHERE POSITION(' ' IN NAME) > 0 

-- soluție cu SPLIT_PART
SELECT *, 
	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant
FROM artist
WHERE SPLIT_PART(name, ' ', 2) <> ''

-- soluție cu REPLACE
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
FROM artist
WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) > 0



-- ############################################################################ 
-- Care sunt artistii sau formatiile cu numele alcatuit din exact doua cuvinte?
-- (adica numele contine un singur spatiu)
-- ############################################################################ 

-- solutie bazata pe operatorul `LIKE`
select *
from artist
where name like '% %' and name not like '% % %'

-- soluție cu SPLIT_PART
SELECT *, 
	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant,
	SPLIT_PART(name, ' ', 3) AS al_treilea_cuvant
FROM artist
WHERE SPLIT_PART(name, ' ', 2) <> '' and SPLIT_PART(name, ' ', 3) = ''

-- soluție cu REPLACE
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
FROM artist
WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 1



>>> reg_exp   !!!!!!!!!!



-- ############################################################################ 
-- 						Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################ 

-- Extrageti numele de utilizator de pe contul de e-mail al fiecarui angajat

-- Extrageti toate serverele de e-mail  (ex. `gmail.com`) ale clientilor

-- Care sunt piesele formatiei `Led Zeppelin` compuse de cel putin trei muzicieni?

-- Care sunt piesele formatiei `Led Zeppelin` compuse (si) de `John Bonham`

-- Care sunt piesele formatiei `Led Zeppelin` compuse numai de `Robert Plant`

-- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
--  `Jimmy Page`, cu sau fara alti colegi/muzicieni?

-- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
--  `Jimmy Page`, fara alti colegi/muzicieni?

-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
--	`Robert Plant` 

-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
--	nici `Robert Plant`, nici `Jimmy Page` 





-- ############################################################################ 
-- 						La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################ 


select current_date ;


select current_date from playlist;


select * from track where name like 'Custard%' ;


select * from artist where upper(name) like 'AC%'


select e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age 
from employee e ;










