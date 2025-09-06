# Objective 1: Explore the Menu Items Table

-- 1. View details about menu_items dataset, including # of columns, column names, and column datatypes
SELECT COLUMN_NAME,DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'menu_items'

-- 2. Examine the menu items table.
SELECT  menu_item_id,
		item_name,
		category,
		price 
FROM menu_items mi ;

-- 3. How many items are on the menu? (32 items)
SELECT COUNT(menu_item_id) AS total_menu_items 
FROM menu_items mi ;

-- 4. What are the most expensive and least expensive items on the menu?
(SELECT item_name, 
		price 
FROM menu_items mi 
ORDER BY price 
LIMIT 1) -- get least expensive item
UNION ALL
(SELECT item_name, 
			price 
FROM  menu_items mi 
ORDER BY price DESC 
LIMIT 1); -- get most expensive item

	--  Summary: menu item prices range from $5 to $19.95. The least expensive menu item is edamame ($5); the most expensive item is shrimp scampi ($19.95)

-- 5. How many dishes of each cuisine type are on the menu? What is the average dish price in each category?
SELECT  category AS cuisine, 
	 	COUNT(menu_item_id) AS total_items,
	 	AVG(price) AS avg_item_price 
FROM menu_items mi 
GROUP BY category;


-- 6. What is the most expensive dish in each category/cuisine?
(SELECT category, item_name, price 
	FROM  menu_items mi 
	WHERE mi.category ='American'
	ORDER BY price DESC 
	LIMIT 1) -- get most expensive American item
UNION ALL
	(SELECT category, item_name, price FROM  menu_items mi 
	WHERE mi.category ='Asian'
	ORDER BY price DESC 
	LIMIT 1) -- get most expensive Asian item
UNION ALL
	(SELECT category, item_name, price FROM  menu_items mi 
	WHERE mi.category ='Italian'
	ORDER BY price DESC 
	LIMIT 1) -- get most expensive Italian item
UNION ALL
	(SELECT category, item_name, price FROM  menu_items mi 
	WHERE mi.category ='Mexican'
	ORDER BY price DESC 
	LIMIT 1); -- get most expensive Mexican item