-- Query 

-- Create a  detailed list of invoices and invoice line numbers, but we’re only interested in currency key 100
 

 /*
My Approach
 
Return InvoiceNumber, InvoiceLineNumber and SalesAmount from the FactInternetSales table. Return only lines WHERE the currency key is 100
*/



SELECT 
 
SalesOrderNumber AS InvoiceNumber,
SalesOrderLineNumber AS InvoiceLineNumber,
SalesAmount AS SalesAmount
 
FROM FactInternetSales
 
WHERE CurrencyKey = 100