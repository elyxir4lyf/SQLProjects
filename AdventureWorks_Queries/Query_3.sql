-- Query 

-- Create a unique list of sales territory keys. This will help to better understand the database.
 

 /*
My Approach
 
Write a query to return the sales territory column from the FactInternetSales table. Return a unique list of territories only. Order the results alphabetically for ease
*/


SELECT DISTINCT SalesTerritoryKey AS SalesTerritory
 
FROM FactInternetSales

ORDER BY SalesTerritory ASC