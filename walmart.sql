																--- WALMART SALES ANALYSIS ---


SELECT * FROM walmart
LIMIT 10;

SELECT 
	 payment_method,
	 COUNT(*)
FROM walmart
GROUP BY payment_method

SELECT 
	COUNT(DISTINCT branch) 
FROM walmart;

SELECT MIN(quantity) FROM walmart;

SELECT * FROM walmart;

												--- Identifying and Solving Barriers to Business Success ---
												
																	
-- Q.1 What is the Count of transactions by branch?

SELECT 
	 Branch, 
	 COUNT(*) AS transaction_count
FROM walmart
GROUP BY Branch
ORDER BY transaction_count DESC;

-- Q.2 Find out the different payment method and number of transactions, number of qty sold?

SELECT 
	 Payment_method,
	 COUNT(*) as number_of_payments,
	 SUM(quantity) as number_of_qty_sold
FROM walmart
GROUP BY payment_method;

-- Q.3 Which is the average unit price for each product category?

SELECT 
    category, 
    ROUND(AVG(unit_price)::NUMERIC, 2) AS avg_unit_price
FROM walmart
GROUP BY category;

-- Q.4 What is the top 10 cities with highest total profit margin?

SELECT 
	 city, 
	 ROUND(SUM(profit_margin)::Numeric, 2) AS total_profit
FROM walmart
GROUP BY city
ORDER BY total_profit DESC
LIMIT 10;

-- Q.5 On which day has Highest Total Sales made?

SELECT 
     date, 
     ROUND(SUM(unit_price * quantity)::NUMERIC, 2) AS total_sales
FROM walmart
GROUP BY date
ORDER BY total_sales DESC
LIMIT 1;

-- Q.6 What is the Average quantity sold by category?

SELECT 
	 category, 
	 ROUND(AVG(quantity)::NUMERIC, 2) AS avg_quantity
FROM walmart
GROUP BY category;

-- Q.7 Calculate the Hourly sales distribution?

SELECT 
    EXTRACT(HOUR FROM TO_TIMESTAMP(time, 'HH24:MI:SS')) AS hour, 
    ROUND(SUM(profit_margin)::NUMERIC, 2) AS total_profit
FROM walmart
GROUP BY hour
ORDER BY hour;

-- Q.8 Which is the highest earning branch per city?

SELECT 
	 city, 
	 branch, 
	 ROUND(SUM(profit_margin)::NUMERIC, 2) AS total_profit
FROM walmart
GROUP BY city, branch
ORDER BY city, total_profit DESC;

-- Q.9 Find out the top-selling category per branch?

SELECT 
	 branch, 
	 category, SUM(quantity) AS total_quantity
FROM walmart
GROUP BY branch, category
ORDER BY branch, total_quantity DESC;

-- Q.10 Which transactions are considered high-value, where the sales amount exceeds $500?

SELECT *
FROM walmart
WHERE unit_price * quantity > 500
ORDER BY unit_price * quantity DESC
LIMIT 5;

-- Q.11 Rating vs Profit Correlation (by category)?

SELECT 
	 category, 
	 ROUND(AVG(rating)::NUMERIC, 2) AS avg_rating, 
	 ROUND(AVG(profit_margin)::NUMERIC, 2) AS avg_profit
FROM walmart
GROUP BY category
ORDER BY avg_profit DESC;

-- Q.12 What is the hourly customer footfall for the given period?

SELECT 
     EXTRACT(HOUR FROM time::time) AS hour,
     COUNT(*) AS transactions
FROM walmart
GROUP BY hour
ORDER BY hour;

-- Q.13 Find out the monthly sales trend (based on profit)?

SELECT 
    DATE_TRUNC('month', TO_DATE(date, 'DD/MM/YY')) AS month, 
    ROUND(SUM(profit_margin)::NUMERIC, 2) AS total_profit
FROM walmart
GROUP BY month
ORDER BY month;

-- Q.14 Determine the average, minimum, and maximum rating of category for each city - List the city, average_rating, min_rating, and max_rating?

SELECT 
	city,
	category,
	MIN(rating) as min_rating,
	MAX(rating) as max_rating,
	AVG(rating) as avg_rating
FROM walmart
GROUP BY 1, 2

-- Q. 15 Determine the most common payment method for each Branch?

WITH cte 
AS
(SELECT 
	branch,
	payment_method,
	COUNT(*) as total_trans,
	RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rank
FROM walmart
GROUP BY 1, 2
)
SELECT *
FROM cte
WHERE rank = 1

-- Q.16 Categorize sales into MORNING, AFTERNOON, and EVENING shifts based on time, and count the number of invoices in each shift?

SELECT
	branch,
	CASE 
		WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time,
	COUNT(*)
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC
LIMIT 10


																	--- Conclusion ---






































