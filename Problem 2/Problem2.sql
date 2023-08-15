----------------------------------------------------------------------------------------------------------------
/*1. Folosind tabelul "studenti" creat in primul laborator, se cer view-uri pentru urmatoarele probleme (se 
rezolva usor cu functiile analitice):
a. Pentru fiecare student se cere: nume, prenume, grupa, media, media sectiei din care face parte, 
distanta fata de medie (varianta), pozitia studentului in anul din care face parte (in ordonarea 
studentilor descrescator dupa medie).
b. Studentii care au primele 3 medii cele mai mari din fiecare grupa.
*/
----------------------------------------------------------------------------------------------------------------

-- a.
CREATE OR REPLACE VIEW LISTA_STUDENTI_MEDIE AS 
    SELECT NUME, PRENUME, GRUPA, MEDIA,
        AVG(MEDIA) OVER (PARTITION BY DENUMIRE_SECTIA) AS MEDIA_SECTIA,
        ABS(MEDIA - AVG(MEDIA) OVER (PARTITION BY DENUMIRE_SECTIA)) AS DISTANTA_MEDIE,
        row_number() OVER (PARTITION BY AN_STUDIU ORDER BY MEDIA DESC) AS POZITIA_STUDENT
    FROM STUDENTI
    ORDER BY MEDIA DESC;

-- b.
CREATE OR REPLACE VIEW LISTA_STUDENTI_BURSE AS 
    SELECT *
    FROM 
        (SELECT NUME, PRENUME, GRUPA, MEDIA, 
                RANK() OVER (PARTITION BY GRUPA ORDER BY MEDIA DESC) POZITIA 
        FROM STUDENTI)
    WHERE POZITIA <= 3
    ORDER BY GRUPA, POZITIA;

----------------------------------------------------------------------------------------------------------------
/*2. Se poate folosi tabela cursz din schema master.
Daca folositi instante proprii, se considera in schema curenta tabela:
CREATE TABLE cursz (
 zi number(2),
 luna number(2),
 an number(4),
 valoare number(6,4),
 moneda char(3)
);
(tabelul contine ratele de schimb zilnice, pentru o perioada de timp, pentru mai multe monede,
un script de insert va fi disponibil pentru utilizare)
(Functia MATCH_RECOGNIZE este disponibila din Oracle 12c, dar nu versiunea Express Edition)
Pentru studentii care nu au o versiune ce suporta MATCH_RECOGNIZE, se cere sa se arate interogarea 
cu comentariile corespunzatoare pentru a se putea intelege metoda de rezolvare.
a. Se cer intervalele de timp in care rata de schimb (pentru o anumita moneda) a scazut cel putin 10 zile 
consecutive
(se cere numarul de zile de scadere si diferenta de valoare de la inceputul si sfarsitul perioadei).
b. Se cere inca o problema care determina un anumit model (ex: sablon V, W, M, etc) folosind datele din 
acest tabel.*/
 ----------------------------------------------------------------------------------------------------------------

-- a. 
CREATE TABLE CURSZ AS SELECT * FROM master.CURSZ; 
 
WITH CURSEZ AS (SELECT ZI, LUNA, AN, VALOARE FROM CURSZ WHERE MONEDA = 'eur')
SELECT *
FROM CURSEZ MATCH_RECOGNIZE (
     ORDER BY AN, LUNA, ZI
     MEASURES strt.AN AS START_AN, strt.LUNA AS START_LUNA, strt.ZI AS START_ZI,
              strt.VALOARE AS MONEDA_INC, LAST(scade.VALOARE) AS MONEDA_SF,
              count(*) AS NR_ZILE,
              strt.VALOARE - LAST(scade.VALOARE) AS DIFERNTA
     ONE ROW PER MATCH
     PATTERN (strt scade{10,})
     DEFINE
        scade AS scade.VALOARE < PREV(scade.VALOARE)
     ) res
ORDER BY res.START_AN, res.START_LUNA, res.START_ZI;
 
-- b.
-- Sa se determine sabloanele de tip V, unde fiecare perioada (de scadere sau de crestere) are cel putin 1 luna
SELECT *
FROM CURSZ MATCH_RECOGNIZE (
     PARTITION BY MONEDA
     ORDER BY AN, LUNA
     MEASURES strt.AN AS START_AN, strt.LUNA AS START_LUNA,
              LAST(scade.AN) AS AN_INC,
              LAST(scade.LUNA) AS LUNA_INC,
              count(scade.*)+1 AS NR_ZILE_SCADE,
              LAST(creste.AN) AS AN_SF,
              LAST(creste.LUNA) AS LUNA_SF,
              count(creste.*) AS NR_ZILE_CRESTE,
              count(*) AS NR_ZILE
     ONE ROW PER MATCH
     AFTER MATCH SKIP TO LAST creste
     PATTERN (strt scade{1,} creste{1,})
     DEFINE
        scade AS scade.VALOARE < PREV(scade.VALOARE),
        creste AS creste.VALOARE > PREV(creste.VALOARE)
     ) res
ORDER BY MONEDA, res.START_AN, res.START_LUNA;

 ----------------------------------------------------------------------------------------------------------------
