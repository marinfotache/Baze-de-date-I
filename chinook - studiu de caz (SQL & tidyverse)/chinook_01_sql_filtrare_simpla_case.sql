-- ############################################################################
-- Universitatea Al.I.Cuza Iași / Al.I.Cuza University of Iasi (Romania)
-- Facultatea de Economie si Administrarea Afacerilor / Faculty of
--          Economics and Business Administration
-- Colectivul de Informatică Economică / Dept. of Business Information Systems
-- ############################################################################

-- ############################################################################
--        Studiu de caz: Interogări SQL pentru baza de date `chinook`
--        Case study: SQL Queries for `chinook` database
-- ############################################################################
-- 		 SQL01: Filtrare simpla, regular expressions, structuri CASE
-- 		 SQL01: One-table filters, regular expressions, CASE structures
-- ############################################################################
-- ultima actualizare / last update: 2023-12-01


-- Funcții/operatori/opțiuni SQL utilizate în acest script (și prezente
--      în subiectele de la testele Moodle următoare):

-- Some of the SQL features used in this script (and subsequent Moodle quizzes):

--  	`EXTRACT` (year, month, ...)
-- 		`CAST`
-- 		`SUBSTRING`
-- 		`REGEXP_REPLACE`
-- 		`LENGTH`
-- 		`CASE ... WHEN ...`
-- 		`LIKE`
-- 		`LENGTH`
-- 		`IS NULL`
-- 		`POSITION`
-- 		`SPLIT_PART`
-- 		`REPLACE`
-- 		`regexp_match`

-- `UPPER`, `LOWER`, ...
-- `NOT` ...
-- `IN` (lista de valori, nu sub-consultari / for list of values, not sub-queries!)
-- `TO_DATE` ...
-- 	`SUBSTR`
-- `LEFT`, `RIGHT`, ...




-- ############################################################################
--                    În ce ani s-au înregistrat vânzări?
-- ############################################################################
--                    Extract the years when sales occurred
-- ############################################################################

-------------------------------------------------------------------------------
-- prima notație pentru ordonare (specificarea coloanei de ordonare)
-------------------------------------------------------------------------------
-- 1st solution:
-------------------------------------------------------------------------------
select distinct extract (year from invoicedate) as an
from invoice
order by extract (year from invoicedate)


-------------------------------------------------------------------------------
-- a doua notație pentru ordonare 
-------------------------------------------------------------------------------
-- 2nd solution
-------------------------------------------------------------------------------
select distinct extract (year from invoicedate) as an
from invoice
order by an


-------------------------------------------------------------------------------
-- a treia notație pentru ordonare (specificarea poziției atributului de ordonare în rezultat)
-------------------------------------------------------------------------------
-- 3rd solution
-------------------------------------------------------------------------------
select distinct extract (year from invoicedate) as an
from invoice
order by 1


-------------------------------------------------------------------------------
-- a patra varianta - bazată pe SUBSTRING:
-- știind că formatul datei este `2019-10-01`, păstrăm numai primele patru caractere din dată,
--    care reprezintă anul;
-- prin funcția `cast`, convertim datele calendaristice în șiruri de caractere și, în final,
--  exprimăm rezultatul (anul calendaristic) ca număr întreg
-------------------------------------------------------------------------------
-- 4th solution - using CAST ans SUBSTRING
-------------------------------------------------------------------------------
select distinct cast (SUBSTRING(cast (invoicedate as character(10)), 1, 4) as integer) as an
from invoice
order by 1


-------------------------------------------------------------------------------
-- a cincea variantă - cu `regular expression` (extrage primele patru cifre):
-------------------------------------------------------------------------------
-- 5th solution - with `regular expression` to extract first four digits:
-------------------------------------------------------------------------------
select distinct cast (SUBSTRING(cast (invoicedate as character(10)), '[0-9]{4}') as integer) as an
from invoice
order by 1


-------------------------------------------------------------------------------
-- a șasea variantă - bazată tot pe `regular expression`:
-- știind că formatul datei este `2019-10-01`, înlocuim toate caracterele, începând cu prima cratimă (`-`)
--   cu "nimic"; astfel, păstrăm numai primele patru caractere din dată, care reprezintă anul;
-- prin funcția `cast`, convertim datele calendaristice în șiruri de caractere și, în final,
--  exprimăm rezultatul (anul calendaristic) ca număr întreg
-------------------------------------------------------------------------------
-- 6th solution - also with `regular expression` 
-------------------------------------------------------------------------------
select distinct cast (REGEXP_REPLACE(cast (invoicedate as character(10)), '\-.*', '') as integer) as an
from invoice
order by 1





-- ############################################################################
--  Extrageți lunile calendaristice (și anii) în care s-au înregistrat vânzări
-- ############################################################################
--  Extract the months (and their years) with sales
-- ############################################################################

