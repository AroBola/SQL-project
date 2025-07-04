--Write a query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales_pract
WHERE sale_date = '2022-11-05'


--Write a query to retrieve all transactions where the category is 'Clothing', quantity is greater than 4 purchased in the month of Nov 2022
SELECT * 
FROM retail_sales_pract
WHERE category = 'clothing' AND quantiy >= 4 
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'


--Write a query to calculate the total sales for each category
SELECT
	category,
	SUM(total_sale) AS sum_of_total_sales
FROM retail_sales_pract
GROUP BY category


--Write a query to find the average age of customers who purchased iteams from the beauty category
SELECT
	category, 
	AVG (age) AS average_age_of_customers
FROM retail_sales_pract
GROUP BY  category
HAVING category = 'beauty'


--Write a query to find the total number of transactions where total sales is greater than 1000
SELECT *
FROM retail_sales_pract
WHERE total_sale > 1000


--Write a query to find the total number of transactions made by each gender in each category
SELECT
	COUNT(DISTINCT transactions_id) AS total_number_of_transaction,
	gender,
	category
FROM retail_sales_pract
GROUP BY gender, category


--Write a query to calculate the average sales for each month
SELECT 
	YEAR(sale_date) AS year_sale,
	MONTH(sale_date) AS month_sale,
	AVG(total_sale) AS avg_sale
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR(sale_date), avg_sale DESC


--Write a query to find the top 5 customers based on the highest sales
SELECT
	customer_id,
	SUM(total_sale) AS total_purchase
FROM retail_sales_pract
GROUP BY customer_id
ORDER BY total_purchase DESC
LIMIT 5


--Write a query to find the number of unique customers who purchased items from each category
SELECT COUNT (DISTINCT customer_id) AS unique_customer, 
		category
FROM retail_sales_pract
GROUP BY category


--Write a query to create each shift and number of orders 

WITH hourly_sales
AS
(
SELECT *,
	CASE
		WHEN CAST(sale_time AS TIME) BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
		WHEN CAST(sale_time AS TIME) BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales_pract 
)
SELECT
	shift,
	COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift