--- SELECT ---
--------------

/* PART 4 */ 

/*
 QUERY
*/

SELECT *
FROM animals;

UPDATE ANIMALS SET 
    FATHER_ID = (SELECT ID FROM ANIMALS WHERE UPPER(NAME) LIKE UPPER('bruno')),
    MOTHER_ID = (SELECT ID FROM ANIMALS WHERE UPPER(NAME) LIKE UPPER('amelia'))
WHERE ID = (SELECT ID FROM ANIMALS WHERE UPPER(NAME) LIKE UPPER('cecyl'));    
        
--------------------------------------------------------------------------------------------------------
/* PART 5 */

/*
 QUERY
*/

SELECT *
FROM staff;

-- WRONG UPDATE
UPDATE STAFF SET 
    SUPERVISOR_ID = (SELECT ID FROM STAFF WHERE UPPER(NAME)LIKE UPPER('ewa'))
WHERE ID <> (SELECT ID FROM STAFF WHERE UPPER(NAME)LIKE UPPER('ewa')); 

-- CLEANING
UPDATE STAFF SET 
    SUPERVISOR_ID = NULL;

-- CORRECT UPDATE
UPDATE STAFF SET 
    SUPERVISOR_ID = (SELECT ID FROM STAFF WHERE UPPER(NAME)LIKE UPPER('ewa'))
WHERE ID <> (SELECT ID FROM STAFF WHERE UPPER(NAME)LIKE UPPER('ewa'))
AND DIVISION_ID <> (SELECT ID FROM DIVISIONS WHERE UPPER(NAME) LIKE UPPER('admin%')); 

-- CHECK
SELECT *
FROM DIVISIONS;

--------------------------------------------------------------------------------------------------------
/* PART 6.

/*
 QUERY
*/

--------------------------------------------------------------------------------------------------------
-- 6.1


SELECT ID IDENTYFIKATOR , NAME IMIE, SURNAME NAZWISKO
FROM STAFF;	
	
--------------------------------------------------------------------------------------------------------
-- 6.2


SELECT NAME || ' is the ' || SPECIES AS "OPIS ZWIERZAKA"
FROM ANIMALS;	
	
--------------------------------------------------------------------------------------------------------
-- 6.3


SELECT COUNT(*)
FROM ANIMALS;	
	
--------------------------------------------------------------------------------------------------------
-- 6.4


SELECT SPECIES, COUNT(*)
FROM ANIMALS
GROUP BY SPECIES;	
	
--------------------------------------------------------------------------------------------------------
-- 6.5

	
SELECT *
FROM ANIMALS;

SELECT NAME 
FROM ANIMALS
WHERE FATHER_ID IS NULL;
	
--------------------------------------------------------------------------------------------------------
-- 6.6

	
SELECT * FROM ANIMALS WHERE
LENGTH(NAME) = (
SELECT MAX(LENGTH(NAME)) FROM ANIMALS);

SELECT * FROM (
SELECT NAME
FROM ANIMALS
ORDER BY LENGTH(NAME) DESC)
WHERE ROWNUM = 1;
	
--------------------------------------------------------------------------------------------------------
-- 6.7

	
SELECT COUNT(ID) AS "ILOSC PRACOWNIKOW"
FROM DIVISIONS;
	
--------------------------------------------------------------------------------------------------------
-- 6.8

	
SELECT SURNAME AS "PRACOWNICY NA B"
FROM STAFF
WHERE UPPER(NAME) LIKE UPPER('B%');
	
--------------------------------------------------------------------------------------------------------
-- 6.9

	
SELECT DISTINCT LOWER(NAME) || '.' || LOWER(SURNAME) || '@thezoo.pl'
AS "MAIL PRACOWNIKA"
FROM STAFF;
	
--------------------------------------------------------------------------------------------------------
-- 6.10


SELECT COUNT(SURNAME) AS "ILE MAMY OSOB"
FROM STAFF
WHERE NAME IN(
    SELECT  SUBSTR(SURNAME, 1, 1) FROM STAFF
)
GROUP BY (SELECT DISTINCT SUBSTRING(SURNAME, 1, 2) FROM STAFF);

