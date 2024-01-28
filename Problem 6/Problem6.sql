/*
Folosind tabelele si datele de la http://www.cs.ubbcluj.ro/~horea/CABD/strArb/ se cere, 
in Oracle sau PostgreSQL, la alegere:

1. Sa se creeze o singura tabela cu toate aceste date organizate sub forma de "adjacency list";
*/

--  fiecare element are un părinte (cu excepția rădăcinii)
CREATE TABLE adjacency_list AS
SELECT 
    S.cod, 
    P.denumire, 
    S.codp AS cod_parinte
FROM 
    structura S
JOIN 
    produse P ON S.cod = P.cod;
	
SELECT *
FROM adjacency_list;

/*
2. Afisarea denumirii, denumirea parintelui si nivelul in arbore pentru toate obiectele pana la nivelul 5;
(pt Postgresql se poate folosi recursive CTE)
*/

-- conditia cod_parinte IS NULL, identifica nodurile care sunt radacini in arbore
WITH RECURSIVE tree_hierarchy AS 
(
    SELECT cod, denumire, cod_parinte, 0 AS nivel
    FROM adjacency_list
    -- WHERE cod_parinte IS NULL

    UNION ALL

    SELECT A.cod, A.denumire, A.cod_parinte, T.nivel + 1
    FROM adjacency_list A
    INNER JOIN tree_hierarchy T ON A.cod_parinte = T.cod
)
SELECT cod, denumire, cod_parinte, (SELECT denumire FROM produse WHERE cod = cod_parinte) AS denumire_parinte, nivel
FROM tree_hierarchy
WHERE nivel <= 5;


/*
3. Cu ajutorul unei functii/proceduri, sa se transforme aceasta structura in format "path enumeration"
(tabela noua, se poate folosi codificare suplimentara la nevoie, de exemplu separator de cale; 
pt PostgreSQL se poate utiliza parcurgerea ierarhiei de la punctul 2 si functiile array_agg 
respectiv array_to_string pt a obtine path-uri);
*/

-- conditia cod_parinte IS NULL, identifica nodurile care sunt radacini in arbore
CREATE TABLE path_enumeration AS
WITH RECURSIVE path_cte AS 
(
    SELECT cod, denumire, cod_parinte, ARRAY[cod] AS cale
    FROM adjacency_list
    -- WHERE cod_parinte IS NULL

    UNION ALL

    SELECT A.cod, A.denumire, A.cod_parinte, P.cale || A.cod
    FROM adjacency_list A
    JOIN path_cte P ON A.cod_parinte = P.cod
)
SELECT cod, denumire, array_to_string(cale, '->') AS cale
FROM path_cte;

/*
4. Pentru modelul "path enumeration" sa se scrie o functie care elimina un nod dat ca si parametru 
din structura cu pastrarea structurii de arbore (nu forest)
*/

CREATE OR REPLACE FUNCTION delete_node(cod_nod integer)
RETURNS void AS $$
DECLARE
    cod_parinte_eliminare integer;
    cale_eliminare text;
BEGIN
    -- Găsirea codului părinte pentru nodul care trebuie eliminat
    SELECT cod_parinte 
	INTO cod_parinte_eliminare
	FROM adjacency_list
	WHERE cod = cod_nod;

    -- Verificare dacă nodul există
    IF cod_parinte_eliminare IS NULL THEN
        RAISE EXCEPTION 'Nodul cu codul % nu există sau este un nod rădăcină!', cod_nod;
    END IF;

    -- Reorganizarea descendenților nodului eliminat
    FOR cale_eliminare IN
        SELECT cale 
		FROM path_enumeration
        WHERE cale LIKE '%' || cod_nod || '%'
    LOOP
        -- Actualizarea calei pentru fiecare descendent
        UPDATE path_enumeration
        SET cale = REPLACE(cale_eliminare, cod_nod || '->', '')
        WHERE cale = cale_eliminare;
    END LOOP;

    -- Eliminarea nodului din tabelul de enumerare a căilor
    DELETE FROM path_enumeration 
	WHERE cod = cod_nod;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM public.adjacency_list
ORDER BY cod DESC

SELECT * FROM public.path_enumeration
ORDER BY cod DESC

-- cod (cod_node) 1056 are cod_parinte 1115
-- SELECT delete_node(1056); -- deleted

-- cod (cod_node) 1071 are cod_parinte 1110
-- SELECT delete_node(1071);  -- deleted

-- cod (cod_node)  are cod_parinte 
SELECT delete_node();

