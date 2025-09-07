Retail Sales Analytics (SQL Project)

## 📌 Overview
This project showcases SQL queries written to analyze retail sales transactions. The dataset contains information on sales, customers, products, categories, and timestamps.

The queries answer key business questions such as:
- What are the top-performing categories and customers?
- How do sales vary by time of day, gender, and month?
- Which customer demographics drive specific product categories?
- What shifts (morning, afternoon, evening) generate the most orders?

  
## 🗂️ Dataset
The dataset (`retail_sales_pract`) includes:
- **sale_date** – Date of transaction  
- **sale_time** – Time of transaction  
- **transactions_id** – Unique transaction identifier  
- **customer_id** – Unique customer identifier  
- **category** – Product category (e.g., Clothing, Beauty, Electronics)  
- **gender** – Customer gender  
- **age** – Customer age  
- **quantity** – Number of items purchased  
- **total_sale** – Total sales amount  

---

## 🔍 Key Queries & Use Cases

 1. Sales on a Specific Date
Retrieve all sales from **2022-11-05**.

SELECT *
FROM retail_sales_pract
WHERE sale_date = '2022-11-05';

2. Bulk Clothing Orders (Nov 2022)
Identify clothing sales where quantity ≥ 4.


SELECT * 
FROM retail_sales_pract
WHERE category = 'clothing' AND quantity >= 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

3. Total Sales by Category

SELECT category, SUM(total_sale) AS sum_of_total_sales
FROM retail_sales_pract
GROUP BY category;

4. Average Age of Beauty Shoppers

SELECT AVG(age) AS average_age_of_customers
FROM retail_sales_pract
WHERE category = 'beauty';

5. High-Value Transactions (>1000)

SELECT *
FROM retail_sales_pract
WHERE total_sale > 1000;

6. Transactions by Gender & Category

SELECT gender, category, COUNT(DISTINCT transactions_id) AS total_number_of_transaction
FROM retail_sales_pract
GROUP BY gender, category;

7. Monthly Average Sales

SELECT 
    YEAR(sale_date) AS year_sale,
    MONTH(sale_date) AS month_sale,
    AVG(total_sale) AS avg_sale
FROM retail_sales_pract
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR(sale_date), avg_sale DESC;

8. Top 5 Customers by Total Purchases

SELECT customer_id, SUM(total_sale) AS total_purchase
FROM retail_sales_pract
GROUP BY customer_id
ORDER BY total_purchase DESC
LIMIT 5;

9. Unique Customers by Category

SELECT category, COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sales_pract
GROUP BY category;

10. Orders by Shift (Morning, Afternoon, Evening)

WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN CAST(sale_time AS TIME) BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
            WHEN CAST(sale_time AS TIME) BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales_pract
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;


INSIGHTS

- Clothing shows bulk purchases during promotions.
- The Beauty category attracts a distinct age demographic.
- Evening hours tend to generate the highest number of orders.
- A small % of high-value transactions contribute significantly to revenue.
- Top 5 customers represent a loyalty opportunity.
