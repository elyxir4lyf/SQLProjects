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

	a.AccountDescription AS Account,
    SUM(ff.Amount) AS Amount,
    SUM(ff.Amount) / (SELECT
                        SUM(ff.Amount) AS Amount

                        FROM FactFinance AS ff
                            INNER JOIN DimAccount AS a
                            ON ff.AccountKey = a.AccountKey
                            INNER JOIN DimScenario AS s
                            ON ff.ScenarioKey = s.ScenarioKey
                            INNER JOIN DimOrganization AS o
                            ON ff.OrganizationKey = o.OrganizationKey
                            INNER JOIN DimDate AS d
                            ON ff.DateKey = d.DateKey

                        WHERE s.ScenarioName = N'Actual'
                            AND o.OrganizationName = N'Canadian Division'
                            AND d.CalendarYear = 2013
                            AND a.AccountType = N'Expenditures') AS PctOfTotal
    
FROM FactFinance AS ff
    INNER JOIN DimAccount AS a
    ON ff.AccountKey = a.AccountKey
    INNER JOIN DimScenario AS s
    ON ff.ScenarioKey = s.ScenarioKey
    INNER JOIN DimOrganization AS o
    ON ff.OrganizationKey = o.OrganizationKey
    INNER JOIN DimDate AS d
    ON ff.DateKey = d.DateKey

WHERE s.ScenarioName = N'Actual'
    AND o.OrganizationName = N'Canadian Division'
    AND d.CalendarYear = 2013
    AND a.AccountType = N'Expenditures'

GROUP BY a.AccountDescription

ORDER BY Amount DESC