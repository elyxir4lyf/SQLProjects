/*
	QUERIES OF PARCH AND POSEY
*/




-- 1. Create a table that displays all the data in the occurred_at, account_id, and channel columns of the web_events table, and limits the output to only the first 15 rows.

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;



-- 2. Return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;



-- 3. Return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;



-- 4. Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;



-- 5. Return a table that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;



-- 6. Write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;



-- 7. Compare the results of these two queries above. How are the results different when you switch the column you sort on first?

-- Answer:

/*
In query #5, all of the orders for each account ID are grouped together, and then within each of those groupings, the orders appear from the greatest order amount to the least. 
In query #6, since I sorted by the total dollar amount first, the orders appear from greatest to least regardless of which account ID they were from. Then they are sorted by account ID next. (The secondary sorting by account ID is difficult to see here, since only if there were two orders with equal total dollar amounts would there need to be any sorting by account ID.)
*/



-- 8. Pull the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;



-- 9. Pull the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;



-- 10. Pull the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;



-- 11. Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;



-- 12. Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';



-- 13. Return a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

SELECT id, account_id, 
       standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;



-- 14 Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also.

SELECT id, account_id, 
	   poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;



-- 15. Return all the companies whose names start with 'C'.

SELECT name
FROM accounts
WHERE name LIKE 'C%';



-- 16. Return all companies whose names contain the string 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name LIKE '%one%';



-- 17. Return all companies whose names end with 's'.

SELECT name
FROM accounts
WHERE name LIKE '%s';



-- 18. Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');


-- 19. Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');



-- 20. Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');



-- 21. Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');



-- Use the accounts table to find:

-- 22. All the companies whose names do not start with 'C'.

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';



-- 23. All companies whose names do not contain the string 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';



-- 24. All companies whose names do not end with 's'.

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';


-- 25. Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;



-- 26. Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';



-- 27. write a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.

SELECT occurred_at, gloss_qty 
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;



-- 28. Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;



-- 29. Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);


-- 30. Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
      AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
      AND primary_poc NOT LIKE '%eana%');



-- 31. Pull all the data from the accounts table, and all the data from the orders table.

SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;



-- 32. Pull standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.

SELECT orders.standard_qty, orders.gloss_qty, 
       orders.poster_qty,  accounts.website, 
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;



-- 33. Provide a table for all the for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';



-- 34. Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;



-- 35. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;


-- 36. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;



-- 37. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;



-- 38. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;



-- 39. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price.

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;



-- 40. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;



-- 41. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first.

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;



-- 42. What are the different channels used by account id 1001?

SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';



-- 43. Find all the orders that occurred in 2015.

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;



-- 44. Finding the number of events that occur for each day for each channel. On which day-channel pair did the most events occur. (Mark all that are true).

SELECT DATE_TRUNC('day',occurred_at) AS day,
       channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;



-- 45. Create a query that simply provides all the data from the query above.

SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
           channel, COUNT(*) as events
     FROM web_events 
     GROUP BY 1,2
     ORDER BY 3 DESC) sub;
	 
	 

-- 46. Find the average number of events for each channel.

SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;



-- 47. Pull out month level information about the first order placed in the orders table. What was the month/year combo for the first order placed?

SELECT DATE_TRUNC('month', MIN(occurred_at)) 
FROM orders;



-- Use the result above to query the orders that took place in the same month and year as the first order, and then pull the average for each type of paper qty in this month.


-- 48. The average amount of standard paper sold on the first month that any order was placed in the orders table (in terms of quantity).
-- The average amount of gloss paper sold on the first month that any order was placed in the orders table (in terms of quantity).
-- The average amount of poster paper sold on the first month that any order was placed in the orders table (in terms of quantity)

SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
     (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);



-- 49. The total amount spent on all orders on the first month that any order was placed in the orders table (in terms of usd).

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) 
	  FROM orders);



-- 50. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

