# Scripturi și tutoriale video - interogări SQL și tidyverse (R) pentru baza de date `chinook`

În R (tidyverse), pentru rularea scripturilor de interogare a BD `chinook` nu e nevoie să importați datele din PostgreSQL, ci puteți încarca fișierul `chinook.RData` din această secțiune.

Este posibil ca playerul implicit de pe OneDrive să nu funcționeze cum trebuie (pe calculatorul meu NU se aude sunetul la redarea directă pe OneDrive). De aceea, vă recomand să descărcați video-tutoriale și să le vizionați cu `VLC Player` sau ceva similar.

### Video-tutoriale (vor fi actualizate săptămânal în perioada februarie-mai):

#### 1. Schemele bazelor de date `chinook` și `rock`
- [Înregistrare Curs Baze de date 2021-02-16 CIG2](https://1drv.ms/v/s!AgPvmBEDzTOSitoIaNVx3kQboMWJWA?e=AauM6b)

#### 2. Crearea bazei de date `chinook` (și bazei de date `covid`) în PostgreSQL (pgAdmin); primele interogări SQL
- [Înregistrare `Curs Baze de date 2021-02-22 IE2`](https://1drv.ms/v/s!AgPvmBEDzTOSitxnFsPiIxcDHqainw?e=WtiiA5)
- Înregistrări mai vechi:
  - [descărcarea (de pe GitHub) fișierelor necesare creării și interogării BD `chinook` în SQL și tidyverse (înregistrare 2020-03-21)](https://1drv.ms/v/s!AgPvmBEDzTOSibR5SGeJMSwR4rqCJA?e=tseYlJ)
  - [crearea și popularea tabelelor bd `chinook` în PostgreSQL (înregistrare 2020-03-21)](https://1drv.ms/v/s!AgPvmBEDzTOSibR6MiHulPoMzD0f2g?e=nWPfr1)
  - [lansarea interogărilor SQL în `pgAdmin` (înregistrare 2020-03-22)](https://1drv.ms/v/s!AgPvmBEDzTOSibUAE_zQuzc3CMUaeg?e=ydheXU)

#### 3. R/RStudio - instalarea pachetelor, încărcarea datelor, sintaxa interogărilor `tidyverse`
- [Înregistrare Curs Baze de date 2021-03-01 IE2](https://1drv.ms/u/s!AgPvmBEDzTOSit1IWqrgDpNBVAjfWw?e=Gnacwa): utilizare R/RStudio, instalare pachete, ...
- [Înregistrare Curs Baze de date 2021-03-02 CIG2](https://1drv.ms/v/s!AgPvmBEDzTOSit1nwOFArzZExPslZQ?e=tTpt6w): utilizare R/RStudio, instalare pachete, ...
- [Tutorial import tabele PostgreSQL (versiuni anterioare Pg 13) în R](https://1drv.ms/v/s!AgPvmBEDzTOSit5l4-Z4bhGzSn0iwQ?e=nVbOfu): pachetul `RPostgreSQL`
- [Tutorial import tabele PostgreSQL 13 în R](https://1drv.ms/u/s!AgPvmBEDzTOSit5mOwPM5StvNvJHRg?e=fNlvHu)
- [Lansarea interogărilor tidyverse în RStudio (înregistrare 2020-03-22)](https://1drv.ms/v/s!AgPvmBEDzTOSibUEiYNYUCEjl1isFg?e=uiNRqz)

#### 4. Interogări SQL și `tidyverse` (1)
- [Înregistrare Curs Baze de date 2021-03-08 IE2](https://1drv.ms/u/s!AgPvmBEDzTOSit1op8PpdNxnpjFIYQ?e=YKLleZ): primele interogări `tidyverse`
- [Înțelegerea interogărilor SQL (1) - joncțiune (înregistrare 2020-03-22)](https://1drv.ms/v/s!AgPvmBEDzTOSibUG_8zl5QP6-oVjRA?e=lnNgma)
- [Înțelegerea interogărilor `tidyverse` (1) - joncțiune (înregistrare 2020-03-22)](https://1drv.ms/v/s!AgPvmBEDzTOSibUJ-fqM7oT9bsZS0Q?e=2YfFj1)
- [Joncțiuni, auto-joncțiuni (înregistrare Curs Baze de date 2021-03-15 IE2)](https://1drv.ms/v/s!AgPvmBEDzTOSibgwS8QZcO1xRb5JbQ?e=j007Qs)
- [Joncțiuni interne, reuniune, intersecție, diferență (înregistrare Curs Baze de date 2020-03-19/31 IE2)](https://1drv.ms/v/s!AgPvmBEDzTOSibgwS8QZcO1xRb5JbQ?e=j007Qs)

#### 5. Interogări SQL și `tidyverse` (2)
- [Valori NULL/NA, funcții-agregat (înregistrare Curs Baze de date 2020-03-26 IE2)](https://1drv.ms/v/s!AgPvmBEDzTOSibgx4cNAV8WpxFEtuQ?e=ej2Xs4)
- [Grupări (înregistrare Curs Baze de date 2020-04-01 SPE2)](https://1drv.ms/v/s!AgPvmBEDzTOSibgymaBsvIcuW5XBsA?e=N3CbYZ)
- [Joncțiuni externe (înregistrare Curs Baze de date 2020-04-08 SPE2)](https://1drv.ms/v/s!AgPvmBEDzTOSit5raaC4m4HJX7HJ2Q?e=krlBY7)
- [Recapitulare interogări pentru Testul 2 SQL/tidyverse (înregistrare Curs Baze de date 2020-04-09 IE2)](https://1drv.ms/v/s!AgPvmBEDzTOSibor-10d569CT8vxzw?e=yq2TCY)

#### 6. Interogări SQL și `tidyverse` (3)
- [Subconsultări (1) - WHERE și HAVING (înregistrare Curs Baze de date 2020-04-30 IE2)](https://1drv.ms/v/s!AgPvmBEDzTOSicEgYR6T3tc6FKZR1w?e=S36fBa)
- [Subconsultări (2) - WHERE, HAVING, diviziune (înregistrare Curs Baze de date 2020-04-29 SPE2)](https://1drv.ms/v/s!AgPvmBEDzTOSicEi6FoXT0PN4F44oA?e=RG8NRF)
- [Subconsultări (3) - `subconsultări` în tidyverse (înregistrare Curs Baze de date 2020-05-06 SPE2)](https://1drv.ms/v/s!AgPvmBEDzTOSicFSFSMgCtRtpk8ePw?e=5TBCbi)
- [Subconsultări (4) - FROM, expresii-tabelă, diviziune (înregistrare Curs Baze de date 2020-05-07 IE2)](https://1drv.ms/v/s!AgPvmBEDzTOSicFYSVWz67d_Vvx_bg?e=cJfixR)
