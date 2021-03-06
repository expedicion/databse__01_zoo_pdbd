--- INSERT, UPDATE, DELETE ---
------------------------------




/* PART 3 */ 

/*
Data for DIVISIONS:
	MAMMALS
	BIRDS
	REPTILES
	ADMINISTRATION
	SECURITY
	CLEANING
(Id-s genrated in sequence.)

Data for STAFF:

Name 	Surname 	Street 	No. City 			Postcode 	Gender 	Boss 	Specialization 	Division
--------------------------------------------------------------------------------------------------------
Ala 	Abranowska 	aaaa 	1a 	Augustow 		00-000 		F 		null 	Mammals 		MAMMALS
Beata 	Brunowska 	bbbb 	1b 	Bialystok 		00-000 		F 		null 	Birds 			BIRDS
Cezary 	Cejrowski 	cccc 	1c 	Chelm 			00-000 		M 		null 	Reptiles 		REPTILES
Dominik	Dmowski 	dddd 	1d 	Dabrowa Gorn. 	00-000 		M 		null 	null 			ADMINISTRATION
Ewa 	Edek 		eeee 	1e 	Elblag 			00-000 		F 		null 	null 			ADMINISTRATION

(Id-s genrated in sequence.)


Data for ANIMALS:

Name 		Species 	Gender 	Mother 	Father 	Date of Birth 	Arrival Date 	ID from STAFF
--------------------------------------------------------------------------------------------------------
Bruno 		lion 		M 		null 	null 	1/1/2003 		1/1/2005 		from MAMMALS
Eleonora 	cobra 		M 		null 	null 	10/1/2003 		null 			from REPTILES
Amelia 		lion 		F 		null 	null 	null 			null 			from MAMMALS
Cecyl 		lion 		M 		null 	null 	5/5/2012 		5/5/2012 		from MAMMALS
Dominik 	turtle 		M 		null 	null 	null 			1/1/2010 		from REPTILES
			
(Id-s genrated in sequence.)


TO_DATE(date string, date format),

example:

TO_DATE('2010/01/03 8:00:0', 'yyyy/mm/dd hh24:mi:ss')
*/

-- SEQUENCE FOR ANIMAL
CREATE SEQUENCE animals_seq
 START WITH     1;

-- SEQUENCE FOR STAFF 
CREATE SEQUENCE staff_seq
 START WITH     1;
 
-- SEQUENCE FOR DIVISIONS 
CREATE SEQUENCE division_seq
 START WITH     1; 
 
-- DIVISION'S INSERT 1
INSERT INTO DIVISIONS
(
    ID,
    NAME
)
VALUES
(
    division_seq.NEXTVAL,
    'MAMMALS'
);

-- DIVISION'S INSERT 2
INSERT INTO DIVISIONS
(
    ID,
    NAME
)
VALUES
(
    division_seq.NEXTVAL,
    'BIRDS'
);

-- DIVISION'S INSERT 3
INSERT INTO DIVISIONS
(
    ID,
    NAME
)
VALUES
(
    division_seq.NEXTVAL,
    'REPTILES'
);

-- DIVISION'S INSERT 4
INSERT INTO DIVISIONS
(
    ID,
    NAME
)
VALUES
(
    division_seq.NEXTVAL,
    'ADMINISTRATION'
);

-- DIVISION'S INSERT 5
INSERT INTO DIVISIONS
(
    ID,
    NAME
)
VALUES
(
    division_seq.NEXTVAL,
    'SECURITY'
);

-- DIVISION'S INSERT 6
INSERT INTO DIVISIONS
(
    ID,
    NAME
)
VALUES
(
    division_seq.NEXTVAL,
    'CLEANING'
);


-- STAFF'S INSERT 1
INSERT INTO STAFF
( 
    ID,
    NAME, 
    SURNAME,            
    ADRESS_STREET,       
    ADDRESS_NO,         
    ADDRESS_CITY,  
    ADDRESS_POSTCODE,  
    GENDER,
    SUPERVISOR_ID,
    SPECIALIZATION,
    DIVISION_ID
)
VALUES
(
    staff_seq.NEXTVAL,
    'Ala',
    'Abramowska',
    'aaa',
    '1a',
    'Augostow',
    '00-000',
    'F',
    NULL,
    'Mammals',
    (SELECT ID FROM DIVISIONS WHERE NAME LIKE 'MAMMALS')
 );
 
-- STAFF'S INSERT 2
INSERT INTO STAFF
( 
    ID,                  
    NAME, 
    SURNAME,            
    ADRESS_STREET,       
    ADDRESS_NO,         
    ADDRESS_CITY,  
    ADDRESS_POSTCODE,  
    GENDER,
    SUPERVISOR_ID,
    SPECIALIZATION,
    DIVISION_ID
)
VALUES
(
    staff_seq.NEXTVAL,
    'Beata',
    'Brunowska',
    'bbb',
    '1b',
    'Bialystok',
    '00-000',
    'F',
    NULL,
    'Birds',
    (SELECT ID FROM DIVISIONS WHERE NAME LIKE 'BIRDS')
 );
 
