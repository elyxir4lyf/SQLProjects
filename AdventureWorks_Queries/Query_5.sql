-- Query 

-- Create a list of homeowner customers, along with the number of cars owned.
 

 /*
My Approach
 
Write a query against the dimCustomer table that returns all customers that are homeowners and have
more than 1 car.

The query should include full customer names, number of cars owned, and email.

The numbers of cars owned should categorize customers into groups.
*/


SELECT 
 
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    CASE 
        WHEN NumberCarsOwned IN (2,3) THEN  '2-3'
        WHEN NumberCarsOwned >=4 THEN '4+'
    END AS NumberOfCarsOwned,
    EmailAddress AS Email
 
FROM DimCustomer
 
WHERE HouseOwnerFlag = 1 AND NumberCarsOwned > 1