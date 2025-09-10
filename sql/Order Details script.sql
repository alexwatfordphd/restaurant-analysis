#Objective 2: Explore the Order Details table

-- 1. Check data quality of the order_details table.

		-- Examine # of columns, column names, and column datatypes
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'order_details'
				-- 5 columns: order_details_id,order_id,order_date,order_time,item_id
		
		-- Examine the order_details table. 
		SELECT  order_details_id,
				order_id,
				order_date,
				order_time,
				item_id 
		FROM order_details od ;
		
		-- Count total rows in order_details table. (12,234)
		SELECT COUNT(*) FROM order_details;
		
		-- Check for missing values in the order_details table. (137 rows are missing item_id)
		SELECT
		(SELECT count(*) FROM order_details od) as total_rows,
		(SELECT count(*) FROM order_details od WHERE od.item_id  is NULL) as A,
		(SELECT count(*) FROM order_details od WHERE od.order_date  is NULL) as B,
		(SELECT count(*) FROM order_details od WHERE od.order_details_id  is NULL) as C,
		(SELECT count(*) FROM order_details od WHERE od.order_id   is NULL) as D,
		(SELECT count(*) FROM order_details od WHERE od.order_time  is NULL) as E;
	-- Count total rows in order_details table that are NOT missing item_id. (12,097)
		SELECT COUNT(*) FROM order_details
		WHERE item_id IS NOT NULL;
	
	-- Inspect rows with NULL values for item_id. Check for patterns. 
		SELECT * FROM order_details
		WHERE item_id IS NULL;


-- 2. What is the date range of the order details table?
SELECT MIN(order_date),MAX(order_date) FROM order_details od 
WHERE od.item_id IS NOT NULL
;
		-- January 1, 2023  to March 31, 2023  (Q1 of 2023)
 
-- 3. How many orders were made within this date range? (5,343 orders)
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM order_details od 
WHERE 	1=1 AND
		od.item_id IS NOT NULL AND
		order_date >= "2023-01-01" AND 	order_date <= "2023-03-31";

-- 4. How many items were sold? (12,097) 
SELECT COUNT(order_details_id) AS items_sold,
	   COUNT(item_id) AS items_sold_nonull
FROM order_details od ;

-- 5. What was the max amount of items per order? (14)
SELECT 	order_id, 
		COUNT(item_id) AS items_sold
FROM order_details od 
WHERE item_id IS NOT NULL
GROUP BY(od.order_id)
ORDER BY items_sold DESC
;

-- 6. How many orders had more than 10 items? (54 orders)
SELECT COUNT(DISTINCT order_id)
FROM (
		SELECT  od.order_id, 
				COUNT(order_details_id) AS items_sold
				,COUNT(item_id) AS items_sold_no_null 
		FROM order_details od 
		WHERE od.item_id IS NOT NULL
		GROUP BY od.order_id 
		ORDER BY items_sold_no_null DESC
		) AS t
WHERE items_sold >10
;

-- 7. How many orders made and items sold per month? 
SELECT  MONTH(order_date) AS order_month,
		COUNT(DISTINCT order_id) AS total_orders,
        COUNT(order_details_id) AS items_sold,
        SUM(order_details_id IS NOT NULL)/COUNT(DISTINCT od.order_id) AS avg_itemsperorder,
        SUM(order_details_id IS NOT NULL)/COUNT(DISTINCT od.order_date) AS avg_itemsperday,
        COUNT(DISTINCT order_id)/COUNT(DISTINCT od.order_date) AS avg_ordersperday
FROM order_details od 
WHERE od.item_id IS NOT NULL
GROUP BY MONTH(order_date)
UNION ALL
SELECT 'TOTAL' AS order_month, 
		COUNT(DISTINCT order_id),
		COUNT(od.order_details_id),
		SUM(order_details_id IS NOT NULL)/COUNT(DISTINCT od.order_id),
		SUM(order_details_id IS NOT NULL)/COUNT(DISTINCT od.order_date),
		COUNT(DISTINCT order_id)/COUNT(DISTINCT od.order_date)
FROM order_details od
WHERE od.item_id IS NOT NULL;

-- 8. How many orders made and items sold per day? 
--    Note that this uses CTEs to create the daily stats table, and then manipulates the created table
WITH daily_stats AS (
    SELECT 
        MONTH(order_date) AS order_month_num,
        MONTHNAME(order_date) AS order_month,
        DAY(order_date) AS order_day,
        COUNT(DISTINCT order_id) AS total_orders,
        COUNT(order_details_id) AS total_items_sold
    FROM order_details
    WHERE item_id IS NOT NULL
    GROUP BY MONTH(order_date), MONTHNAME(order_date), DAY(order_date)
)
SELECT order_month,order_day,total_orders,total_items_sold 
FROM daily_stats
UNION ALL
SELECT 
    'January to March' AS order_month,
    'TOTAL' AS order_day,
    SUM(total_orders),
    SUM(total_items_sold)
FROM daily_stats;