-- STAFF'S INSERT 3
INSERT INTO STAFF
( 
    ID,                  
    NAME, 
    SURNAME,            
    ADRESS_STREET,       
    ADDRESS_NO,         
    ADDRESS_CITY,  
    ADDRESS_POSTCODE,  
    GENDER,
    SUPERVISOR_ID,
    SPECIALIZATION,
    DIVISION_ID
)
VALUES
(
    staff_seq.NEXTVAL,
    'Cezary',
    'Cejrowski',
    'ccc',
    '1c',
    'Chelm',
    '00-000',
    'M',
    NULL,
    'Reptiles',
    (SELECT ID FROM DIVISIONS WHERE NAME LIKE 'REPTILES')
 );

-- STAFF'S INSERT 4 
INSERT INTO STAFF
( 
    ID,                  
    NAME, 
    SURNAME,            
    ADRESS_STREET,       
    ADDRESS_NO,         
    ADDRESS_CITY,  
    ADDRESS_POSTCODE,  
    GENDER,
    SUPERVISOR_ID,
    SPECIALIZATION,
    DIVISION_ID
)
VALUES
(
    staff_seq.NEXTVAL,
    'Dominik',
    'Dmowski',
    'ddd',
    '1d',
    'Dabrowa Gorn.',
    '00-000',
    'M',
    NULL,
    NULL,
    (SELECT ID FROM DIVISIONS WHERE NAME LIKE 'ADMINISTRATION')
 );
 
-- STAFF'S INSERT 5
INSERT INTO STAFF
( 
    ID,                  
    NAME, 
    SURNAME,            
    ADRESS_STREET,       
    ADDRESS_NO,         
    ADDRESS_CITY,  
    ADDRESS_POSTCODE,  
    GENDER,
    SUPERVISOR_ID,
    SPECIALIZATION,
    DIVISION_ID
)
VALUES
(
    staff_seq.NEXTVAL,
    'Ewa',
    'Edek',
    'eee',
    '1e',
    'Elblag',
    '00-000',
    'F',
    NULL,
    NULL,
    (SELECT ID FROM DIVISIONS WHERE NAME LIKE 'ADMIN%')
);
 
-- ANIMAL'S INSERT 1
INSERT INTO ANIMALS
(
    ID,                   
    NAME,                
    SPECIES,              
    GENDER,               
    FATHER_ID,            
    MOTHER_ID,            
    BIRTH_DATE,           
    ARRIVAL_DATE,         
    RESPONSIBLE_PERSON_ID
)
VALUES
(
    animals_seq.NEXTVAL,
    'Bruno',
    'lion',
    'M',
    NULL,
    NULL,
    TO_DATE('2003/01/01', 'yyyy/mm/dd'),
    TO_DATE('2003/01/01', 'yyyy/mm/dd'),
    (SELECT ID FROM STAFF WHERE SPECIALIZATION = 'Mammals')   
);

-- ANIMAL'S INSERT 2
INSERT INTO ANIMALS
(
    ID,                   
    NAME,                
    SPECIES,              
    GENDER,               
    FATHER_ID,            
    MOTHER_ID,            
    BIRTH_DATE,           
    ARRIVAL_DATE,         
    RESPONSIBLE_PERSON_ID
)
VALUES
(
    animals_seq.NEXTVAL,
    'Eleonora',
    'cobra',
    'M',
    NULL,
    NULL,
    TO_DATE('2003/01/01', 'yyyy/mm/dd'),
    NULL,
    (SELECT ID FROM STAFF WHERE SPECIALIZATION = 'Reptiles')
);

-- ANIMAL'S INSERT 3
INSERT INTO ANIMALS
(
    ID,                   
    NAME,                
    SPECIES,              
    GENDER,               
    FATHER_ID,            
    MOTHER_ID,            
    BIRTH_DATE,           
    ARRIVAL_DATE,         
    RESPONSIBLE_PERSON_ID
)
VALUES
(
    animals_seq.NEXTVAL,
    'Amelia',
    'lion',
    'F',
    NULL,
    NULL,
    NULL,
    NULL,
    (SELECT ID FROM STAFF WHERE SPECIALIZATION = 'Mammals')   
);

-- ANIMAL'S INSERT 4
INSERT INTO ANIMALS
(
    ID,                   
    NAME,                
    SPECIES,              
    GENDER,               
    FATHER_ID,            
    MOTHER_ID,            
    BIRTH_DATE,           
    ARRIVAL_DATE,         
    RESPONSIBLE_PERSON_ID
)
VALUES
(
    animals_seq.NEXTVAL,
    'Cecyl',
    'lion',
    'M',
    NULL,
    NULL,
    TO_DATE('2012/05/05', 'yyyy/mm/dd'),
    TO_DATE('2012/05/05', 'yyyy/mm/dd'),
    (SELECT ID FROM STAFF WHERE SPECIALIZATION = 'Mammals')   
);

-- ANIMAL'S INSERT 5
INSERT INTO ANIMALS
(
    ID,                   
    NAME,                
    SPECIES,              
    GENDER,               
    FATHER_ID,            
    MOTHER_ID,            
    BIRTH_DATE,           
    ARRIVAL_DATE,         
    RESPONSIBLE_PERSON_ID
)
VALUES
(
    animals_seq.NEXTVAL,
    'Dominik',
    'turtle',
    'M',
    NULL,
    NULL,
    NULL,
    TO_DATE('2010/01/01', 'yyyy/mm/dd'),
    (SELECT ID FROM STAFF WHERE SPECIALIZATION = 'Reptiles')   
);