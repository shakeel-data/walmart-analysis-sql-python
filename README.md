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

![image](https://github.com/user-attachments/assets/60598938-0634-4b27-9094-85da0d78dffd)
```
### 5.  Statistical information
Measures such as mean, median, minimum, maximum, standard deviation, and quartiles were computed to understand the central tendency and spread of each variable.
![image](https://github.com/user-attachments/assets/99293339-0aa8-41e4-b0fe-185eaba54bad)






















































































