SELECT  SUBSTR(SURNAME, 1, 1),  FROM STAFF;

SELECT  'ZACZYNA SIE NA ' || SUBSTR(SURNAME, 1, 1), COUNT(*)  
AS "PRACOWNICY NA DANA LITERE"
FROM STAFF GROUP BY SUBSTR(SURNAME, 1, 1);

SELECT  SURNAME, COUNT(*)  
FROM STAFF GROUP BY SUBSTR(SURNAME, 1, 1);	
	
--------------------------------------------------------------------------------------------------------
-- 6.11

	
SELECT NAME
FROM ANIMALS
WHERE BIRTH_DATE >= TO_DATE('2011/01/01', 'yyyy/mm/dd');
	
--------------------------------------------------------------------------------------------------------
-- 6.12


SELECT NAME
FROM ANIMALS
--WHERE EXTRACT(YEAR FROM TO_DATE(BIRTH_DATE, 'yyyy/mm/dd')) = 2003;
WHERE EXTRACT(YEAR FROM BIRTH_DATE) = 2003;

SELECT EXTRACT(YEAR FROM TO_DATE('2008/01/03', 'yyyy/mm/dd'))
FROM DUAL;
	
--------------------------------------------------------------------------------------------------------
-- 6.13

	
SELECT D.ID, S.NAME
FROM DIVISIONS D
JOIN STAFF S
ON D.ID = S.DIVISION_ID;

SELECT D.ID, COUNT(*)
FROM DIVISIONS D
JOIN STAFF S
ON D.ID = S.DIVISION_ID
GROUP BY D.ID;

SELECT DIVISION_ID, COUNT(*)
FROM STAFF
GROUP BY DIVISION_ID;
	
--------------------------------------------------------------------------------------------------------
-- 6.14

	
SELECT RESPONSIBLE_PERSON_ID, COUNT(*)
FROM ANIMALS
GROUP BY RESPONSIBLE_PERSON_ID;

SELECT RESPONSIBLE_PERSON_ID, SPECIES, ID
FROM ANIMALS;

SELECT RESPONSIBLE_PERSON_ID, SPECIES, COUNT(*), COUNT(DISTINCT SPECIES)
FROM ANIMALS
GROUP BY RESPONSIBLE_PERSON_ID, SPECIES;	
	
--------------------------------------------------------------------------------------------------------
-- 6.15


SELECT NAME
FROM STAFF
WHERE GENDER LIKE 'F'
  AND (LOWER(SPECIALIZATION) LIKE LOWER('Birds') 
    OR LOWER(SPECIALIZATION) LIKE LOWER('Mammals'))
  AND LOWER(ADDRESS_CITY) NOT LIKE LOWER('Warszawa');
  
--------------------------------------------------------------------------------------------------------
-- 6.17


SELECT LOWER(NAME) AS NAEME, UPPER(SURNAME) AS SURNAME
FROM STAFF; 

--------------------------------------------------------------------------------------------------------
/* PART 7 */

/*
 QUERY
*/

--------------------------------------------------------------------------------------------------------
-- 7.1


SELECT D.NAME, COUNT(*)
FROM STAFF S
JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
GROUP BY D.NAME
ORDER BY D.NAME;	
	
--------------------------------------------------------------------------------------------------------
-- 7.2

	
SELECT D.NAME, COUNT(S.ID) WORKERS
FROM STAFF S
RIGHT JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
GROUP BY D.NAME;
	
--------------------------------------------------------------------------------------------------------
-- 7.3

	
SELECT D.NAME, COUNT(S.ID) WORKERS
FROM STAFF S
RIGHT JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
GROUP BY D.NAME
HAVING COUNT(S.ID) < 5;

--------------------------------------------------------------------------------------------------------
-- 7.4

	
SELECT S.ID, S.NAME, S.SURNAME, D.NAME
FROM STAFF S
JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID;
	
--------------------------------------------------------------------------------------------------------
-- 7.5


SELECT A.NAME "ANIMALS NAME", S.NAME "PERSON NAME", S.SURNAME "PERSON SURNAME"
FROM ANIMALS A
JOIN STAFF S
ON A.RESPONSIBLE_PERSON_ID = S.ID;
	