/*3. Sa se creeze un pachet utilizator care sa contina cel putin 3 functii/proceduri care sa poata:
a. sa afiseze date din view-urile de la punctul 1, datele fiind filtrate dupa cel putin 2 parametri de intrare
b. sa contina o functie de jurnalizare/log (inserarea de inregistrari intr-o tabela numita jurnal/log, la 
fiecare apel de porcedura/functie de la punctul a ,la inceputul si/sau sfarsitul ei, pentru a calcula durata, 
fie la terminare cu succes, fie cu eroare; tabela trebuie sa contine detalii despre functia rulata, durata, 
daca rularea a fost cu succes sau eroare, si eroarea)*/
----------------------------------------------------------------------------------------------------------------

-- a si b
CREATE OR REPLACE PACKAGE PACHET_UTILIZATOR AS
  -- functie care determina viiew-ul de la 1.a)
  FUNCTION LISTA_STUDENTI_MEDIE(grupa NUMBER, media NUMBER) RETURN NUMBER;
  
  -- functie care determina viiew-ul de la 1.b)
  FUNCTION LISTA_STUDENTI_BURSE(media1 NUMBER, media2 NUMBER) RETURN NUMBER;

  -- functie de jurnalizare
  -- PROCEDURE JURNALIZARE(utilizator IN VARCHAR2, functie IN VARCHAR2, erori IN VARCHAR2);
END;

CREATE OR REPLACE PACKAGE BODY PACHET_UTILIZATOR AS
  FUNCTION LISTA_STUDENTI_MEDIE(grupa NUMBER, media NUMBER) RETURN NUMBER IS
    CURSOR temp IS
        SELECT count(*) nr 
        FROM
            (SELECT  NUME, PRENUME, GRUPA, MEDIA,
                    AVG(MEDIA) OVER (PARTITION BY DENUMIRE_SECTIA) AS MEDIA_SECTIA,
                    ABS(MEDIA - AVG(MEDIA) OVER (PARTITION BY DENUMIRE_SECTIA)) AS DISTANTA_MEDIE,
                    row_number() OVER (PARTITION BY AN_STUDIU ORDER BY MEDIA DESC) AS POZITIA_STUDENT
            FROM STUDENTI
            WHERE GRUPA = grupa AND MEDIA >= media
            ORDER BY MEDIA DESC);
    v temp%rowtype;
    BEGIN
        FOR v IN temp LOOP
            RETURN v.nr;
        END LOOP;
    END;

  FUNCTION LISTA_STUDENTI_BURSE(media1 NUMBER, media2 NUMBER) RETURN NUMBER IS 
    CURSOR temp IS
        SELECT count(*) nr
        FROM 
            (SELECT NUME, PRENUME, GRUPA, MEDIA, 
            RANK() OVER (PARTITION BY GRUPA ORDER BY MEDIA DESC) POZITIA 
            FROM STUDENTI)
        WHERE POZITIA <= 3 AND MEDIA >= media1 AND MEDIA <= media2
        ORDER BY GRUPA, POZITIA;
    v temp%rowtype;
  BEGIN
    FOR v IN temp LOOP
        RETURN v.nr;
    END LOOP;
  END;
--  
--  PROCEDURE JURNALIZARE
--    (utilizator IN VARCHAR2, functie IN VARCHAR2, erori IN VARCHAR2) AS
--    PRAGMA AUTONOMOUS_TRANSACTION;
--  BEGIN
--    INSERT INTO LOG (utilizator, functie, data, erori) 
--    VALUES (utilizator, functie, SYSDATE, mesaj);
--    COMMIT;
--  END;
END;

CREATE TABLE LOG
(
    UTILIZATOR VARCHAR2(30) NOT NULL,
    NUME_FUNCTIE VARCHAR2(30) NOT NULL, 
    DATA_EXECUTIE DATE NOT NULL,
    DURATA_EXECUTIE NUMBER(5, 3) NOT NULL, 
    ERORI_EXECUTIE VARCHAR2(10)
);


BEGIN

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    JURNALIZARE(user, functie, SQLERRM);
    ROLLBACK;
END;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION CREEARE_TABEL(nume_tabel IN VARCHAR2) RETURN BOOLEAN 
  AS
    c INTEGER;
    n INTEGER;
  BEGIN
    -- deschide un cursor
    c := dbms_sql.open_cursor;
    -- analizeaza o instructiune SQL ce creeaza o tabela jurnal data ca argument
    dbms_sql.parse(c, nume_tabel, dbms_sql.native);
    -- executa aceasta instructiune
    n := dbms_sql.execute(c);
    -- inchide cursorul
    dbms_sql.close_cursor(c);
    RETURN TRUE;
  EXCEPTION
    -- daca apare eroare se inchide cursorul
    WHEN OTHERS THEN
      dbms_sql.close_cursor(c);
      RETURN FALSE;
  END;
  
SET serveroutput ON
DECLARE
    ok BOOLEAN;
    m CHAR(2);
BEGIN
    dbms_output.enable;
    ok := CREEARE_TABEL('CREATE TABLE JURNAL 
                            (
                                NUME_FUNCTIE VARCHAR2(30), 
                                DURATA_EXECUTIE NUMBER(5, 3), 
                                TERMINARE VARCHAR2(10)
                            )
                       ');
    if ok then 
        m := 'Da'; 
    else 
        m := 'Nu'; 
    end if;
    dbms_output.put_line(m);
END;