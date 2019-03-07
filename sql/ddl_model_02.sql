--- CREATE, ALTER, DROP -------------------------------- 1. Table ANIMALSCREATE TABLE ANIMALS (    ID                      NUMBER,    NAME                    VARCHAR2(64),        SPECIES                 VARCHAR2(64),       GENDER                  CHAR(1)			NOT NULL,    FATHER_ID               NUMBER,    MOTHER_ID               NUMBER,    BIRTH_DATE              DATE,     ARRIVAL_DATE            DATE,      RESPONSIBLE_PERSON_ID   NUMBER);-- 2. Table STAFFCREATE TABLE STAFF (    ID                  NUMBER,    NAME                VARCHAR2(64)    NOT NULL,        SURNAME             VARCHAR2(64)    NOT NULL,     ADRESS_STREET       VARCHAR2(64),     ADDRESS_NO          VARCHAR2(10),     ADDRESS_CITY        VARCHAR2(64),     ADDRESS_POSTCODE    VARCHAR2(10),     GENDER              CHAR(1)         NOT NULL,    SUPERVISOR_ID       NUMBER,    SPECIALIZATION      VARCHAR2(64),    DIVISION_ID         NUMBER);-- 3. Table DIVISIONSCREATE TABLE DIVISIONS (    ID		NUMBER 			NOT NULL,    NAME    VARCHAR2(64));-- 1.1 PK for ANIMALSALTER TABLE ANIMALSADD CONSTRAINT ANIMALS_PK PRIMARY KEY (ID);-- 2.1 PK for STAFFALTER TABLE STAFFADD CONSTRAINT STAFF_PK PRIMARY KEY (ID);-- 3.1 PK for DIVISIONSALTER TABLE DIVISIONSADD CONSTRAINT DIVISION_PK PRIMARY KEY (ID);-- 1.2.1 FK for ANIMALS    ALTER TABLE ANIMALSADD CONSTRAINT FATHER_ID_FK   FOREIGN KEY (FATHER_ID)   REFERENCES ANIMALS (ID);-- 1.2.2 FK for ANIMALSALTER TABLE ANIMALSADD CONSTRAINT MOTHER_ID_FK   FOREIGN KEY (MOTHER_ID)   REFERENCES ANIMALS (ID);-- 1.2.3 FK for ANIMALSALTER TABLE ANIMALSADD CONSTRAINT RESPONSIBLE_PERSON_ID_FK   FOREIGN KEY (RESPONSIBLE_PERSON_ID)   REFERENCES STAFF (ID);-- 1.3.1 FK for STAFFALTER TABLE STAFFADD CONSTRAINT SUPERVISOR_ID_FK   FOREIGN KEY (SUPERVISOR_ID)   REFERENCES STAFF (ID);-- 1.3.2 FK for ANIMALSALTER TABLE STAFFADD CONSTRAINT DIVISION_ID_FK   FOREIGN KEY (DIVISION_ID)   REFERENCES DIVISION (ID);      /* PART 1 *//*	New:			Table SPONSORS				New realtionship*/-- Table SPONSORSCREATE TABLE SPONSORS (    ID         NUMBER,    NAME       VARCHAR2(64)   );-- PK for SPONSORSALTER TABLE SPONSORSADD CONSTRAINT SPONSORS_PK PRIMARY KEY (ID);-- ADD COLUMN TO ANIMALSALTER TABLE   ANIMALSADD   (      SPONSORS_ID      NUMBER   );   -- RENAME COLUMNALTER TABLE ANIMALS RENAME COLUMN SPONSORS_ID TO SPONSOR_ID;   -- FK for ANIMALSALTER TABLE ANIMALSADD CONSTRAINT SPONSOR_ID_FK   FOREIGN KEY (SPONSOR_ID)   REFERENCES SPONSORS(ID);   -- ADD COLUMN TO ANIMALSALTER TABLE   ANIMALSADD   (      FUNDING             NUMBER   ); --- CREATE SEQUENCE PECIESCREATE SEQUENCE SEQ_SPECIESMINVALUE 0MAXVALUE 1000START WITH 1INCREMENT BY 1NOCACHE;   --- CREATE SEQUENCE SPONSORS CREATE SEQUENCE SEQ_SPONSORSMINVALUE 0MAXVALUE 1000START WITH 1INCREMENT BY 1NOCACHE;   