--------------------------------------------------------------------------------------------------------
-- 7.6


SELECT 
    S.SURNAME "PERSON SURNAME"
    ,COUNT(S.NAME)
FROM ANIMALS A
JOIN STAFF S
ON A.RESPONSIBLE_PERSON_ID = S.ID
GROUP BY  S.SURNAME 
HAVING COUNT(S.NAME) = (
    SELECT MAX(COUNT(RESPONSIBLE_PERSON_ID))
    FROM ANIMALS
    GROUP BY RESPONSIBLE_PERSON_ID );	
	
--------------------------------------------------------------------------------------------------------
-- 7.7

	
SELECT D.ID, D.NAME
FROM STAFF S
JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
WHERE GENDER = 'M'
GROUP BY D.ID, D.NAME
HAVING COUNT(D.ID) > 5;
	
--------------------------------------------------------------------------------------------------------
-- 7.8

	
SELECT S.DIVISION_ID, D.NAME, COUNT(S.DIVISION_ID) "NUMBER OF WORKERS"
FROM STAFF S
JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
WHERE GENDER = 'F'
GROUP BY S.DIVISION_ID, D.NAME
HAVING COUNT(S.DIVISION_ID) < 2;

--- ALTERNATIVE SOLUTION

    SELECT D.ID, D.NAME ---, COUNT(S.DIVISION_ID) "NUMBER OF WORKERS"
    FROM DIVISIONS D
    JOIN STAFF S
    ON D.ID = S.DIVISION_ID
    WHERE GENDER = 'F'
    GROUP BY D.ID, D.NAME
    HAVING COUNT(*) < 2
UNION
    SELECT D.ID, D.NAME ---, COUNT(S.DIVISION_ID) "NUMBER OF WORKERS"
    FROM DIVISIONS D
    LEFT JOIN STAFF S
    ON D.ID = S.DIVISION_ID
    WHERE GENDER = 'F'
    GROUP BY D.ID, D.NAME
    HAVING COUNT(S.ID) = 0;
	
--------------------------------------------------------------------------------------------------------
-- 7.9


SELECT F.NAME FROM
    (SELECT D.ID, D.NAME, S.GENDER 
    FROM STAFF S
    JOIN DIVISIONS D
    ON S.DIVISION_ID = D.ID
    WHERE GENDER IN('F')) F
JOIN (
    SELECT D.ID, D.NAME, S.GENDER 
    FROM STAFF S
    JOIN DIVISIONS D
    ON S.DIVISION_ID = D.ID
    WHERE GENDER IN('M')) M
ON F.ID = M.ID;

--- ALTERNATIVE SOLUTION

SELECT D.ID, D.NAME
FROM DIVISIONS D
INNER JOIN (
    SELECT DIVISION_ID FROM STAFF WHERE GENDER = 'F'
    AND DIVISION_ID IS NOT NULL GROUP BY DIVISION_ID) A
ON D.ID = A.DIVISION_ID
INNER JOIN (
    SELECT DIVISION_ID FROM STAFF WHERE GENDER = 'M'
    AND DIVISION_ID IS NOT NULL GROUP BY DIVISION_ID) A1
ON D.ID = A1.DIVISION_ID;    

SELECT ID, NAME
FROM DIVISIONS D
WHERE EXISTS (
        SELECT ID
        FROM STAFF
        WHERE GENDER = 'M' AND 
            STAFF.DIVISION_ID = D.ID)
    AND EXISTS (
        SELECT ID 
        FROM STAFF 
        WHERE GENDER = 'F'
            AND STAFF.DIVISION_ID = D.ID);   
			
--------------------------------------------------------------------------------------------------------
-- 7.10	


SELECT D.NAME, COUNT(S.ID)
FROM STAFF S
JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
GROUP BY D.NAME
HAVING(COUNT(S.ID) < 
    (SELECT COUNT(DIVISION_ID)
    FROM STAFF
    WHERE DIVISION_ID = (
            SELECT ID 
            FROM DIVISIONS
            WHERE NAME LIKE 'ADMIN%') 
    ));	
	
