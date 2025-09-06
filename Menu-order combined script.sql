CREATE OR REPLACE VIEW full_order_data AS 
SELECT  od.order_details_id,
		od.order_id,
		od.order_date,
		od.order_time,
		CAST(CAST(order_date AS DATETIME)+CAST(order_time AS TIME) AS DATETIME) AS order_datetime,
		od.item_id,
		mi.item_name,
		mi.category,
		mi.price,
		IF(price < 10, 'Under $10', '$10 or more') AS price_range
FROM order_details od
LEFT JOIN menu_items mi ON mi.menu_item_id = od.item_id
WHERE od.item_id IS NOT NULL -- drop 137 rows with null values of item_id
;

-- SELECT * FROM full_order_data;

-- Which items were most popular?
SELECT  item_name, 
		category, 
		price, 
		SUM(price) AS revenue,
		COUNT(item_id) AS items_sold
FROM full_order_data
GROUP BY item_name, category, price
ORDER BY items_sold DESC;
	-- The top 5 items by units sold were: Hamburger, Edamame, Korean Beef Bowl, Cheeseburger, and French Fries. 

#What items brought in the greatest amount of revenue?
SELECT 	fod.item_id,
		fod.category,
		fod.item_name, 
		fod.price,
		SUM(fod.price) AS total_revenue,
		COUNT(fod.item_id) AS items_sold
FROM full_order_data fod 
GROUP BY fod.item_id
ORDER BY total_revenue DESC
LIMIT 5;	
	-- The top five revenue-generating items, in order, were the Korean Beef Bowl, Spaghetti & Meatballs, Tofu Pad Thai, Cheeseburger, and Hamburger

-- Which items generated the most revenue in each cuisine?
SELECT  item_name, 
		category,
		price,
		COUNT(item_id) AS items_sold, 
		SUM(price) AS revenue 
FROM full_order_data
GROUP BY category, item_name, price 
ORDER BY category,revenue DESC;

#Which cuisine types brought in the greatest amount of revenue?
SELECT 	category, 
		SUM(fod.price) AS total_revenue
FROM full_order_data fod 
GROUP BY category
ORDER BY SUM(fod.price) DESC;

#What was the most frequently-ordered cuisine type?
SELECT  category, 
		COUNT(order_details_id) AS items_sold
FROM full_order_data fod 
GROUP BY category;

-- Italian food brought in the highest revenue overall, even though the Asian category sold more total items. 
-- American food was the worst performing category, with the fewest items sold and the least revenue generated. 
-- Next step is to identify commonalities among the highest revenue orders. 


-- What were the order_ids for the top 10 orders by revenue?
SELECT  order_id, 
		COUNT(order_details_id) AS items_sold, 
		SUM(price) AS revenue
	FROM full_order_data
GROUP BY order_id
ORDER BY revenue DESC
LIMIT 10;

		-- 440, 2075, 1957, 330, 2675, 4482,1274,2188,3473,3583

-- How many items of each cuisine do top orders include? Do they include lots of cheap items, or a few expensive items?

SELECT  -- *
 		order_id,
 			COUNT(item_id) AS items_ordered
 ,			SUM(price) AS revenue
 ,			SUM(CASE WHEN category = 'American' THEN 1 END) AS items_ordered_American
 ,		SUM(CASE WHEN category = 'Asian' THEN 1 END) AS items_ordered_Asian
 ,		SUM(CASE WHEN category = 'Italian' THEN 1 END) AS items_ordered_Italian
 ,		SUM(CASE WHEN category = 'Mexican' THEN 1 END) AS items_ordered_Mexican
 ,		SUM(CASE WHEN price_range = 'Under $10' THEN 1 END) AS items_pricedunder10
 ,		SUM(CASE WHEN price_range = '$10 or more' THEN 1 END) AS items_priced10ormore
FROM full_order_data fod
WHERE fod.order_id IN (440, 2075, 1957, 330, 2675,4482,1274,2188,3473,3583)
 GROUP BY order_id
 ORDER BY revenue DESC
;
	-- Top 10 orders all included at least 3 Italian dishes. These orders also all included at least 10 dishes that costed $10 or more. 

-- What were the most popular items in the top 10 orders by revenue? 
SELECT  item_name, 
		category, 
		price, 
		SUM(price) AS revenue,
		COUNT(item_id) AS items_sold
FROM full_order_data
WHERE order_id IN (440, 2075, 1957, 330, 2675,4482,1274,2188,3473,3583)
GROUP BY item_name, category, price
ORDER BY items_sold DESC;
-- The top items ordered by the top 10 high revenue orders were: Eggplant Parmesan (Italian, 10 units sold), Chips and Salsa (Mexican, 9 units sold), Spaghetti and Meatballs (Italian, 8 units sold), Korean Beef Bowl (Asian, 7 units sold), Salmon Roll (Asian, 7 units sold), and Chicken Parmesan (Italian, 7 units sold).
-- Italian and Asian dishes are extremely popular among high-revenue orders. 

-- Overall, what were the most popular items in each price range (Over/Under $10)?
SELECT  price_range,
		item_name, 
		category, 
		price, 
		SUM(price) AS revenue,
		COUNT(item_id) AS items_sold
FROM full_order_data
GROUP BY price_range, item_name, category, price
ORDER BY price_range,items_sold DESC;
	-- The top 5 items by units sold in the over $10 price range were: Hamburger, Korean Beef Bowl, Cheeseburger, Tofu Pad Thai, and Steak Torta. 

-- Export data to CSV for use in Tableau and other software.

		-- SELECT "order_details_id","order_id","order_date","order_time","order_datetime","item_id","item_name","category","price","price_range"
		-- UNION ALL
		-- SELECT * FROM full_order_data
		-- INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 9.3/Data/full_order_data2.csv';