SELECT t3.rep_name, t2.region_name, t2.max_total_sales
FROM
	(SELECT region_name, MAX(total_sales) max_total_sales 
	FROM 
		(SELECT s.name rep_name, 
				r.name region_name, 
				SUM(o.total_amt_usd) total_sales
		FROM sales_reps s
		JOIN accounts a
		ON a.sales_rep_id = s.id
		JOIN orders o
		ON o.account_id = a.id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1,2
		ORDER BY 3 DESC) t1
	GROUP BY 1) t2
JOIN(
	SELECT s.name rep_name, 
		   r.name region_name, 
		   SUM(o.total_amt_usd) total_sales
	FROM sales_reps s
	JOIN accounts a
	ON a.sales_rep_id = s.id
	JOIN orders o
	ON o.account_id = a.id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1,2
	ORDER BY 3 DESC) t3
ON t2.region_name = t3.region_name AND t2.max_total_sales = t3.total_sales;

/*-------------- OR ----------------*/

-- 51

WITH t1 AS (
		SELECT s.name rep_name, 
				r.name region_name, 
				SUM(o.total_amt_usd) total_amt
		FROM sales_reps s
		JOIN accounts a
		ON a.sales_rep_id = s.id
		JOIN orders o
		ON o.account_id = a.id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1,2
		ORDER BY 3 DESC),
	
	 t2 AS (
	    SELECT region_name, MAX(total_amt) max_total_sales 
		FROM t1
		GROUP BY 1)
		
SELECT t1.rep_name, t2.region_name, t2.max_total_sales
FROM t2
JOIN t1
ON t2.region_name = t1.region_name AND t2.max_total_sales = t1.total_amt;




-- 52. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?