-------------------------------------------------------------------------------
-- prima variantă - folosind funcțiile `year` și `month`
-------------------------------------------------------------------------------
-- 1st solution, with functions `year` and `month`
-------------------------------------------------------------------------------
select distinct extract (year from invoicedate) as an,
	extract (month from invoicedate) as luna
from invoice
order by 1,2


-------------------------------------------------------------------------------
-- a doua variantă - bazată pe SUBSTRING: (formatul datei este `2019-10-01`)
-------------------------------------------------------------------------------
-- 2nd solution is based on SUBSTRING
-------------------------------------------------------------------------------
select distinct
	cast (SUBSTRING(cast (invoicedate as character(10)), 1, 4) as integer) as an,
	cast (SUBSTRING(cast (invoicedate as character(10)), 6, 2) as integer) as luna
from invoice
order by 1,2


-------------------------------------------------------------------------------
-- a treia variantă - bazată SUBSTRING și pe `regular expression`:
-- anul este determinat folosind un șablon (pattern) care extrage primul grup de patru cifre ('[0-9]{4}')
-- luna este determinată folosind un șablon care extrage primul grup de două cifre care succede
--  unei cratime '\-([0-9]{2})'; `\` este un `escape character`
-------------------------------------------------------------------------------
-- 3rd solution uses `SUBSTRING`and regular expressions
-------------------------------------------------------------------------------
select distinct
	cast (SUBSTRING(cast (invoicedate as character(10)), '[0-9]{4}') as integer) as an,
	cast (SUBSTRING(cast (invoicedate as character(10)), '\-([0-9]{2})') as integer) as luna
from invoice
order by 1,2



-- ############################################################################
-- Care este lungimea numelui pentru fiecare artist/formatie?
-- ############################################################################
-- Extract the lenght (the number of characters) for each artist/band's name
-- ############################################################################
select artist.*, LENGTH(name) as lungime_nume
from artist


-- ############################################################################
--     Să se afișeze artiștii în ordinea descrescătoare a lungimii numelui
-- ############################################################################
--     Display artists/bands ordering (descending) them on their name's lenght
-- ############################################################################
select artist.*, LENGTH(name) as lungime_nume
from artist
order by LENGTH(name) desc



-- ############################################################################
-- Să se afișeze numele formatat al artiștilor, conform următoarei cerințe:
-- 1. pentru artiștii cu numele lung de până la 10 caractere,
--		se afișează numele întreg
-- 2. pentru artiștii cu numele mai lung de 10 caractere se extrag cinci
--   	caractere, se adaugă `...` la mijloc și se finalizează cu
-- 		ultimele cinci caractere
-- ############################################################################
-- Display the shortened name of the artists with the followihg rules:
-- 1. names shorter than 11 characters will be fully displayed
-- 2. names longer than 10 characters will be truncated:
--   	extract first 5 characters, concatenate with `...`, and then concatenate
-- 		with the last 5 characters from the name
-- ############################################################################

-------------------------------------------------------------------------------
-- solutie 1 - bazata pe LEFT si RIGHT
-------------------------------------------------------------------------------
-- sol. 1 is based on functions  `LEFT` and `RIGHT`
-------------------------------------------------------------------------------
select artist.*,
	case
		when length(name) <= 10 then name
		else left(name, 5) || '...' || right(name, 5)
	end as nume_formatat,
	length(name) as lungime_nume
from artist


-------------------------------------------------------------------------------
-- solutie 2 - bazata pe SUBSTRING
-------------------------------------------------------------------------------
-- sol. 2 is based on functions  `SUBSTRING` (and `LENGTH`)
-------------------------------------------------------------------------------
select artist.*,
	case
		when length(name) <= 10 then name
		else substring(name, 1, 5) || '...' ||
			substring(name, length(name)-4, length(name))
		end as nume_formatat,
	length(name) as lungime_nume
from artist

-------------------------------------------------------------------------------
-- solutie 3 - bazata pe regular expression (REGEXP_REPLACE)
-- sablonul este impartit pe trei sectiuni, care identifica:
-- 		`\1`: primele cinci caractere '(^.{5})'
-- 		`\2`: caracterele de la mijloc '(.+)'
-- 		`\3`: ultimele cinci caractere '(.{5}$)'
-- in sirul returnat se includ numai sectiunile \1 si \3, intre care se intercaleaza `...`
-------------------------------------------------------------------------------
-- 3rd solution is based on regular expression
-------------------------------------------------------------------------------
SELECT artist.*,
	REGEXP_REPLACE(name,'(^.{5})(.+)(.{5}$)','\1...\3') as nume_formatat,
	length(name) as lungime_nume
FROM artist




-- ############################################################################
-- Care sunt artiștii/formațiile cu numele alcătuit dintr-un singur cuvânt?
-- 					(adică numele lor nu conține niciun spațiu)
-- ############################################################################
-- Extract single-word-ed artist names (names containing no white space)
-- ############################################################################

-------------------------------------------------------------------------------
-- `LIKE`
-------------------------------------------------------------------------------
select *
from artist
where name not like '% %'


-------------------------------------------------------------------------------
-- `LIKE` + `CASE`
-------------------------------------------------------------------------------
select *
from artist
where case when name like '% %' then false else true end


-------------------------------------------------------------------------------
-- `regexp_match` (regular expression)
-------------------------------------------------------------------------------
SELECT *, regexp_match(name, ' ')
FROM artist
WHERE regexp_match(name, ' ') IS NULL


-------------------------------------------------------------------------------
-- POSITION
-------------------------------------------------------------------------------
SELECT *
FROM artist
WHERE POSITION(' ' IN NAME) = 0


-------------------------------------------------------------------------------
-- SPLIT_PART
-------------------------------------------------------------------------------
SELECT *,
	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant
FROM artist
WHERE SPLIT_PART(name, ' ', 2) = ''


-------------------------------------------------------------------------------
-- REPLACE - sol.1
-------------------------------------------------------------------------------
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii
FROM artist
WHERE name = REPLACE(name, ' ', '')


-------------------------------------------------------------------------------
-- REPLACE - sol.2
-------------------------------------------------------------------------------
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
FROM artist
WHERE LENGTH(name) = LENGTH(REPLACE(name, ' ', ''))



-- ############################################################################
-- Care sunt artiștii/formatiile cu numele alcătuit din cel puțin
--       două cuvinte? (numele lor conține cel puțin un spațiu)
-- ############################################################################
-- Extract multi-word-ed artist names (names containing at least one whitespace)
-- ############################################################################

-------------------------------------------------------------------------------
-- `LIKE`
-------------------------------------------------------------------------------
select *
from artist
where name like '% %'


-------------------------------------------------------------------------------
-- `regexp_match` (regular expression)
-------------------------------------------------------------------------------
SELECT *
FROM artist
WHERE regexp_match(name, ' ') IS NOT NULL


-------------------------------------------------------------------------------
-- POSITION
-------------------------------------------------------------------------------
SELECT *, POSITION(' ' IN NAME)
FROM artist
WHERE POSITION(' ' IN NAME) > 0


-------------------------------------------------------------------------------
-- SPLIT_PART
-------------------------------------------------------------------------------
SELECT *,
	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant
FROM artist
WHERE SPLIT_PART(name, ' ', 2) <> ''


-------------------------------------------------------------------------------
-- REPLACE
-------------------------------------------------------------------------------
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
FROM artist
WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) > 0



-- ############################################################################
-- Care sunt artiștii/formațiile cu numele alcătuit din exact două cuvinte?
--         (adică numele lor conține un singur spațiu)
-- ############################################################################
-- Extract two-word-ed artist names (names containing a single whitespace)
-- ############################################################################

-------------------------------------------------------------------------------
-- `LIKE`
-------------------------------------------------------------------------------
select *
from artist
where name like '% %' and name not like '% % %'


-------------------------------------------------------------------------------
-- `regexp_match` (regular expression)
-------------------------------------------------------------------------------
SELECT *
FROM artist
WHERE
	regexp_match(name, '.* .*') IS NOT NULL -- name contains at least a space
	AND
	regexp_match(name, '.* .* .*') IS NULL  -- name DOES NOT contain two spaces


-------------------------------------------------------------------------------
-- SPLIT_PART
-------------------------------------------------------------------------------
SELECT *,
	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant,
	SPLIT_PART(name, ' ', 3) AS al_treilea_cuvant
FROM artist
WHERE SPLIT_PART(name, ' ', 2) <> '' and SPLIT_PART(name, ' ', 3) = ''


-------------------------------------------------------------------------------
-- REPLACE
-------------------------------------------------------------------------------
SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
FROM artist
WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 1



-- ############################################################################
--            Care sunt primii trei ani s-au inregistrat vanzari?
-- ############################################################################
--            Extract first sales years
-- ############################################################################
select distinct extract (year from invoicedate) as an
from invoice
order by extract (year from invoicedate)
limit 3




-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################


-- ############################################################################
-- Extrageti numele de utilizator de pe contul de e-mail al fiecarui angajat
-- ############################################################################
-- Extract the usernames from the employees' e-mail addresses
-- ############################################################################


-- ############################################################################
-- Extrageti toate serverele de e-mail  (ex. `gmail.com`) ale clientilor
-- ############################################################################
-- Extract the e-mail servers  (e.g., `gmail.com`) from customers'
--     e-mail addresses
-- ############################################################################



-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################


select current_date ;


select current_date from playlist;


select * from track where name like 'Custard%' ;


select * from artist where upper(name) like 'AC%'


select e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age
from employee e ;
