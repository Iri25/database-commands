-- 1. Folosind PostgreSQL, extensia Postgis si tabela "towns" cu datele din fisierul "towns.sql", 
-- rezolvatiurmatoarele:

-- a. gasiti orasul sau orasele (numele si suprafata) ce au cea mai mare, 
-- respectiv cea mai mica suprafata, folosind o singura interogare

SELECT town, shape_area
FROM towns
WHERE shape_area = (SELECT MAX(shape_area) FROM towns)
   OR shape_area = (SELECT MIN(shape_area) FROM towns);

-- b. pentru orasele din tabela towns care au doar cresteri ale populatiei 
--(vezi coloanele pop* sau popch*)gasiti lungimea perimetrului

SELECT town, shape_len
FROM towns
WHERE (pop1980 < pop1990 AND pop1990 < pop2000 AND pop2000 < pop2010)
   OR (popch80_90 > 0 AND popch90_00 > 0 AND popch00_10 > 0);

-- c. verificati daca exista orase care au forma de poligon cu goluri 
-- (puteti returna true/false sau, numele oraselor, respectiv null, daca nu sunt)

-- ST_IsValid - verifica daca o valoare ST_Geometry  estte bine formata si valabila
SELECT town, ST_IsValid(geom) AS is_valid
FROM towns;

-- ST_NumInteriorRings - returneaza numarul de inele interioare ale poligonului
SELECT
    town,
    CASE
        WHEN ST_NumInteriorRings(geom) > 0 THEN 'true'
        ELSE 'false'
    END AS has_interior_rings
FROM towns;

-- d. gasiti distanta minima (si numele celor 2 orase) intre orasele care au suparafata 
-- mai mare de 1500 de hectare si au o crestere a populatiei intre 2000 si 2010 mai mare 
-- de 2000 de locuitori (nu se considera distanta dintre oras cu el insusi)
SELECT DISTINCT ON (a.town, b.town) a.town AS town1, b.town AS town2, ST_Distance(a.geom, b.geom) AS distance
FROM towns a
JOIN towns b ON a.town_id < b.town_id 
WHERE a.shape_area > 15000000  -- 1 ha = 10.000 m^2
  AND (b.pop2010 - b.pop2000) > 2000  
ORDER BY a.town, b.town, ST_Distance(a.geom, b.geom);


-- 2. Creati tabelele "streets" si "buildings" care sa contina cateva atribute nespatiale 
-- si cel putin un atribut spatial (geom).
-- Evidentiati printr-o interogare toate elementele "features" definite ca geometrii in 
-- schema curenta.

-- Crearea tabelului "streets"
CREATE TABLE streets (
  street_id serial PRIMARY KEY,
  street_name varchar(255),
  length_meters numeric,
  geom geometry(Point, 26986)  -- coloana geom de tip Point într-un sistem de coordonate specific (26986)
);

-- Crearea tabelului "buildings"
CREATE TABLE buildings (
  building_id serial PRIMARY KEY,
  building_name varchar(255),
  num_floors int,
  geom geometry(Polygon, 26986)  -- coloana geom de tip Polygon în același sistem de coordonate (26986)
);

SELECT f_table_name, f_geometry_column
FROM geometry_columns;



-- 3. Introduceti cel putin 10 inregistrari in fiecare din cele 2 tabele (streets si buildings) 
-- si apoi scrieti:

-- Inserarea înregistrărilor în tabela "streets"
INSERT INTO streets (street_name, length_meters, geom)
VALUES
  ('Main Street', 1500, ST_SetSRID(ST_MakePoint(10, 20), 26986)),
  ('First Avenue', 1200, ST_SetSRID(ST_MakePoint(30, 40), 26986)),
  ('Elm Street', 900, ST_SetSRID(ST_MakePoint(50, 60), 26986)),
  ('Oak Avenue', 1100, ST_SetSRID(ST_MakePoint(70, 80), 26986)),
  ('Pine Street', 800, ST_SetSRID(ST_MakePoint(90, 100), 26986)),
  ('Cedar Avenue', 1350, ST_SetSRID(ST_MakePoint(110, 120), 26986)),
  ('Maple Street', 1000, ST_SetSRID(ST_MakePoint(130, 140), 26986)),
  ('Birch Avenue', 950, ST_SetSRID(ST_MakePoint(150, 160), 26986)),
  ('Willow Street', 1250, ST_SetSRID(ST_MakePoint(170, 180), 26986)),
  ('Cherry Avenue', 1050, ST_SetSRID(ST_MakePoint(190, 200), 26986));

