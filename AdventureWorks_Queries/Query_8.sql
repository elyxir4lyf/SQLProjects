-- Query 

-- Create a summary of expenditure account totals, and then calculate a PCT of total. 
 

 /*
My Approach
 
Write a query that will return Account Description, and amounts corresponding to ACTUALS.

Filter the results to meet the following conditions:
- ACTUALS only
- Canadian Division only
- Calendar year 2013 only
- Expenditure accounts only

Create a subquery to help calculate the total sales that meet the same conditions.

*/


SELECT

	o.OrganizationName AS Organization,

    a.AccountType AS AccountType,
    a.AccountDescription AS Account,

    SUM(ff.Amount) AS Amount

FROM FactFinance AS ff
    INNER JOIN DimScenario AS s
    ON ff.ScenarioKey = s.ScenarioKey
    INNER JOIN DimDate AS d
    ON ff.DateKey = d.DateKey
    INNER JOIN DimOrganization AS o
    ON ff.OrganizationKey = o.OrganizationKey
    INNER JOIN DimAccount AS a
    ON ff.AccountKey = a.AccountKey

WHERE s.ScenarioName = N'Actual'
    AND d.CalendarYear = 2011
    AND d.EnglishMonthName = N'January'
    AND o.OrganizationName = N'Southwest Division'
    AND a.AccountType = N'Expenditures'

GROUP BY o.OrganizationName, a.AccountType, a.AccountDescription

ORDER BY Amount DESC