1. Using PostgreSQL, the Postgis extension and the "towns" table with the data from the "towns.sql" file, solve next:
- find the city or cities (name and area) that have the largest, respectively the smallest area, using a single query
- for the towns in the towns table that only have population increases (see the pop* or popch* columns), find the length of the perimeter
- check if there are cities that have the shape of a polygon with gaps (you can return true/false or the names of the cities, respectively null, if they are not)
- find the minimum distance (and the names of the 2 cities) between the cities that have a surface area greater than 1500 hectares and have a population increase between 2000 and 2010 greater than 2000 inhabitants
(not considered the distance between the city and itself)

2. Create the "streets" and "buildings" tables that contain some non-spatial attributes and at least one spatial attribute (geom).
Highlight all "features" elements defined as geometries in the current scheme through a query.

3. Enter at least 10 records in each of the 2 tables (streets and buildings) and then write:
- 3 queries that use a spatial join (different for each query) between at least 2 of these 3 tables, with numerical results
- 3 queries that use a spatial join between at least 2 of these 3 tables, with a boolean result