-- Inserarea înregistrărilor în tabela "buildings"
INSERT INTO buildings (building_name, num_floors, geom)
VALUES
  ('Office Building A', 5, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(60 70, 70 70, 70 80, 60 80, 60 70)')), 26986)),
  ('Residential Building B', 7, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(100 110, 110 110, 110 120, 100 120, 100 110)')), 26986)),
  ('Retail Building C', 3, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(140 150, 150 150, 150 160, 140 160, 140 150)')), 26986)),
  ('Industrial Building D', 4, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(180 190, 190 190, 190 200, 180 200, 180 190)')), 26986)),
  ('Apartment Building E', 10, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(220 230, 230 230, 230 240, 220 240, 220 230)')), 26986)),
  ('Hotel Building F', 6, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(260 270, 270 270, 270 280, 260 280, 260 270)')), 26986)),
  ('Warehouse Building G', 2, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(300 310, 310 310, 310 320, 300 320, 300 310)')), 26986)),
  ('School Building H', 3, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(340 350, 350 350, 350 360, 340 360, 340 350)')), 26986)),
  ('Hospital Building I', 8, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(380 390, 390 390, 390 400, 380 400, 380 390)')), 26986)),
  ('Library Building J', 4, ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(420 430, 430 430, 430 440, 420 440, 420 430)')), 26986));


-- a. 3 interogari care sa foloseasca un join spatial (diferit pentru fiecare interogare) 
-- intre cel putin 2 din aceste 3 tabele, cu rezultat numeric

-- Toate străzile care intersectează clădirile 
-- și numărul de străzi intersectate pentru fiecare clădire
SELECT b.building_name, COUNT(s.street_id) AS num_intersecting_streets
FROM buildings b
JOIN streets s ON ST_Intersects(b.geom, s.geom)
GROUP BY b.building_name;

-- Toate străzile care se află la o distanță de 200 de metri de o clădire 
-- și numărul de străzi găsite pentru fiecare clădire
SELECT b.building_name, COUNT(s.street_id) AS num_nearby_streets
FROM buildings b
JOIN streets s ON ST_DWithin(b.geom, s.geom, 200)
GROUP BY b.building_name;

-- Toate clădirile care sunt complet conținute într-o anumită zonă geografică 
-- și numărul total de etaje din aceste clădiri
SELECT ST_Area(p.geom) AS area, SUM(b.num_floors) AS total_floors
FROM buildings b
JOIN (
	SELECT ST_SetSRID(ST_MakePolygon(ST_GeomFromText('LINESTRING(60 70, 80 70, 80 90, 60 90, 60 70)')), 26986) AS geom
	) AS p ON ST_Within(b.geom, p.geom)
GROUP BY p.geom;

-- b. 3 interogari care sa foloseasca un join spatial intre cel putin 2 din aceste 3 tabele, 
-- cu rezultat boolean

-- Verificare dacă există clădiri care se intersectează cu străzi
SELECT DISTINCT b.building_id, s.street_id, ST_Intersects(b.geom, s.geom) AS intersects
FROM buildings b
JOIN streets s ON ST_Intersects(b.geom, s.geom);


-- Verificare dacă există străzi care intersectează o anumită clădire
SELECT b.building_name,
    EXISTS 
	(
        SELECT 1
        FROM streets s
        WHERE ST_Intersects(b.geom, s.geom)
    ) AS streets_intersect
FROM buildings b;

-- Verificare dacă există clădiri care intersectează oricare stradă
SELECT
    EXISTS 
	(
        SELECT 1
        FROM streets s
        JOIN buildings b ON ST_Intersects(b.geom, s.geom)
    ) AS buildings_and_streets_intersect;
