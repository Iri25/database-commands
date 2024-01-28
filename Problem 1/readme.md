1. Using CREATE TABLE statements create at least two tables and define integrity constraints for these tables:
- key restrictions: unique, primary
- restrictions for column values
- restrictions for the values of the records
- foreign key restrictions
  
The creation of indexes is required for the defined tables. 

2. Create a table with the structure and data of the "students" table from the MASTER schema. Mention all the steps by which you solved the request 
3. Use statement for: adding, modifying, deleting data in the defined tables. It will be observed how they are used with the defined restrictions, through requests to execute instructions that do not respect them. 
4. System views will be used to obtain information regarding: defined tables, the tables the user has access to, the restrictions defined, the indexes built, the columns in a certain table (name, type). 
5. Using the "students" table, a procedure is required that determines at most p% students from each section that are in the middle of the grade range (50-p/2% <-> 50+p/2%) (surname, surname, section, average),
sorted in descending order by average and alphabetically, students who have an average grade higher than 5 (p is a parameter for the procedure).
```
Example:
- if for section 1 we have 10 students with an average above 5 and p is 20%, then 2 students will be displayed, from positions 5 and 6;
- if for section 1 we have 9 students with an average above 5 and p is 20%, then it will display 1 student, from position 5;
```
6. A view is required that determines the list of procedures (schema name, procedure name) that the current user can use. 
7. A procedure is requested that has as parameters a schema name and a procedure name and determines the source text with which the procedure was defined, in the same order of the lines. 
8. It is required to use in a programming environment (PHP) the components required above (execution of the procedure, display of data provided by the view, execution of the procedure). 
