--Superstore
Select * 
from [dbo].[Sample-Superstore-Complete]

--Average Delivery Days to Dallas, Los Angeles, seattle and mandison
ALTER TABLE [sample-superstore-complete]
ADD Ship_days INT

UPDATE  [sample-superstore-complete]
 SET Ship_days =
	CASE 
	WHEN ship_mode = 'Same Day' THEN 1
	WHEN ship_mode = 'First Class' THEN 2
	WHEN ship_mode = 'Second Class' THEN 3
	WHEN ship_mode = 'Standard Class' THEN 4
	END;
	SELECT  City,
			AVG(DAY(DATEADD(day,ship_days, Ship_Date)))[Average Delivery day]
FROM [sample-superstore-complete]
WHERE city in ('Dallas','Los Angeles', 'Seattle','madison')
GROUP BY City

--  Another angle
--Customer that made the highest sales ever rounded to nearest whole number
--customer name, categories and total sales(sales * quantity)-discount
SELECT TOP 1 customer_name, 
		category,
		ROUND(SUM(sales),0) [Total Sales]
FROM [Sample-Superstore-Complete]
GROUP BY Customer_Name, 
		 Category
--3 Categories generating Revenue
--show total sales and percentage contributed by each categories  
SELECT  category,
		SUM(Sales) [Total Sales],
		CONCAT(ROUND((SUM(sales) * 100 / (SELECT SUM(sales)
		FROM [Sample-Superstore-Complete])),0), '%') [SalesPercentage]	
FROM [Sample-Superstore-Complete]
Group BY Category


 --4 Subcategories
 SELECT Sub_Category,
		ROUND(SUM(sales), 0) [Total Sales]
FROM [Sample-Superstore-Complete]
Group BY Sub_Category
ORDER BY 2 DESC

--5. PHONES
SELECT 
		YEAR(Ship_Date) [sale year],
		(SUM(sales)) [Total Sales]
FROM [Sample-Superstore-Complete]
WHERE Sub_Category = 'phones'
GROUP BY YEAR(ship_date)
ORDER BY 2 DESC
