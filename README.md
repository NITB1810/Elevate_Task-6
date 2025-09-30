# 📊 **Task 6 – SQL Time-Series Data Analysis**

## 📌 **Overview**
This task focuses on time-series sales analysis using the Olist Brazilian E-Commerce Dataset.  
We write SQL queries in MySQL Workbench to analyze monthly revenue and order volume trends.

---

## 📂 **Dataset**
We use the Olist Brazilian E-Commerce Dataset (from Kaggle).  
It contains the following 9 tables:

- customers  
- orders  
- products  
- sellers  
- order_items  
- order_payments  
- order_reviews  
- geolocation  
- product_category_name_translation  

---

## 📌 **Tables Used for This Task**
For this analysis, we mainly use:  
- orders → `order_purchase_timestamp` (order date)  
- order_payments → `payment_value` (revenue)  

---

## 📝 **Analysis Tasks (10 SQL Queries)**

1. Monthly Revenue – `SUM(payment_value)` grouped by month  
2. Monthly Order Volume – `COUNT(DISTINCT order_id)` grouped by month  
3. Monthly Revenue & Orders Together – combine SUM + COUNT  
4. Monthly Average Order Value (AOV) – `SUM / COUNT` per month  
5. Revenue Trend for Specific Year (2017)  
6. Last 6 Months Revenue Trend  
7. Quarterly Revenue Analysis  
8. Monthly Revenue by Payment Type  
9. Monthly Orders by Customer State (with customers join)  
10. Best Month by Revenue in Each Year  

---

## 🚀 **Outcome**
- Learned to use `EXTRACT(YEAR/MONTH)`, `SUM()`, `COUNT(DISTINCT)`, `GROUP BY`, `ORDER BY`, and `LIMIT`.  
- Analyzed monthly sales patterns, order volumes, and seasonal trends.  
- Built a foundation for business reporting & forecasting using SQL.
