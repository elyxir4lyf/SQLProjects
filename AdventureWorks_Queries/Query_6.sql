-- Query 

-- Summarize the Internet Sales by Subcategory and return the top 5 subcategories
 

 /*
My Approach
 
Write a query that returns the top 5 best-selling subcategories by SalesAmount., I'm only interested in sales from our website (internet sales).

The data should only include sales where the country is United States and the currency is US Dollar
*/


SELECT TOP(5)

    dpsc.EnglishProductSubcategoryName AS SubCategory,
    SUM(fs.SalesAmount) AS SalesAmount
 
FROM FactInternetSales AS fs
    JOIN DimProduct AS dp
    ON fs.ProductKey=dp.ProductKey
    JOIN DimProductSubcategory AS dpsc
    ON dp.ProductSubcategoryKey=dpsc.ProductSubcategoryKey
    JOIN DimCurrency AS dcy
    ON fs.CurrencyKey=dcy.CurrencyKey
    JOIN DimSalesTerritory AS dst
    ON fs.SalesTerritoryKey=dst.SalesTerritoryKey
 
WHERE dst.SalesTerritoryCountry =N'United States'
AND dcy.CurrencyName=N'US Dollar'
 
GROUP BY dpsc.EnglishProductSubcategoryName
 
ORDER BY SalesAmount DESC