--------------------------------------------------------------------------------------------------------
-- 7.11

	
SELECT D.NAME, S.GENDER, COUNT(S.GENDER) 
FROM STAFF S
JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
GROUP BY D.NAME, S.GENDER
HAVING(
    --1 
    (S.GENDER = 'M' AND COUNT(S.GENDER) > 5)
    OR
    --2
    (S.GENDER = 'F' AND COUNT(S.GENDER) < 2)
    )
ORDER BY D.NAME;

---- ALTERNATIVE SOLUTION

SELECT D.ID, D.NAME
FROM DIVISIONS D
WHERE 5 < (
    SELECT COUNT(*)
    FROM STAFF
    WHERE D.ID = STAFF.DIVISION_ID
        AND STAFF.GENDER = 'M')
 OR 2 > (
    SELECT COUNT(*)
    FROM STAFF
    WHERE D.ID = STAFF.DIVISION_ID
        AND STAFF.GENDER ='F');
		
--------------------------------------------------------------------------------------------------------
-- 7.12	

	
SELECT D.NAME
FROM DIVISIONS D
JOIN STAFF S
ON S.DIVISION_ID = D.ID
GROUP BY D.NAME
HAVING (
    COUNT(CASE WHEN S.GENDER = 'M' THEN 1 ELSE NULL END) <
    COUNT(CASE WHEN S.GENDER = 'F' THEN 1 ELSE NULL END)
);

--------------------------------------------------------------------------------------------------------
-- 7.13


SELECT D.ID, D.NAME, COUNT(*)
FROM STAFF S
JOIN DIVISIONS D
ON S.DIVISION_ID = D.ID
WHERE GENDER = 'F'
GROUP BY D.ID, D.NAME;

-- ALTERNATIVE SOLUTION

SELECT DISTINCT D.ID, D.NAME,
    (
        SELECT COUNT(*) FROM STAFF S2
        WHERE S2.DIVISION_ID = D.ID
        AND S2.GENDER = 'F'
    ) GRUOPING
FROM DIVISIONS D
JOIN STAFF S
ON D.ID = S.DIVISION_ID;
	
--------------------------------------------------------------------------------------------------------
-- 7.14

	
SELECT DISTINCT D.ID, D.NAME, 
    (
        (SELECT COUNT(*) FROM STAFF E2 WHERE E2.DIVISION_ID = D.ID AND E2.GENDER = 'F')/
        (SELECT COUNT(*) FROM STAFF E3 WHERE E3.DIVISION_ID = D.ID)    
    ) * 100 AS PARTICIPATION
FROM DIVISIONS D JOIN STAFF E ON E.DIVISION_ID = D.ID;    
	
--------------------------------------------------------------------------------------------------------
-- 7.15

	
SELECT FV.ID,FV.NAME FROM (
    SELECT DISTINCT D.ID, D.NAME, (  
        (
        (SELECT COUNT(*) FROM STAFF E2 WHERE E2.DIVISION_ID = D.ID AND E2.GENDER = 'F')/
        (SELECT COUNT(*) FROM STAFF E3 WHERE E3.DIVISION_ID = D.ID)    
        ) * 100 ) AS PERCENTAGE
        FROM DIVISIONS D JOIN STAFF E ON E.DIVISION_ID = D.ID )  FV
        WHERE FV.PERCENTAGE > 75;
		
--------------------------------------------------------------------------------------------------------
-- 7.16


SELECT (
    SELECT COUNT(*) FROM STAFF S1
    WHERE S1 .GENDER = 'F') /
    (SELECT COUNT(*) FROM STAFF S2)
FROM DUAL;

--------------------------------------------------------------------------------------------------------
-- 7.17	


	SELECT DISTINCT ID, NAME, PERCENTAGE
FROM (
    SELECT D.ID AS ID, D.NAME AS NAME,
        (SELECT COUNT(*) FROM STAFF E2 WHERE E2.DIVISION_ID = D.ID AND GENDER = 'F')/
        (SELECT COUNT(*) FROM STAFF E3 WHERE E3.DIVISION_ID = D.ID) AS PERCENTAGE
    FROM DIVISIONS D
    JOIN STAFF E
    ON E.DIVISION_ID = D.ID
    ) TEST
