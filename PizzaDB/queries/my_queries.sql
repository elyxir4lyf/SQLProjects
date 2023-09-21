-- Dashboard 1
-- Joining the item data and the address data to the orders data

SELECT
	o.order_id,
	i.item_price, -- for total sales
	o.quantity, -- for total item sold
	-- the avergae order value is calulated in power BI
	i.item_cat, -- sales by category
	i.item_name, -- top selling items
	o.created_at, -- orders and sales by hour
	a.delivery_address1,
	a.delivery_address2,
	a.delivery_city,
	a.delivery_zipcode,-- orders by address
	o.delivery -- orders by delivery / pick up

FROM orders o
	LEFT JOIN item i ON o.item_id = i.item_id
	LEFT JOIN address a ON o.add_id = a.add_id




-- Dashboard 2

-- 1. Total quantity by ingridient (No. of orders x ingridient quantity in recipe)
SELECT
	s1.item_name,
	s1.ing_id,
	s1.ing_name,
	s1.ing_weight,
	s1.ing_price,
	s1.order_quantity,
	s1.recipe_quantity,
	s1.order_quantity * s1.recipe_quantity AS ordered_weight,
	s1.ing_price / s1.ing_weight AS unit_cost,
	(s1.order_quantity * s1.recipe_quantity) * (s1.ing_price / s1.ing_weight) as ingredient_cost
	-- For cleanlines in my table, I selected just the columns I needed, even though the other columns are available to be accessed in the future

FROM -- using a subquery so that I can reuse the ordered quanity in my calculations
	(SELECT
		o.item_id,
		i.sku,
		i.item_name,
		r.ing_id,
		ing.ing_name,
		r.quantity AS recipe_quantity,
		sum(o.quantity) AS order_quantity,
		ing.ing_weight,
		ing.ing_price

	FROM orders o
		LEFT JOIN item i on o.item_id = i.item_id
		LEFT JOIN recipe r ON i.sku = r.recipe_id
		LEFT JOIN ingredient ing ON ing.ing_id = r.ing_id

	GROUP BY 
		o.item_id, 
		i.sku, 
		i.item_name,
		r.ing_id,
		r.quantity,
		ing.ing_name,
		ing.ing_weight,
		ing.ing_price) s1



-- I created a view named `stock1` from the above so that I can clearly calsulate the following:
	-- a) Total weight ordered
	-- b) Inventory amount
	-- c) Inventory remaining per ingridient
	
-- 2: 
	
SELECT
	s2.ing_name,
	s2.ordered_weight,
-- 	ing.ing_weight,
-- 	inv.quantity,
	ing.ing_weight * inv.quantity AS total_inv_weight,
	(ing.ing_weight * inv.quantity) -s2.ordered_weight AS remaining_weight

FROM 
	(SELECT
		ing_name,
		ing_id,
		sum(ordered_weight) as ordered_weight
			
	FROM
		stock1
		GROUP BY ing_name, ing_id) s2
		
LEFT JOIN inventory inv ON inv.item_id = s2.ing_id -- joining the inventory table
LEFT JOIN ingredient ing ON ing.ing_id = s2.ing_id-- adding the total weight in stock

-- The above SQL queries settles all we need for the `stock` part of the brief!



-- Dashboard 3
-- Handling the Staff part of the project

SELECT
	r.date,
	s.first_name,
	s.last_name,
	s.hourly_rate,
	sh.start_time,
	sh.end_time,
	
	-- calculating the staff cost per row
	((HOUR(TIMEDIFF(sh.end_time,sh.start_time))* 60) + (MINUTE(TIMEDIFF(sh.end_time,sh.start_time)))) / 60 AS hours_in_shift,
	((HOUR(TIMEDIFF(sh.end_time,sh.start_time))* 60) + (MINUTE(TIMEDIFF(sh.end_time,sh.start_time)))) / 60 * s.hourly_rate AS staff_cost

FROM rota r
	LEFT JOIN staff s ON r.staff_id = s.staff_id
	LEFT JOIN shift sh ON r.shift_id = sh.shift_id