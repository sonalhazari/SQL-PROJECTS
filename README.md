# 🛒 Customer Sales Analysis (SQL Project)

## 📌 Project Overview

This project analyzes customer purchasing behavior using SQL to uncover revenue patterns, customer segments, and growth opportunities.

The objective is to identify high-value customers, evaluate sales performance across cities and product categories, and generate actionable business insights to support strategic decision-making.

---

## 🎯 Project Objectives

- Analyze total revenue and order behavior
- Identify top-performing customers
- Segment customers based on spending and purchase frequency
- Evaluate city-wise and category-wise sales performance
- Generate data-driven insights for business growth

---

## 📊 Dataset Description

The dataset consists of three relational tables:

*customers* -> Customer information (name, city)
*orders* -> Transaction details (order_id, quantity, product_id)
*products* -> Product details (price, category)

These tables were joined using foreign keys to perform revenue and segmentation analysis.

---

## 🛠️ Tools & Technologies
- SQL (MySQL)
- MySQL Workbench
- Microsoft Excel (Dashboard & Visualizations)
- GitHub (Project Documentation & Portfolio Showcase)

---

## 🧠 Key SQL Concepts Used
- LEFT JOIN (Data Combination)
- Aggregation Functions (SUM, COUNT)
- GROUP BY & ORDER BY
- CASE WHEN (Customer Segmentation)
- COALESCE (Handling NULL values)
- Subqueries
- Business KPI Calculations

---

## 📊 Key Business Questions Solved

1. Who are the top customers by revenue?
2. Which city generates the highest sales?
3. Which product category drives maximum revenue?
4. How are customers segmented by spending behavior?
5. How to identify loyal, active and inactive customers?

---

## 📈 Dashboard

![Customer Sales Dashboard - Overview](dashboard.png)
![Customer Sales Dashboard - Charts](dashboard.png)

---

### 💡 Key Insights from Analysis
📌 Business KPIs
- Total Revenue: ₹ 3,35,100
- Total Orders: 100
- Total Customers: 20
- Average Order Value: ₹ 3,351
- Top Customer Revenue: ₹ 36,000

---

### 📌 Revenue Insights
- SOUTH is the highest revenue-generating city (~31.78% contribution)
- Revenue is heavily concentrated in the Home product category
- Top 5 customers contribute a significant portion of total revenue
- 60% of customers belong to the High Spender segment, indicating strong revenue concentration among premium buyers, retention and loyalty strategies should         prioritize this segment
- High Value & Loyal customers represent the most strategic segment for retention and relationship management

---

## 📌 Final Business Summary
- Revenue is strongly driven by high-spending customers
- Customer retention strategies are critical for sustaining growth.
- Sales performance varies significantly across cities, indicating uneven market penetration
- Business should focus on:
  - Retaining high-value customers
  - Strengthening low-performing regions
  - Increasing repeat purchases and customer lifetime value
---

## 🚀 Future Improvements

* Add Power BI dashboard for interactive visualization
* Perform cohort analysis
* Automate reporting with scheduled queries
---