WHERE PERCENTAGE > (
        (SELECT 
            (SELECT COUNT(*) FROM STAFF S1 WHERE S1.GENDER = 'F')/
            (SELECT COUNT(*) FROM STAFF S2) TOTALS
    FROM DUAL));
	
--------------------------------------------------------------------------------------------------------
-- 7.18


SELECT S1.ID, S1.NAME SUPERVISOR, S1.SURNAME, S2.ID, S2.NAME, S2.SURNAME
FROM STAFF S1
JOIN STAFF S2
ON S1.SUPERVISOR_ID = S2.ID;
	
--------------------------------------------------------------------------------------------------------
-- 7.19

	
SELECT S1.ID, S1.NAME SUPERVISOR, S1.SURNAME, S2.ID, S2.NAME, S2.SURNAME
FROM STAFF S1
LEFT JOIN STAFF S2
ON S1.SUPERVISOR_ID = S2.ID;
	
--------------------------------------------------------------------------------------------------------
-- 7.20	


SELECT S1.ID, S1.NAME SUPERVISOR, S1.SURNAME,
    CASE 
        WHEN S2.SURNAME IS NULL THEN 'BOSS'
        ELSE S2.SURNAME || ' ' || S2.NAME
    END AS "WHO IS WHO"
FROM STAFF S1
LEFT JOIN STAFF S2
ON S1.SUPERVISOR_ID = S2.ID;
	
--------------------------------------------------------------------------------------------------------
-- 7.21	

	
SELECT A1.ID, A1.NAME,
    FATHER.ID, FATHER.NAME,
    MOTHER.ID, MOTHER.NAME
FROM ANIMALS A1
JOIN ANIMALS FATHER 
ON A1.FATHER_ID = FATHER.ID
JOIN ANIMALS MOTHER 
ON A1.MOTHER_ID = MOTHER.ID;
	
--------------------------------------------------------------------------------------------------------
-- 7.22


SELECT A1.ID, A1.NAME ANIMAL_NAME,
    FATHER.ID, FATHER.NAME FATHER_NAME,
    MOTHER.ID, MOTHER.NAME MOTHER_NAME
FROM ANIMALS A1
LEFT JOIN ANIMALS FATHER 
ON A1.FATHER_ID = FATHER.ID
LEFT JOIN ANIMALS MOTHER 
ON A1.MOTHER_ID = MOTHER.ID;

SELECT *
FROM ANIMALS;
	
--------------------------------------------------------------------------------------------------------
-- 7.23


SELECT GENDER, RESPONSIBLE_PERSON_ID, COUNT(GENDER)
FROM ANIMALS
GROUP BY GENDER, RESPONSIBLE_PERSON_ID;

SELECT ST.NAME, ST.SURNAME
FROM ANIMALS AN
JOIN STAFF ST
ON AN.RESPONSIBLE_PERSON_ID = ST.ID;

-- MALE
SELECT GENDER, RESPONSIBLE_PERSON_ID, COUNT(GENDER)
FROM ANIMALS
WHERE GENDER = 'F'
GROUP BY GENDER, RESPONSIBLE_PERSON_ID;

-- FEMALE
SELECT GENDER, RESPONSIBLE_PERSON_ID, COUNT(GENDER)
FROM ANIMALS
WHERE GENDER = 'M'
GROUP BY GENDER, RESPONSIBLE_PERSON_ID;

SELECT * FROM 
    (SELECT RESPONSIBLE_PERSON_ID, COUNT(GENDER) ILOSC_SAMIC
    FROM ANIMALS
    WHERE GENDER = 'F'
    GROUP BY RESPONSIBLE_PERSON_ID) SAMICE
FULL JOIN
-- MALE
    (SELECT RESPONSIBLE_PERSON_ID, COUNT(GENDER) ILOSC_SAMCOW
    FROM ANIMALS
    WHERE GENDER = 'M'
    GROUP BY RESPONSIBLE_PERSON_ID) SAMCE
ON SAMICE.RESPONSIBLE_PERSON_ID = SAMCE.RESPONSIBLE_PERSON_ID 
WHERE NVL(ILOSC_SAMCOW, 0) > NVL(ILOSC_SAMIC, 0);

