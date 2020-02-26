-- 						Interogari BD Chinook - IE si SPE:
--
-- SQL 01: Filtrare simpla, regular expressions, structuri CASE
--
-- ultima actualizare: 2020-02-26


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

-- a patra varianta - bazata pe SUBSTRING:
-- stiind ca formatul datei este `2019-10-01`, pastram numai primele patru caractere din data,
--    care reprezinta anul;
-- prin functia cast, convertim datele calendaristice in siruri de caractere si, in final,
--  exprimam rezultatul (anul calendaristic) ca numar intreg
select distinct cast (SUBSTRING(cast (invoicedate as character(10)), 1, 4) as integer) as an
from invoice
order by 1


-- a cincea varianta - bazata pe `regular expression` (extrage primele patru cifre):
select distinct cast (SUBSTRING(cast (invoicedate as character(10)), '[0-9]{4}') as integer) as an
from invoice
order by 1


-- a sasea varianta - bazata tot pe `regular expression`:
-- stiind ca formatul datei este `2019-10-01`, inlocuim toate caracterele, incepand cu prima cratima (`-`)
--   cu "nimic"; astfel, pastram numai primele patru caractere din data, care reprezinta anul;
-- prin functia cast, convertim datele calendaristice in siruri de caractere si, in final,
--  exprimam rezultatul (anul calendaristic) ca numar intreg
select distinct cast (REGEXP_REPLACE(cast (invoicedate as character(10)), '\-.*', '') as integer) as an
from invoice
order by 1





-- ############################################################################
--  Extrageti lunile calendaristice (si anii) in care s-au inregistrat vanzari
-- ############################################################################

-- prima varianta - folosind functiile `year` si `month`
select distinct extract (year from invoicedate) as an,
	extract (month from invoicedate) as luna
from invoice
order by 1,2

-- a doua varianta - bazata pe SUBSTRING:
-- (stiind ca formatul datei este `2019-10-01`)
select distinct
	cast (SUBSTRING(cast (invoicedate as character(10)), 1, 4) as integer) as an,
	cast (SUBSTRING(cast (invoicedate as character(10)), 6, 2) as integer) as luna
from invoice
order by 1,2


---
-- a treia varianta - bazata SUBSTRING si pe `regular expression`:
-- anul este determinat folosind un sablon (pattern) care extrage primul grup de patru cifre ('[0-9]{4}')
-- luna este determinata folosind un sablon care extrage primul grup de doua cifre care succede
--  unei cratime '\-([0-9]{2})'; `\` este un `escape character`
select distinct
	cast (SUBSTRING(cast (invoicedate as character(10)), '[0-9]{4}') as integer) as an,
	cast (SUBSTRING(cast (invoicedate as character(10)), '\-([0-9]{2})') as integer) as luna
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
-- 1. pentru artistii cu numele lung de pana la 10 caractere,
--		se afiseaza numele intreg
-- 2. pentru artistii cu numele mai lung de 10 caractere se extrag cinci
--   	caractere, se adauga `...` la mijloc si se finalizeaza cu
-- 		ultimele cinci caractere
-- ############################################################################

-- solutie 1 - bazata pe LEFT si RIGHT
select artist.*,
	case
		when length(name) <= 10 then name
		else left(name, 5) || '...' || right(name, 5)
	end as nume_formatat,
	length(name) as lungime_nume
from artist

-- solutie 2 - bazata pe SUBSTRING
select artist.*,
	case
		when length(name) <= 10 then name
		else substring(name, 1, 5) || '...' ||
			substring(name, length(name)-4, length(name))
		end as nume_formatat,
	length(name) as lungime_nume
from artist


-- solutie 3 - bazata pe regular expression (REGEXP_REPLACE)
-- sablonul este impartit pe trei sectiuni, care identifica:
-- 		`\1`: primele cinci caractere '(^.{5})'
-- 		`\2`: caracterele de la mijloc '(.+)'
-- 		`\3`: ultimele cinci caractere '(.{5}$)'
-- in sirul returnat se includ numai sectiunile \1 si \3, intre care se intercaleaza `...`
SELECT artist.*,
	REGEXP_REPLACE(name,'(^.{5})(.+)(.{5}$)','\1...\3') as nume_formatat,
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
