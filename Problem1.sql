/*1. Cu instructiuni CREATE TABLE se cere crearea a cel putin doua tabele si definirea de restrictii de integritate pentru aceste tabele: 
-  restrictii de cheie: unica, primara 
-  restrictii pentru valorile coloanelor  
-  restrictii pentru valorile inregistrarilor  
-  restrictii de cheie externa 
La tabele si coloane sa se asocieze comentarii (descrieri).
La alegerea problemei se va avea in vedere faptul ca aceste tabele vor trebui modificate prin adaugarea unor coloane cu valori de un tip definit de utilizator.
Pentru tabelele definite se cere crearea de indexuri. (1p)*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PROFESORI -- Creare tabela PROFESORI 
(
    COD_PROFESOR NUMBER(4, 0), 
    CONSTRAINT PROFESORI_COD_PROFESOR_PK PRIMARY KEY (COD_PROFESOR), -- restrictie de cheie primara
    NUME VARCHAR2(30) CONSTRAINT PROFESORI_NUME_NN NOT NULL, -- restrictie pentru valoarea coloanei sa nu fie null
    PRENUME VARCHAR2(30) CONSTRAINT PROFESORI_PRENUME_NN NOT NULL, -- restrictie pentru valoarea coloanei sa nu fie null
    DEPARTAMENT VARCHAR2(30) CONSTRAINT PROFESORI_DEPARTAMENT_NN NOT NULL, -- restrictie pentru valoarea coloanei sa nu fie null
    EMAIL VARCHAR2(50) CONSTRAINT PROFESORI_EMAIL_NN NOT NULL, -- restrictie pentru valoarea coloanei sa nu fie null
    CONSTRAINT PROFESORI_EMAIL_UK UNIQUE (EMAIL) -- restrictie pentru valoarea coloanei sa fie unica
);


CREATE TABLE DISCIPLINE -- Creare tabela DISCIPLINE
(
    COD_DISCIPLINA NUMBER(3, 0),
    CONSTRAINT DISCIPLINE_COD_DISCIPLINA_PK PRIMARY KEY (COD_DISCIPLINA), -- restrictie de cheie primara
    DENUMIRE VARCHAR2(50) CONSTRAINT DISCIPLINE_DENUMIRE_NN NOT NULL, -- restrictie pentru valoarea coloanei sa nu fie null
    COD_PROFESOR NUMBER(4, 0),
    CONSTRAINT DISCIPLINE_COD_PROFESOR_FK FOREIGN KEY (COD_PROFESOR) REFERENCES PROFESORI(COD_PROFESOR) -- restrictie de cheie externa
);

CREATE TABLE EXAMENE -- Creare tabela EXAMENE
(
    CNP CHAR(13), 
    COD_DISCIPLINA NUMBER(3,0),
    CONSTRAINT EXAMENE_COD_DISCIPLINA_FK FOREIGN KEY (COD_DISCIPLINA) REFERENCES DISCIPLINE (COD_DISCIPLINA), -- restrictie de cheie externa
    CONSTRAINT CNP_COD_DISCIPLINA_PK PRIMARY KEY (CNP, COD_DISCIPLINA), -- restrictie de cheie primara compusa
    NOTA NUMBER (5, 2) CONSTRAINT EXAMENE_NOTA_NN NOT NULL, -- restrictie pentru valoarea coloanei sa nu fie null
    CREDITE NUMBER(1, 0) CONSTRAINT EXAMENE_CREDITE_NN NOT NULL, -- restrictie pentru valoarea coloanei sa nu fie null
    CONSTRAINT EXAMENE_CREDITE_CK CHECK (CREDITE > 0)  -- restrictie pentru valoarea inregistrarii sa fie mai mare ca zero
);


CREATE INDEX PROFESORI_DEPARTAMENT_INDEX ON PROFESORI(DEPARTAMENT); -- Creare index pentru EMAIL la PROFESORI

CREATE INDEX DISCIPLINE_DENUMIRE_COD_PROFESOR_INDEX ON DISCIPLINE(DENUMIRE); -- Creare index pentru DENUMIRE, COD_PROFESOR la DISCIPLINE

CREATE INDEX EXAMENE_CNP_COD_DISCIPLINA_NOTA_INDEX ON EXAMENE(CNP, COD_DISCIPLINA, NOTA); -- Creare index pentru CNP, COD_DISCIPLINA, NOTA la EXAMENE 

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*2. Creati un tabel cu structura si datele tabelului "studenti" din schema MASTER. Evidentiati pasii prin care ati rezolvat cerinta (0.5p)*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE STUDENTI AS SELECT * FROM master.STUDENTI; 
-- CREATE TABLE AS SELECT * presupune crearea unui tabel prin copierea coloanelor selectate dintr-un alt tabel FROM master.STUDENTI

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*3. Sa se foloseasca instructiuni pentru: adaugarea, modificarea, 
stergerea de date in tabelele definite. Se va observa modul in care se folosesc 
restrictiile definite, prin cereri de executare a unor instructiuni care nu le respecta. (1p)*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (1002, 'Pop', 'Maria', 'Matematica', 'pop.maria@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (1004, 'Popa', 'Teodor', 'Matematica', 'popa.teodor@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (1009, 'Ardelean', 'Lucian', 'Matematica', 'ardelean.lucian@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (1102, 'Moldovan', 'Narcisa', 'Matematica', 'moldovan.narcisa');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (1118, 'Morosan', 'Valentina', 'Matematica', 'morosan.valentina@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (2002, 'Ionescu', 'Aurora', 'Informatica', 'ionescu.aurora@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (2008, 'Popescu', 'Marcel', 'Informatica', 'popescu.marcel@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (2119, 'Vladescu', 'Ana', 'Informatica', 'vladescu.ana@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (2290, 'Aioanei', 'Dimitrie', 'Informatica', 'aioanei.dimitrie@ubbcluj.ro');
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (2497, 'Matei', 'Stefan', 'Informatica', 'matei.stefan@ubbcluj.ro');

INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (2498, 'Matei', 'Stefan-Andrei', 'Informatica', 'matei.stefan@ubbcluj.ro'); -- EMAIL nu este unic
INSERT INTO PROFESORI(COD_PROFESOR, NUME, PRENUME, DEPARTAMENT, EMAIL) VALUES (2497, 'Andrei', 'Eduard', 'Informatica', 'andrei.eduard@ubbcluj.ro'); -- duplicare cheie primara 


INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (123, 'Baze de date', 2002);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (126, 'Algoritmi si programare', 2008);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (129, 'Fundamentele programarii', 2008);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (135, 'Sisteme de operare', 2290);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (138, 'Algebra liniara', 1002);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (149, 'Analiza matematica', 1009);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (157, 'Ecuatii diferentiale', 1004);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (168, 'Sisteme dinamice', 2497);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (175, 'Probabilitati', 1002);
INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (182, 'Metode avansate de programare', 2119);

INSERT INTO DISCIPLINE(COD_DISCIPLINA, DENUMIRE, COD_PROFESOR) VALUES (182, 'Metode avansate de programare', 2160); -- duplicare cheie primara


INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (1880812124259, 126, 8, 5);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (1880714245083, 126, 7.89, 5);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (2850419204496, 157, 6, 6);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (2830410125817, 157, 7.50, 6);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (2861001314022, 138, 9, 6);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (2830929125778, 138, 8.90, 6);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (2830929125778, 129, 10, 5);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (2850419204496, 129, 8, 5);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (2850705060594, 135, 4, 6);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (1840504314021, 123, 10, 7);

INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (1880413190437, 135, 5, 0);
INSERT INTO EXAMENE(CNP, COD_DISCIPLINA, NOTA, CREDITE) VALUES (1840504314021, 180, 10, 6); -- cheia straina nu exista


UPDATE PROFESORI SET PRENUME = 'Teodora', EMAIL = 'popa.teodora@ubbcluj.ro' WHERE COD_PROFESOR = 1004;
UPDATE PROFESORI SET COD_PROFESOR = 22900 WHERE COD_PROFESOR = 2290; -- valoarea mai mare decat precizia specificata

UPDATE DISCIPLINE SET DENUMIRE = 'Probabilitati si statistica' WHERE COD_DISCIPLINA = 175;
UPDATE DISCIPLINE SET COD_PROFESOR = 2289 WHERE COD_DISCIPLINA = 182; -- cheia straina nu exista

UPDATE EXAMENE SET CNP = 1850510303963 WHERE CNP = 1880714245083;
UPDATE EXAMENE SET CREDITE = 10 WHERE COD_DISCIPLINA = 157; -- valoarea mai mare decat precizia specificata


DELETE FROM PROFESORI WHERE COD_PROFESOR = 1118;
DELETE FROM PROFESORI WHERE COD_PROFESOR = 2497; -- sunt date in "tabela copil"

DELETE FROM DISCIPLINE WHERE DENUMIRE = 'Probabilitati si statistica';
DELETE FROM DISCIPLINE WHERE COD_DISCIPLINA = 157; -- sunt date in "tabela copil"

DELETE FROM EXAMENE WHERE CNP = 1840504314021 AND COD_DISCIPLINA = 123;
DELETE FROM EXAMENE WHERE NOTA = 1 AND COD_DISCIPLINA = 129; -- nu se sterg date

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*4. Se vor folosi view-uri sistem pentru a obtine informatii cu privire la: tabelele definite, tabelele la care se are acces, restrictiile definite, indexurile construite, 
coloanele dintr-un anumit tabel (denumire, tip). (0.5p)*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM SYS.ALL_TABLES; 
SELECT * FROM SYS.USER_TABLES;
SELECT * FROM SYS.USER_TAB_PRIVS;
SELECT * FROM SYS.ALL_DEPENDENCIES;
SELECT * FROM SYS.USER_INDEXES; 
SELECT * FROM SYS.USER_TABLES WHERE TABLE_NAME = 'STUDENTI'; 

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*5. Folosind tabelul "studenti" creat mai sus, se cere o procedura care determina cel mult p% studenti din fiecare sectie ce se afla in mijlocul intervalului de note (50-p/2% <-> 50+p/2%)
(nume, prenume, sectia, media), in ordinea descrescatoare dupa medie si alfabetic, studenti care au media mai mare decat 5 (p este parametru pentru procedura).  (2.5p)
Exemplu: 
- daca pentru sectia 1 avem 10 studenti cu media peste 5 si p este 20%, atunci vor fi afisati 2 studenti, de pe pozitiile 5 si 6; 
- daca pentru sectia 1 avem 9 studenti cu media peste 5 si p este 20%, atunci va afisa 1 student, de pe pozitia 5;*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT QUERY1.NUME, QUERY1.PRENUME, QUERY1.DENUMIRE_SECTIA, QUERY1.MEDIA, QUERY1.POZITIE, QUERY2.TOTAL_SECTIE FROM
(SELECT S1.NUME, S1.PRENUME, S1.COD_SECTIA, S1.DENUMIRE_SECTIA, S1.MEDIA, COUNT(*) AS POZITIE
FROM STUDENTI S1
INNER JOIN STUDENTI S2 ON S1.COD_SECTIA = S2.COD_SECTIA AND S1.MEDIA >= S2.MEDIA AND S1.MEDIA >= 5
GROUP BY S1.COD_SECTIA, S1.DENUMIRE_SECTIA, S1.MEDIA, S1.NUME, S1.PRENUME
ORDER BY S1.MEDIA DESC) QUERY1 INNER JOIN 
(SELECT COUNT(*) AS TOTAL_SECTIE, COD_SECTIA
FROM STUDENTI
GROUP BY COD_SECTIA) QUERY2 ON QUERY1.COD_SECTIA = QUERY2.COD_SECTIA;

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*6. Se cere un view care determina lista procedurilor (nume schema, nume procedura) pe care le poate folosi utilizatorul curent. (0.5p)*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW LISTA_PROCEDURI AS 
    SELECT * 
    FROM SYS.USER_PROCEDURES;
   

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*7. Se cere o procedura care are ca parametri un nume de schema si un nume de procedura si determina textul sursa cu care s-a definit procedura, in aceeasi ordine a liniilor. (1p)*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*8. Se cere utilizarea intr-un mediu de programare(PHP, Java, C#) a componentelor cerute mai sus (executie procedura, afisare date furnizate de view, executie procedura). (2p)*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------

