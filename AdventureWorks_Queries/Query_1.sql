-- Query 

-- Create a list of product costs, grouped by invoice numbers. 
 

 
 /*
My Approach
 
Return InvoiceNumber and TotalProductCost from the FactInternetSales table. Returning only invoices that HAVE a total product costper Invoice Number > 2000
*/

SELECT 
 
SalesOrderNumber AS InvoiceNumber,
SUM(TotalProductCost) AS TotalProductCost
 
FROM FactInternetSales
 
GROUP BY SalesOrderNumber
 
HAVING SUM(TotalProductCost) > 2000
 
ORDER BY TotalProductCost DESC