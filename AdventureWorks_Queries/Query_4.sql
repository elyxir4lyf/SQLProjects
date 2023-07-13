-- Query 

-- Create a summary of  Sales territory 1 sales for the lead up period to Christmas.
 

 /*
My Approach
 
Write a query against the FactInternet Sales table that returns orders placed in December for the Sales Territory 1. The query includes SalesOrderNumber, SalesOrderLineNumber, SalesAmount
and TaxAmount.
*/


SELECT

    SalesOrderNumber AS InvoiceNumber, 
    SalesOrderLineNumber AS InvoiceLineNumber, 
    SalesAmount AS SalesAmount, 
    TaxAmt AS TaxAmount
 
FROM FactInternetSales
 
WHERE DATENAME(month,OrderDate) = N'December' AND SalesTerritoryKey = 1