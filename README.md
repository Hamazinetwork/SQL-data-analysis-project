# SQL-data-analysis-project

## Table of Content
- [Problem Statement](#problem-statement)
- [Data Source](#data-source)
- [Tools Used](#tools-used)
- [Step Taken](#steps-taken)
- [Data Analysis](#data-analysis)
- [Conclusion ](#conclusion)
- [Recommendations ](#recommendations)

### Problem Statement 
This dataset is from Briggs Company, which seeks to identify customer segments and business categories driving its sales. Briggs has three main categories and aims to determine which of these contributes the most to business success. After identifying the top-selling category, the company wants to pinpoint the specific products within its subcategories that are driving sales. Additionally, they are interested in analyzing the trend of top-selling products within each category over the years to inform future strategies.

### Data Source
Data was sourced from a reputable platform, Kaggle.com.

### Tools Used
- Excel Power Query
- SQL Server Management Studio (SSMS)

### Steps Taken
#### Data Cleaning and Transformation
  - Cleaned the data using Excel Power Query by:
      - Verifying column quality, distribution, and profiles to check for errors, distinct, and unique values in each column.
      - Removing unnecessary rows and columns to avoid data redundancy.
      - Applying and saving changes after cleaning.
  - Created a database in SQL SSMS.
  - Imported the dataset into SSMS.
  - Checked data types to confirm proper categorization (e.g., integers, varchar).

### Data Analysis
  - Calculated average delivery days for key cities: Dallas, Los Angeles, Seattle, and Madison.
  ```sql
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
```
- Identified the best customer by selecting the top customer name, category, and total sales.
```sql
SELECT TOP 1 customer_name, 
		category,
		ROUND(SUM(sales),0) [Total Sales]
FROM [Sample-Superstore-Complete]
GROUP BY Customer_Name, 
		 Category
```
- Determined the highest-selling category by analyzing total sales and percentage contribution from each category.
```sql
SELECT  category,
		SUM(Sales) [Total Sales],
		CONCAT(ROUND((SUM(sales) * 100 / (SELECT SUM(sales)
		FROM [Sample-Superstore-Complete])),0), '%') [SalesPercentage]	
FROM [Sample-Superstore-Complete]
Group BY Category
```
- Identified the top subcategory by analyzing sales sums within the best-performing category.
```sql
SELECT Sub_Category,
		ROUND(SUM(sales), 0) [Total Sales]
FROM [Sample-Superstore-Complete]
Group BY Sub_Category
ORDER BY 2 DESC
```
- Analyzed annual sales trends by aggregating sales data by year.
```sql
SELECT 
		YEAR(Ship_Date) [sale year],
		(SUM(sales)) [Total Sales]
FROM [Sample-Superstore-Complete]
WHERE Sub_Category = 'phones'
GROUP BY YEAR(ship_date)
ORDER BY 2 DESC
```

### Conclusion
  - Top Subcategory: Phones led in sales among subcategories, with total sales of 330,007.
  - Top Customer: Clytie Kelly was the highest-grossing customer, with total sales of 607 in the Office Supplies category.
  - Sales Trends: Sales trends reveal irregular patterns, with 2020 showing peak sales, followed by 2019, 2017, and 2018, and 2021 showing a sharp decline. This drop in 2021 may be attributed to the easing of COVID-19 restrictions, which decreased demand for technology products, home furniture, and office appliances as people returned to in-person work. Ongoing supply chain disruptions also impacted product availability and sales.
  - Top Category: Technology was the highest-grossing category.
  - Average Delivery Days: Delivery times to Madison, Seattle, Los Angeles, and Dallas averaged 2 days each.
### Recommendations
  - Prioritize the Technology Category: Since the Technology category, and specifically Phones, lead in sales, the company should allocate more resources and targeted marketing efforts here. Special promotions and bundles in this category could also increase sales.
  - Enhance Customer Loyalty Programs: Reward top customers like Clytie Kelly to boost retention. Consider implementing loyalty or referral programs to encourage repeat purchases and customer advocacy.
  - Explore Hybrid Work Products: Given shifts in work environments, the company should explore products catering to hybrid work setups, such as ergonomic furniture, mobile devices, and accessories suitable for both office and home use.
  - Optimize Supply Chain & Inventory: Data shows that supply chain disruptions affected 2021 sales. Proactively monitoring inventory and identifying alternative suppliers can help reduce dependency and improve stock availability for high-demand items
  - Improve Delivery Time & Reliability: Speed up delivery times, if possible, to exceed customer expectations. Faster deliveries often lead to higher customer satisfaction and can increase the likelihood of repeat purchases and referrals.
  - Expand Digital Marketing & Personalization: Use data insights to target specific customer segments with tailored promotions, particularly focusing on hybrid workers or students. Digital campaigns can boost engagement by advertising relevant products based on customer purchasing behavior and category trends.
  - Monitor Trends for Strategic Adaptation: Regularly assess new trends and customer preferences. By keeping an eye on changes in market demand, Briggs can adapt its inventory, marketing strategies, and customer service approaches in response to evolving customer needs and external factors.
