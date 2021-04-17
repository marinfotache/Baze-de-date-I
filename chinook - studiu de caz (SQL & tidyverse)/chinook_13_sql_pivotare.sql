-- ############################################################################
--                Interogari BD Chinook - IE, CIG si SPE:
-- ############################################################################
--
-- 13: Pivotare in SQL (PostgreSQL)
--
-- ultima actualizare: 2020-05-06



-- ############################################################################
-- 			Afisati, pentru fiecare client, pe coloane separate,
-- 					vanzarile pe anii 2010, 2011 si 2012 (reluare)
-- ############################################################################

-- solutie bazata pe subconsultari in clauza FROM
SELECT lastname || ' ' || firstname AS customer_name,
	city, state, country,
	COALESCE(sales2011.sales, 0) AS sales2010,
	COALESCE(sales2011.sales, 0) AS sales2011,
	COALESCE(sales2012.sales, 0) AS sales2012
FROM customer
	LEFT JOIN
			(SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2010
		 	 GROUP BY customerid) sales2010
		ON customer.customerid = sales2010.customerid
	LEFT JOIN
			(SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2011
		 	 GROUP BY customerid) sales2011
		ON customer.customerid = sales2011.customerid
	LEFT JOIN
			(SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2012
		 	 GROUP BY customerid) sales2012
		ON customer.customerid = sales2012.customerid
ORDER BY 1


-- solutie bazata pe jonctiunea externa a tabelei `customer` cu trei expresii-tabela
WITH
	sales2010 AS (SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2010
		 	 GROUP BY customerid),
	sales2011 AS (SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2011
		 	 GROUP BY customerid),
	sales2012 AS (SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2012
		 	 GROUP BY customerid)
SELECT lastname || ' ' || firstname AS customer_name,
	city, state, country,
	COALESCE(sales2011.sales, 0) AS sales2010,
	COALESCE(sales2011.sales, 0) AS sales2011,
	COALESCE(sales2012.sales, 0) AS sales2012
FROM customer
	LEFT JOIN sales2010 ON customer.customerid = sales2010.customerid
	LEFT JOIN sales2011 ON customer.customerid = sales2011.customerid
	LEFT JOIN sales2012 ON customer.customerid = sales2012.customerid
ORDER BY 1


-- solutie noua, bazata pe functia CROSSTAB (in alte servere BD functia se numeste PIVOT)
-- comanda `CREATE EXTENSION tablefunc;` se executa o singura data
--CREATE EXTENSION tablefunc;

SELECT *
FROM crosstab(
   -- central query
   'SELECT lastname || '' '' || firstname as customer_name,
		city, state, country,
		extract (year from invoicedate) as year, SUM(total)
    FROM customer NATURAL JOIN invoice
	WHERE extract (year from invoicedate) BETWEEN 2010 AND 2012
	GROUP BY lastname || '' '' || firstname, city, state, country, extract (year from invoicedate) ORDER BY 1',
   -- query to generate the horizontal header
   'SELECT DISTINCT extract (year from invoicedate) FROM invoice
	WHERE extract (year from invoicedate) BETWEEN 2010 AND 2012 ORDER BY extract (year from invoicedate)')
  AS ("customer_name" varchar, "city" varchar, "state" varchar, "country" varchar,
      "2010" numeric,
      "2011" numeric,
      "2012" numeric);

-- notice the NULL values



-- ############################################################################
-- 			Afisati, pentru fiecare client, pe coloane separate,
-- 					vanzarile pe tori anii (2009-2013)
-- ############################################################################

SELECT * FROM crosstab(
   -- central query
   'SELECT lastname || '' '' || firstname as customer_name,
		city, state, country,
		extract (year from invoicedate) as year, SUM(total)
    FROM customer NATURAL JOIN invoice
	GROUP BY lastname || '' '' || firstname, city, state, country, extract (year from invoicedate) ORDER BY 1',
   -- query to generate the horizontal header
   'SELECT DISTINCT extract (year from invoicedate) FROM invoice ORDER BY extract (year from invoicedate)')
  AS ("customer_name" varchar, "city" varchar, "state" varchar, "country" varchar,
      "2009" numeric,
      "2010" numeric,
      "2011" numeric,
      "2012" numeric,
      "2013" numeric);



-- ############################################################################
-- 						Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################









-- ############################################################################
-- 						La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################
