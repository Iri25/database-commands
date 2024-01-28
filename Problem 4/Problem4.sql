/* 
1. Proiectati si implementati un model de date cu atribute temporale pentru
o problema la alegere. Problema trebuie sa contina:
- cel putin 2 entitati cu atribut transaction time
- cel putin 1 entitate cu atribut valid time
*/

-- Sistem medical: Pacienti, Medici, Consulatii

CREATE TABLE Pacienti (
    ID_Pacient INT PRIMARY KEY,
    Nume VARCHAR(255),
    Prenume VARCHAR(255),
    Data_Nasterii DATE,
    Data_Inregistrarii TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Medici (
    ID_Medic INT PRIMARY KEY,
    Nume VARCHAR(255),
    Prenume VARCHAR(255),
    Specializare VARCHAR(255),
    Data_Actualizarii TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Consultatii (
    ID_Consultatie INT PRIMARY KEY,
    ID_Pacient INT  REFERENCES Pacienti(ID_Pacient),
    ID_Medic INT REFERENCES Medici(ID_Medic),
    Data_Inceput_Consultatie TIMESTAMP,
    Data_Sfarsit_Consultatie TIMESTAMP,
    Diagnostic VARCHAR(255),
    Tratament VARCHAR(255),
    PERIOD FOR Perioada_Consultatie (Data_Inceput_Consultatie, Data_Sfarsit_Consultatie)
);

/*
Creati scripturi:
- de populare cu date (INSERT) a cel putin 100 de inregistrari pentru entitatile
de mai sus, datele calendaristice sa nu fie mai vechi de 15 septembrie 2023
*/

-- Populare tabela Pacienti cu 100 de  nregistrari fictive
DECLARE
  num_rows NUMBER := 100;
BEGIN
  FOR i IN 1..num_rows LOOP
    INSERT INTO Pacienti (ID_Pacient, Nume, Prenume, Data_Nasterii, Data_Inregistrarii)
    VALUES (
      i, -- ID_Pacient
      'Nume' || i, -- Nume (valori fictive)
      'Prenume' || i, -- Prenume (valori fictive)
      TO_DATE('2000-01-01', 'YYYY-MM-DD') + ROUND(DBMS_RANDOM.VALUE(0, 8765), 0), -- Data_Nasterii (aleator  ntre 2000-01-01 si 2023-09-15)
      TO_TIMESTAMP('2023-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS') + DBMS_RANDOM.VALUE(0, 258) -- Data_Inregistrarii ((aleator  ntre 2023-01-01 si 2023-09-15)
    );
  END LOOP;
  COMMIT;
END;

-- Populare tabela Medici cu 100 de  nregistrari fictive
DECLARE
  num_rows NUMBER := 100;
BEGIN
  FOR i IN 1..num_rows LOOP
    INSERT INTO Medici (ID_Medic, Nume, Prenume, Specializare, Data_Actualizarii)
    VALUES (
      i, -- ID_Medic
      'NumeMedic' || i, -- Nume (valori fictive)
      'PrenumeMedic' || i, -- Prenume (valori fictive)
      'SpecializareMedic' || i, -- Specializare (valori fictive),
      TO_TIMESTAMP('2023-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS') + DBMS_RANDOM.VALUE(0, 258) -- Data_Actualizarii ((aleator  ntre 2023-01-01 si 2023-09-15)
    );
  END LOOP;
  COMMIT;
END;

-- Populare tabela Consultatii cu 100 de  nregistrari fictive
DECLARE
  num_rows NUMBER := 100;
BEGIN
  FOR i IN 1..num_rows LOOP
    DECLARE
      v_Data_Inceput TIMESTAMP;
      v_Data_Sfarsit TIMESTAMP;
    BEGIN
      -- Generare aleatoare a datelor de  nceput si sfarsit ale consultatiei
      v_Data_Inceput := TO_TIMESTAMP('2023-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS') + DBMS_RANDOM.VALUE(0, 258);
      v_Data_Sfarsit := v_Data_Inceput + DBMS_RANDOM.VALUE(0, 10);
      -- Verificare daca Data_Sfarsit_Consultatie este mai mare dec t Data_Inceput_Consultatie
      WHILE v_Data_Sfarsit <= v_Data_Inceput LOOP
        v_Data_Sfarsit := v_Data_Inceput + DBMS_RANDOM.VALUE(0, 10);
      END LOOP;
      
      -- Inserare a  nregistrarii  n tabel
      INSERT INTO Consultatii (ID_Consultatie, ID_Pacient, ID_Medic, Data_Inceput_Consultatie, Data_Sfarsit_Consultatie, Diagnostic, Tratament)
      VALUES (
        i, -- ID_Consultatie
        ROUND(DBMS_RANDOM.VALUE(1, 100)), -- ID_Pacient (aleator  ntre 1 ?i 100)
        ROUND(DBMS_RANDOM.VALUE(1, 100)), -- ID_Medic (aleator  ntre 1 ?i 100)
        v_Data_Inceput, -- Data_Inceput_Consultatie
        v_Data_Sfarsit, -- Data_Sfarsit_Consultatie
        'Diagnostic' || i, -- Diagnostic (valori fictive)
        'Tratament' || i -- Tratament (valori fictive)
      );
    END;
  END LOOP;
  COMMIT;
END;

/*- de modificare a datelor (UPDATE) de minim 5, maxim 10 ori pentru cel putin 5 inregistrari din tabelele
de baza de mai sus
*/


-- Modificare date din tabela Pacienti
BEGIN
    UPDATE Pacienti SET Nume = 'Popa', Prenume = 'Aurelia' WHERE ID_Pacient = 1;
    UPDATE Pacienti SET Nume = 'Iacob', Prenume = 'Mariana', Data_Nasterii = '19-DEC-10' WHERE ID_Pacient = 2;
    UPDATE Pacienti SET Nume = 'Viaconu', Prenume = 'Iosif', Data_Inregistrarii = '28-JUL-23 11.42.00 PM' WHERE ID_Pacient = 3;
    COMMIT;
END;

-- Modificare date din tabela Medici
BEGIN
    UPDATE Medici SET Nume = 'Tianu', Prenume = 'Horia' WHERE ID_Medic = 1;
    UPDATE Medici SET Nume = 'Olteanu', Prenume = 'Ana', Specializare = 'Cardiolog' WHERE ID_Medic = 2;
    UPDATE Medici SET Nume = 'Argesan', Prenume = 'Paul-Ioan', Specializare = 'Gastrolog' WHERE ID_Medic = 3;
    COMMIT;
END;

-- Modificare date din tabela Consultatii
BEGIN
    UPDATE Consultatii SET Diagnostic = 'Pneumonie virala', Tratament = 'Antibiotice v2' WHERE ID_Consultatie = 1;
    UPDATE Consultatii SET Diagnostic = 'Hipertensiune', Tratament = 'Cardione' WHERE ID_Consultatie = 2;
    UPDATE Consultatii SET Diagnostic = 'Steatoza acuta', Tratament = 'Silimarina' WHERE ID_Consultatie = 3;
    COMMIT;
END;

/*
- de stergere (DELETE) a cel putin 3 inregistrari din tabelele de baza de mai sus
*/

-- stergere date din tabela Consultatii
BEGIN
    DELETE FROM Consultatii WHERE Diagnostic LIKE 'Diagnostic32' AND Tratament LIKE 'Tratament32';
    COMMIT;
END;

-- stergere date din tabela Pacienti
BEGIN
    DELETE FROM Pacienti WHERE ID_Pacient IN (6, 17, 59);
    COMMIT;
END;


-- stergere date din tabela Medici
BEGIN
    DELETE FROM Medici WHERE Specializare LIKE 'Specializare5' AND ID_Medic = 5;
    COMMIT;
END;

/*
3. implementati urmatoarele operatii(Query SELECT):
- din entitatea cu atribut valid time, sa se returneze intervalul in care randul 
(inregistrarea) actualizat cel mai recent a avut valoarea maxima
*/

-- 'LAG' ofera acces la mai mult de un rand dintr-un tabel in acelasi timp, fara un auto join (randurile anterioare)
-- 'LEAD'  ofera acces la mai mult de un rand dintr-un tabel in acelasi timp, fara un auto join (randurile ulterioare)
WITH ConsultatiiOrdinate AS (
  SELECT
    C.*,
    LAG(C.Data_Sfarsit_Consultatie) OVER (PARTITION BY C.ID_Pacient ORDER BY C.Data_Sfarsit_Consultatie) AS Prev_End_Date,
    LEAD(C.Data_Sfarsit_Consultatie) OVER (PARTITION BY C.ID_Pacient ORDER BY C.Data_Sfarsit_Consultatie) AS Next_End_Date
  FROM Consultatii C
)
SELECT ID_Consultatie, ID_Pacient, Data_Inceput_Consultatie, Data_Sfarsit_Consultatie, Diagnostic, Tratament
FROM ConsultatiiOrdinate
WHERE Data_Sfarsit_Consultatie = (SELECT MAX(Data_Sfarsit_Consultatie) FROM ConsultatiiOrdinate)
   OR (Prev_End_Date IS NULL AND Next_End_Date IS NULL);

/*
-dintr-o entitate cu atribut transaction time, sa se returneze numarul de randuri ce au avut operatii
asupra lor (INSERT/DELETE/UPDATE) din fiecare saptamana, din ultimele 4 saptamani
*/

-- 'IW' numara saptam nile  n functie de prima zi lucratoare a anului
/*
SELECT TO_CHAR(Data_Inregistrarii, 'IW') AS Saptamana, COUNT(*) AS Nr_Operatii
FROM Pacienti
WHERE Data_Inregistrarii BETWEEN SYSTIMESTAMP - INTERVAL '60' DAY AND SYSTIMESTAMP
GROUP BY TO_CHAR(Data_Inregistrarii, 'IW');
*/

-- 'WW' numara saptam nile  ntr-un an  ncep nd cu prima zi a anului
SELECT TO_CHAR (TRUNC(Data_Inregistrarii, 'WW') + 1, 'YYYY-MM-DD') AS Start_Saptamana,
       TO_CHAR (TRUNC(Data_Inregistrarii, 'WW') + 7, 'YYYY-MM-DD') AS End_Saptamana,
       COUNT(*) AS Numar_Operatii
FROM Pacienti
WHERE Data_Inregistrarii >= TRUNC(SYSDATE) - 90  -- Ultimele 4 saptam ni
GROUP BY TO_CHAR(TRUNC(Data_Inregistrarii, 'WW') + 1, 'YYYY-MM-DD'), TO_CHAR(TRUNC(Data_Inregistrarii, 'WW') + 7, 'YYYY-MM-DD')
ORDER BY Start_Saptamana;

/*
- cel putin 3 operatii (diferite) pentru date temporale care sa aiba rezultat numeric
*/

-- Numarul de pacienii  nregistrati  n ultimele 3 luni
SELECT COUNT(*) AS Nr_Pacienti
FROM Pacienti
WHERE Data_Inregistrarii BETWEEN SYSTIMESTAMP - INTERVAL '90' DAY AND SYSTIMESTAMP;

-- Numarul de zile de la ultima actualizare pentru fiecare medic
SELECT ID_Medic, 
    (EXTRACT(DAY FROM SYSTIMESTAMP - Data_Actualizarii)) AS Zile_Diferenta
FROM Medici;

-- Calcularea duratei consultatiei pentru fiecare  nregistrare  n minute
SELECT ID_Consultatie, 
    (EXTRACT(MINUTE FROM Data_Sfarsit_Consultatie - Data_Inceput_Consultatie)) AS Durata_Consultatie
FROM Consultatii;

/*
- cel putin 3 operatii (diferite) pentru date temporale care sa aiba rezultat temporal
*/

-- Data celei mai vechi inregistrari a unui pacient
SELECT MIN(Data_Inregistrarii) AS Data_Prima_Inregistrare
FROM Pacienti;

-- Data ultimei actualizari a unui medic
SELECT MAX(Data_Actualizarii) AS Data_Ultima_Actualizare
FROM Medici;

-- Calcularea intervalului de timp  n minute a perioadei consultatiei pentru fiecare inregistrare
SELECT ID_Consultatie,
    NUMTODSINTERVAL(EXTRACT(MINUTE FROM (Data_Sfarsit_Consultatie - Data_Inceput_Consultatie)), 'MINUTE') AS Durata_Consultatie
FROM Consultatii;

/*
- cel putin 2 operatii (diferite) pentru date temporale care sa aiba rezultat boolean
*/

-- Verificare daca exista pacienti nascuti inainte de 2000
SELECT CASE WHEN COUNT(*) > 0 THEN 'TRUE' ELSE 'FALSE' END AS PACIENTI_NASCUTI_INAINTE_2000
FROM Pacienti
WHERE TO_DATE(Data_Nasterii, 'DD-MON-RR') < TO_DATE('01-JAN-00', 'DD-MON-RR');

-- Verificare daca exista medici actualizaai  n ultimele 3 luni
SELECT CASE WHEN COUNT(*) > 0 THEN 'TRUE' ELSE 'FALSE' END AS Medici_Actualizati
FROM Medici
WHERE Data_Actualizarii BETWEEN SYSTIMESTAMP - INTERVAL '90' DAY AND SYSTIMESTAMP;

-- Verificare daca exista consultatii in perioada iulie-septembrie
SELECT  CASE WHEN COUNT(*) > 0 THEN 'TRUE' ELSE 'FALSE' END AS Consultatii_In_Perioada_Iulie_Si_Septembrie
FROM Consultatii
WHERE Data_Inceput_Consultatie BETWEEN TO_TIMESTAMP('01-JUL-23', 'DD-MON-RR HH24:MI:SS') AND TO_TIMESTAMP('01-SEP-23', 'DD-MON-RR HH24:MI:SS')