-- ALTERNATIVE SOLUTION
SELECT DISTINCT S.ID, S.NAME, S.SURNAME
FROM STAFF S
JOIN ANIMALS A
ON S.ID = A.RESPONSIBLE_PERSON_ID
WHERE 
    (SELECT COUNT(*) FROM ANIMALS A2
    WHERE A2.RESPONSIBLE_PERSON_ID = S.ID
    AND A2.GENDER = 'M')
    >
    (SELECT COUNT(*) FROM ANIMALS A3
    WHERE A3.RESPONSIBLE_PERSON_ID = S.ID
    AND A3.GENDER = 'F');

--------------------------------------------------------------------------------------------------------
-- 7.24


SELECT NAME, SURNAME FROM STAFF
WHERE ID IN (SELECT RESPONSIBLE_PERSON_ID FROM ANIMALS
            GROUP BY RESPONSIBLE_PERSON_ID
            HAVING COUNT(DISTINCT SPECIES) > 1);

SELECT 	RESPONSIBLE_PERSON_ID, STAFF.NAME, STAFF.SURNAME, COUNT(DISTINCT SPECIES)
FROM ANIMALS
JOIN STAFF
ON RESPONSIBLE_PERSON_ID = STAFF.ID
GROUP BY RESPONSIBLE_PERSON_ID, STAFF.NAME, STAFF.SURNAME
HAVING COUNT(DISTINCT SPECIES) > 1;

--------------------------------------------------------------------------------------------------------
-- 7.25	


SELECT * FROM ANIMALS;

SELECT RESPONSIBLE_PERSON_ID, COUNT(DISTINCT SPECIES)
FROM ANIMALS
GROUP BY RESPONSIBLE_PERSON_ID;

SELECT RESPONSIBLE_PERSON_ID, COUNT(DISTINCT SPECIES)
FROM ANIMALS A
JOIN STAFF S
ON A.RESPONSIBLE_PERSON_ID = S.ID
GROUP BY RESPONSIBLE_PERSON_ID
HAVING COUNT(DISTINCT SPECIES) > 1;

SELECT ID, NAME, SURNAME
FROM STAFF
WHERE ID IN(
        SELECT RESPONSIBLE_PERSON_ID
        FROM ANIMALS A
        GROUP BY RESPONSIBLE_PERSON_ID
        HAVING COUNT(DISTINCT SPECIES) = COUNT(ID)
);

SELECT NAME, (SELECT AVG(ID) FROM STAFF WHERE NAME = S.NAME)
FROM STAFF S;

--------------------------------------------------------------------------------------------------------
-- 7.26	


-- SHOW STAFF
SELECT * 
FROM STAFF;

-- SHOW ANIMALS
SELECT * 
FROM ANIMALS;

-- SHOW STH.
SELECT RESPONSIBLE_PERSON_ID "OSOBA ODPOWIEDZIALNA", COUNT(*) "LICZBA ZWIERZAKOW", MAX(ID)
FROM ANIMALS
GROUP BY RESPONSIBLE_PERSON_ID, ID;

SELECT COUNT(ID)
FROM ANIMALS;

SELECT COUNT(ID)
FROM STAFF
WHERE DIVISION_ID <> (SELECT ID FROM DIVISIONS WHERE NAME LIKE 'ADMIN%');

SELECT COUNT(ID) / COUNT(DISTINCT RESPONSIBLE_PERSON_ID) "SRED. ILOSC OPIEKUNOW"
FROM ANIMALS;

-- ANSWER
SELECT RESPONSIBLE_PERSON_ID "OSOBA ODPOWIEDZIALNA", COUNT(ID) "LICZBA ZWIERZAKOW"
FROM ANIMALS
--WHERE COUNT(ID) > (SELECT COUNT(ID) / COUNT(DISTINCT RESPONSIBLE_PERSON_ID) "SRED. ILOSC OPIEKUNOW"
--FROM ANIMALS)
GROUP BY RESPONSIBLE_PERSON_ID
HAVING COUNT(ID) > (SELECT COUNT(ID) / COUNT(DISTINCT RESPONSIBLE_PERSON_ID) "SRED. ILOSC OPIEKUNOW"
FROM ANIMALS);

--------------------------------------------------------------------------------------------------------