SELECT r.name, count(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = 
	(SELECT MAX(total_sales)
	FROM
		(SELECT r.name region_name, 
			   SUM(o.total_amt_usd) total_sales
		FROM sales_reps s
		JOIN accounts a
		ON a.sales_rep_id = s.id
		JOIN orders o
		ON o.account_id = a.id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1) t1);

/* -------------- OR -------------- */

-- 53.

WITH t1 AS (
		SELECT r.name region_name, 
			   SUM(o.total_amt_usd) total_sales
		FROM sales_reps s
		JOIN accounts a
		ON a.sales_rep_id = s.id
		JOIN orders o
		ON o.account_id = a.id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1),
	 
	 t2 AS (
	SELECT MAX(total_sales)
	FROM t1)

SELECT r.name, count(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);


/* ---------- A Shorter Anmwer ---------- */

-- 54.

SELECT r.name region_name, 
	   SUM(o.total_amt_usd) total_sales, 
	   COUNT(o.total) total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1;



-- 55. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?

SELECT count(*)
FROM
	(SELECT a.name
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	GROUP BY 1
	HAVING sum(o.total) > 
		(SELECT total
		FROM
			(SELECT a.name account_name, 
				   SUM(o.standard_qty) std_total,
				   SUM(o.total) total
			FROM accounts a
			JOIN orders o
			ON o.account_id = a.id
			GROUP BY 1
			ORDER BY 2 DESC
			LIMIT 1) inner_tab)
			) counter_tab;

/* -------------- OR -------------- */

-- 56.

WITH tab1 AS (
			SELECT a.name account_name, 
				   SUM(o.standard_qty) std_total,
				   SUM(o.total) total
			FROM accounts a
			JOIN orders o
			ON o.account_id = a.id
			GROUP BY 1
			ORDER BY 2 DESC
			LIMIT 1),
	 
	 tab2 AS (
			SELECT total
			FROM tab1),
	 
	 tab3 AS (
			SELECT a.name
			FROM orders o
			JOIN accounts a
			ON a.id = o.account_id
			GROUP BY 1
			HAVING sum(o.total) > (SELECT * FROM tab2))

SELECT count(*)
FROM tab3;




-- 57. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?

SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON a.id = w.account_id AND a.id =
  (SELECT id
  FROM
    (SELECT a.id, a.name, 
                    SUM(o.total_amt_usd) total
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 1) inner_table)
GROUP BY 1,2
ORDER BY 3 DESC;

/* -------------- OR -------------- */

-- 58. 

WITH table1 AS (
				SELECT a.id, a.name, 
					   SUM(o.total_amt_usd) total
				FROM orders o
				JOIN accounts a
				ON o.account_id = a.id
				GROUP BY 1, 2
				ORDER BY 3 DESC
				LIMIT 1),
	 
	 table2 AS (
				SELECT id
				FROM table1)
  
SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON a.id = w.account_id AND a.id = (SELECT * FROM table2)
GROUP BY 1,2
ORDER BY 3 DESC;



-- 59. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

SELECT  AVG(total_spent)
FROM
	(SELECT a.id, 
			a.name account_name, 
			SUM(o.total_amt_usd) total_spent
	FROM accounts a
	JOIN orders o
	ON o.account_id = a.id
	GROUP BY 1,2
	ORDER BY 3 DESC
	LIMIT 10) inner_tab;

/* -------------- OR -------------- */

-- 60.

WITH tab1 AS (
			SELECT a.id, a.name account_name, 
		   		   SUM(o.total_amt_usd) total_spent
			FROM accounts a
			JOIN orders o
			ON o.account_id = a.id
			GROUP BY 1,2
			ORDER BY 3 DESC
			LIMIT 10)
			
SELECT  AVG(total_spent)
FROM tab1;



-- 61. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.

SELECT AVG(avg_amt)
FROM 
	(SELECT o.account_id, 
		    AVG(o.total_amt_usd) avg_amt
     FROM orders o
     GROUP BY 1
     HAVING AVG(o.total_amt_usd) > 
		(SELECT AVG(o.total_amt_usd) avg_all
         FROM orders o)) temp_table;

/* -------------- OR -------------- */		 

-- 62. 

WITH table1 AS (
				SELECT AVG(o.total_amt_usd) avg_all
				FROM orders o
				JOIN accounts a
				ON a.id = o.account_id),

	 table2 AS (
				SELECT o.account_id, 
					   AVG(o.total_amt_usd) avg_amt
				FROM orders o
				GROUP BY 1
				HAVING AVG(o.total_amt_usd) > (SELECT * FROM table1))

SELECT AVG(avg_amt)
FROM table2;



-- 63. Pull the web extensions of websites and provide the number of each website type that exist in the accounts table.

SELECT RIGHT(website, 4) AS web_extension,
       count(*) AS count
FROM accounts
GROUP BY 1;



-- 64. Pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).

SELECT LEFT(UPPER(name), 1) AS first_letter,
       count(*) AS letters_count
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;



-- 65. create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter.

SELECT SUM(num) nums, 
	   SUM(letter) letters
FROM (
	SELECT name, CASE 
					WHEN LEFT(UPPER(name), 1) 
						IN ('0','1','2','3','4','5','6','7','8','9') 
                    THEN 1 ELSE 0 END AS num, 
         
				 CASE 
					WHEN LEFT(UPPER(name), 1) 
				        IN ('0','1','2','3','4','5','6','7','8','9') 
                    THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;



-- 66. Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?

SELECT SUM(vowels) vowels, 
	   SUM(other) other
FROM (
	SELECT name, 
		CASE 
			WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
			THEN 1 ELSE 0 END AS vowels, 
		 
		 CASE 
			WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
			THEN 0 ELSE 1 END AS other
	FROM accounts) t1;


	
-- 67. There are 80 company names that start with a vowel and 271 that start with other characters. Therefore 80/351 are vowels or 22.8%. Therefore, 77.2% of company names do not start with vowels. - */
-- Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
	   RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) 	   last_name
FROM accounts;



-- 68. Replicate the same as above for every rep name in the sales_reps table. Again provide first and last name columns.

SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name, 
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;