1. Using the "students" table created in the first problem, create views for the following problems (easilysolved with analytical functions):
- For each student display: name, surname, group, average, average of the section the student belongs to, distance from the average (variance), the student's position in the year he/she belongs to
(in descending order of students according to their average).
- For each group, students who have the first 3 highest averages.

3. Use the table "cursz" from the "master" schema.
```
The following table is considered in the current schema:
CREATE TABLE cursz (
 zi number(2),
 luna number(2),
 an number(4),
 valoare number(6,4),
 moneda char(3)
);
```
- The time intervals in which the exchange rate (for a certain currency) decreased for at least 10 consecutive days (display the number of days of decrease and the difference in value from the beginning and end of the period).
- Another problem is asked that determines a certain model (eg: template V, W, M, etc.) using the data from this table.

3. Create a user package that contains at least 3 functions/procedures that can:
- display data from the views from point 1, the data being filtered according to at least 2 input parameters
- contain a journaling/log function (insertion of records in a table called journal/log, at each call of the procedure/function from point a, at its beginning and/or end, to calculate the duration,
either at ending successfully or with an error; the table must contain details about the function run, the duration, whether the run was successful or an error has occured, and the error).
