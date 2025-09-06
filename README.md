# New Menu Analysis for Taste of the World Cafe
See associated Tableau dashboard [here.](https://public.tableau.com/app/profile/jon.watford/viz/TasteoftheWorldCafeMenuAnalysis/KPIDashboard)

## Purpose
Client is **Taste of the World Cafe**, a restaurant with diverse menu offerings from domestic and international cuisines. The client debuted a new menu in January 2023.

### Client wants to know:
- Which menu items are doing well/not well?
- What do customers like most/least?
- Are there any patterns in customers' cuisine preferences?
 
## About the Data
This analysis uses transaction data from 5,343 unique orders completed between January 1, 2023 and March 31, 2023. 

#### Key Metrics and Dimensions

- **Units Sold:** Number of units sold 
- **Revenue Generated ($):** Sum of revenue generated 
- **Cuisine:** Type of cuisine the menu item belongs to (American, Asian, Italian, or Mexican)
- **Price Range:** The price category of each menu item (Under $10, $10 or more)

## Findings

### Overall 
- 12,097 items were sold during this 3-month period, generating a total revenue of ~$159k.
- Average revenue per order: $30

### By Item
- **Item with most units sold:** 		Hamburger			(622 units)
- **Item with least units sold:** 		Chicken Tacos 		(123 units)
- **Item generating most revenue:**		Korean Beef Bowl 	($10,555)
- **Item generating least revenue:** 	Chicken Tacos 		($1,470)

### By Cuisine
- **Cuisine with most units sold:** 		Asian	 	(3,470 units)
- **Cuisine with least units sold:** 		American 	(2,734 units)
- **Cuisine generating most revenue:**		Italian 	($49,463)
- **Cuisine generating least revenue:**		American 	($28,238)

## Primary Recommendations

- **Raise the price of edamame from $5 to $7.**
	- ***Rationale:*** Edamame is the best-selling item under $10 (620 units sold) and the second-best selling item overall. However, its revenue generation potential is limited since its current price ($5) is $2 below other sides/appetizers. I recommend raising edamame's price to be in line with other sides and appetizers.
- **Remove chicken tacos from the menu.**  
	- ***Rationale:*** Chicken tacos are the least popular item on the menu (123 units sold), while also generating the least revenue. Customers seeking Mexican food seem to prefer the Chicken Burrito or Chicken Torta. 
- **Develop more Asian and Italian menu items, especially in the $10-$20 range**
	- ***Rationale:*** Items of Asian and Italian cuisines generated the most revenue. All of the top 10 high-revenue orders included at least 3 Italian dishes. The top 10 high-revenue orders also always included at least 10 items that costed over $10. Developing more items from Italian and Asian cuisines will help the Cafe continue to tap into a valuable segment of the customer base. Adding items over $10 helps meet the demand for those items among high-spend orders.  
- **For future analyses, collect data about each item's cost of production to enable a profitability analysis.**
	- ***Rationale:*** Collecting data about cost of each item (i.e., cost of ingredients and time to prepare) would enable better decision-making about whether to adjust item prices or remove items from the menu. The current analysis would have been improved by using data on item profitability instead of data on item revenue.


## Software Toolkit
- Excel
- SQL
- Tableau


# Acknowledgements
The data for this project come from [Maven Analytics](https://mavenanalytics.io/data-playground/restaurant-orders). 
