Using the tree structure files, it is required:
1. A query that displays all products from the "Miscellaneous" category without using the category code/id directly
2. A query that displays all the root nodes of the structure and for each such node the number of direct descendants;
add a column to the products table that will store in XML format the information about the direct descendants (code, name, position)
3. Display the first 10 products that are on levels 3 and 4 of the hierarchy and that have at least 2 vowels in the name, ordered alphabetically in each level (the level should also be displayed)
4. Creation of the necessary scripts (INSERTs, UPDATEs) to modify the structure so as to obtain at least one cycle in the hierarchical structure
5. (a cycle that you then highlight in the display of the result of a query; either with "YES", or with another string, for the node that induces that cycle)
