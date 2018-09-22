select * from garzi
select * from doctori
select * from pacienti
select * from triaj

select * 
from triaj 
	inner join garzi on triaj.dataora_examinare between garzi.inceput_garda and garzi.sfirsit_garda

select triaj.idexaminare, dataora_examinare, numepacient, simptome, 
tratament_imediat, sectie_destinatie, numedoctor as "medic de garda" 
from triaj 
	inner join garzi on triaj.dataora_examinare between garzi.inceput_garda and garzi.sfirsit_garda
	inner join doctori on garzi.iddoctor = doctori.iddoctor
	inner join pacienti on triaj.idpacient = pacienti.idpacient
where extract(year from dataora_examinare) = 2008 and extract(month from dataora_examinare) = 1


select triaj.idexaminare, dataora_examinare, numepacient, simptome, tratament_imediat, sectie_destinatie, numedoctor as "medic de garda" 
from triaj 
	inner join garzi on triaj.dataora_examinare between garzi.inceput_garda and garzi.sfirsit_garda
	inner join doctori on garzi.iddoctor = doctori.iddoctor
	inner join pacienti on triaj.idpacient = pacienti.idpacient
where extract(year from dataora_examinare) = 2008 and extract(month from dataora_examinare) = 1 and 
	extract(day from dataora_examinare) in (4, 5)


select triaj.idexaminare, dataora_examinare, numepacient, simptome, tratament_imediat, sectie_destinatie, numedoctor as "medic de garda" 
from triaj 
	inner join garzi on triaj.dataora_examinare between garzi.inceput_garda and garzi.sfirsit_garda
	inner join doctori on garzi.iddoctor = doctori.iddoctor
	inner join pacienti on triaj.idpacient = pacienti.idpacient
where dataora_examinare between date'2008-01-04' and date'2008-01-05'
		

select triaj.idexaminare, dataora_examinare, numepacient, simptome, tratament_imediat, sectie_destinatie, numedoctor as "medic de garda" 
from triaj 
	inner join garzi on triaj.dataora_examinare between garzi.inceput_garda and garzi.sfirsit_garda
	inner join doctori on garzi.iddoctor = doctori.iddoctor
	inner join pacienti on triaj.idpacient = pacienti.idpacient
where dataora_examinare between timestamp'2008-01-04 00:00:00' and timestamp'2008-01-05 23:59:59'
