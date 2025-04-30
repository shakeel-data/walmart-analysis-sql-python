# walmart-analysis-sql-python
Walmart, as the world’s largest retail corporation, plays a crucial role in shaping global retail trends and consumer behavior. With an extensive network of stores and a massive volume of daily transactions, Walmart sets the standard for operational efficiency, pricing strategy, and supply chain management in the retail sector. Analyzing Walmart’s sales data provides valuable insights into real-world retail dynamics, helping uncover patterns in customer preferences, regional performance, and product demand. Such analysis is essential for making informed, data-driven decisions that can improve sales, streamline operations, and drive business growth in the competitive retail landscape.

## 📘 Project Overview
This project is an end-to-end data analysis solution designed to extract critical business insights from Walmart sales data. We utilize Python for data processing and analysis, SQL for advanced querying, and structured problem-solving techniques to solve key business questions. The project is ideal for data analysts looking to develop skills in data manipulation, SQL querying, and data pipeline creation.

## 🎯 Objectives
- Understand transaction patterns across branches and cities
- Identify low-performing areas, product categories, and payment methods
- Generate insights to improve sales strategy and customer targeting
- Showcase a practical application of SQL and Python in solving real-world business problems

## 📂 Dataset used
- Kaggle
  <a href="https://github.com/shakeel-data/walmart-analysis-sql-python/blob/main/Walmart.csv">csv</a>
- Clean Data
  <a href="https://github.com/shakeel-data/walmart-analysis-sql-python/blob/main/Walmart_clean_data.csv">cleancsv</a>
- Python
  <a href="">codes</a>
- SQL
  <a href="">queries </a>

## 🔄 Project Workflow
### 1. Set Up Kaggle API
   - **API Setup**: Obtain your Kaggle API token from [Kaggle](https://www.kaggle.com/) by navigating to your profile settings and downloading the JSON file.
   - **Configure Kaggle**: 
      - Place the downloaded `kaggle.json` file in your local `.kaggle` folder.
      - Use the command `kaggle datasets download -d <dataset-path>` to pull datasets directly into your project.

### 2. Download Walmart Sales Data
   - **Data Source**: Use the Kaggle API to download the Walmart sales datasets from Kaggle.
   - **Dataset Link**: [Walmart Sales Dataset](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets)
   - **Storage**: Save the data in the `data/` folder for easy reference and access.
    
### 3. Installing & Importing Dependencies 
Set up the environment by installing and importing key Python libraries such as Pandas, NumPy, Matplotlib, and Seaborn.

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

#mysql toolkit
import pymysql #this will work as adapter
from sqlalchemy import create_engine

#psql
import psycopg2
```
### 4. Loading & Understanding the Dataset
Imported the CSV file and reviewed basic structure, column names, and sample records to understand the data content.

```python
df = pd.read_csv('walmart-10k-sales-datasets/Walmart.csv', encoding_errors='ignore')
df.head()
```
![image](https://github.com/user-attachments/assets/11750e0f-80c3-45cb-9d20-e854f8806745)

### 5.  Statistical information
Measures such as mean, median, minimum, maximum, standard deviation, and quartiles were computed to understand the central tendency and spread of each variable.

![image](https://github.com/user-attachments/assets/99293339-0aa8-41e4-b0fe-185eaba54bad)

### 6. Datatype 
Knowing the data types early on is essential for selecting the right transformations, visualizations, and models later in the workflow.

```python
df.info()
```
![image](https://github.com/user-attachments/assets/aea099b4-4f91-4b78-a2c4-d876e7b10789)


### 7. Data Cleaning, Preparation and Export
Verified and handled missing values, formatted columns, and prepared data for analysis using encoding techniques.

```python
# Check for missing values
df.duplicated().sum()
```

```python
# Drop duplicates
df.drop_duplicates(inplace=True)
df.duplicated().sum()
```

```python
# Check null values
df.isnull().sum()
```
![image](https://github.com/user-attachments/assets/ff60cc40-c1f6-496f-af88-18214eb20c3e)

#### Dropping null values
```python
df.dropna(inplace=True)

# Verify
df.isnull().sum()
```
![image](https://github.com/user-attachments/assets/fcbb445b-61e7-462d-bd3c-dfa20ffe22ab)

#### Coverting unit price into float after removing $(dollar) sign
```python
df['unit_price'] = df['unit_price'].str.replace('$', '').astype(float)
df.head()
```
![image](https://github.com/user-attachments/assets/29fcf30c-7d51-41fc-83ee-153debdc9e74)


#### Add a new column 'total'

```python
df['total'] = df['unit_price'] * df['quantity']
df.head()
```
![image](https://github.com/user-attachments/assets/17ab31b7-e943-4458-9422-3dc16a8b161b)

#### Exporting clean data

```python
df.to_csv('Walmart_clean_data.csv', index=False)
df.shape
```

### 8. Database Integration
Imported into PostgreSQL using pgAdmin

```python
#psql connection
# "mysql+pymysql://user:password@localhost:3306/db_name"
engine_psql = create_engine("postgresql+psycopg2://postgres:pass@localhost:5432/walmart_db")

try:
    engine_psql
    print("Successfully connected to postgresql")
except:
    print("Unable to connect postgresql")

df.to_sql(name='walmart', con=engine_psql, if_exists='replace', index=False)
```

##  Walmart Sales Analysis using SQL queries

```sql
SELECT * FROM walmart
LIMIT 10;
```
![image](https://github.com/user-attachments/assets/b301b102-112c-4c11-8694-5ad23a1ac676)

```sql
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
```

### Data Exploration & Key Outcomes
To extract actionable insights, the following SQL statements were executed in response to targeted business questions.

Q.1 What is the Count of transactions by branch?

```sql
SELECT 
	 Branch, 
	 COUNT(*) AS transaction_count
FROM walmart
GROUP BY Branch
ORDER BY transaction_count DESC;
```

Q.2 Find out the different payment method and number of transactions, number of quantity sold?

```sql
SELECT 
	 Payment_method,
	 COUNT(*) as number_of_payments,
	 SUM(quantity) as number_of_qty_sold
FROM walmart
GROUP BY payment_method;
```

Q.3 Which is the average unit price for each product category?

```sql
SELECT 
    category, 
    ROUND(AVG(unit_price)::NUMERIC, 2) AS avg_unit_price
FROM walmart
GROUP BY category;
```

-- Q.4 What is the top 10 cities with highest total profit margin?

```sql
SELECT 
	 city, 
	 ROUND(SUM(profit_margin)::Numeric, 2) AS total_profit
FROM walmart
GROUP BY city
ORDER BY total_profit DESC
LIMIT 10;
```
![image](https://github.com/user-attachments/assets/558e7b12-caac-436a-847c-d4cda8f6167f)

-- Q.5 On which day has Highest total sales made?

```sql
SELECT 
     date, 
     ROUND(SUM(unit_price * quantity)::NUMERIC, 2) AS total_sales
FROM walmart
GROUP BY date
ORDER BY total_sales DESC
LIMIT 1;
```

Q.6 What is the Average quantity sold by category?

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


																	--- Conclusion ---

















































































































