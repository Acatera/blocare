# Connection: dsLocal
# Host: server
# Saved: 2010-04-16 13:15:31
# 
SELECT DISTINCT * FROM (
SELECT CODFUR CODFC, DENFUR DENFC, ADRF ADR, IF(UPPER(EMAIL)="W","", EMAIL) EMAIL, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, "" FAX 
FROM QUALITY.FUR 
WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") UNION ALL 
SELECT CODFUR CODFC, DENFUR DENFC, ADRF ADR, IF(UPPER(EMAIL)="W","", EMAIL) EMAIL, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, "" FAX 
FROM FDSOFT.FUR 
WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") UNION ALL 
SELECT CODFUR CODFC, DENFUR DENFC, ADRF ADR, IF(UPPER(EMAIL)="W","", EMAIL) EMAIL, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, "" FAX 
FROM FSOFTWARE.FUR 
WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") UNION ALL 
SELECT CODFUR CODFC, DENFUR DENFC, ADRF ADR, IF(UPPER(EMAIL)="W","", EMAIL) EMAIL, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, "" FAX 
FROM FSERVICES.FUR 
WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") ORDER BY DENFC ASC, EMAIL) T 
GROUP BY CODFC, EMAIL ORDER BY DENFC ;

SELECT DISTINCT * FROM  (SELECT CODFUR CODFC, NUME DENFC, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, EMAIL, CODCONTRACTE, "" FAX, "" ADR FROM FDSOFT.CONTACTE WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") UNION ALL 
SELECT CODFUR CODFC, NUME DENFC, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, EMAIL, CODCONTRACTE, "" FAX, "" ADR FROM FSOFTWARE.CONTACTE WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") UNION ALL 
SELECT CODFUR CODFC, NUME DENFC, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, EMAIL, CODCONTRACTE, "" FAX, "" ADR FROM FSERVICES.CONTACTE WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") UNION ALL 
SELECT CODFUR CODFC, NUME DENFC, IF(LENGTH(TELEFON) < 6, "",TELEFON) TEL, EMAIL, CODCONTRACTE, "" FAX, "" ADR FROM QUALITY.CONTACTE WHERE CONCAT(EMAIL,TELEFON) NOT IN ("W","") ) T GROUP BY EMAIL LIMIT 2000
