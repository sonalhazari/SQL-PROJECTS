                    #PROJECT
# PROJECT GOAL:
# Analyze customer purchasing behavior, identify high-value customers,
# and generate actionable business insights for revenue growth.
			#STEP 1: Data Understanding + Basic Analysis
#combining tables + adding new row
SELECT 
	c.name, 
    p.product_name, 
    o.quantity, 
    p.price, 
    (o.quantity*p.price) AS order_value
FROM customers c 
LEFT JOIN orders o 
ON c.customer_id=o.customer_id
LEFT JOIN products p 
ON o.product_id=p.product_id;
#Total orders per customer
SELECT 
	c.name, 
    COUNT(o.order_id) AS total_orders 
FROM customers c 
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.name;
#Total sales per customer/customers ranked by sales(leaderboard)
#(full ranked list -> for reporting)
SELECT
	c.name,
COALESCE(SUM(o.quantity * p.price), 0) AS total_sales
FROM customers c 
LEFT JOIN orders o
ON c.customer_id=o.customer_id
LEFT JOIN products p
ON o.product_id=p.product_id
GROUP BY c.name
ORDER BY total_sales DESC;
# INSIGHT : Top 20% customers generate majority revenue.
#Top performing customer(single answer -> for KPI / quick insight)
SELECT
	c.name,
COALESCE(SUM(o.quantity * p.price), 0) AS total_sales
FROM customers c 
LEFT JOIN orders o
ON c.customer_id=o.customer_id
LEFT JOIN products p
ON o.product_id=p.product_id
GROUP BY c.name
ORDER BY total_sales DESC
LIMIT 1;
# INSIGHT: Top customer contributes significantly to revenue -> should be treated as a high-value/VIP customer.

#Customers with NO orders(Why? Shows real business awareness)
SELECT 
	c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;
# INSIGHT: Customers with no orders represent untapped potential -> targeted campaigns can improve conversion rates.

#Per customer Average Order Value
SELECT 
    c.name,
    COALESCE(SUM(o.quantity * p.price) / NULLIF(COUNT(o.order_id), 0), 0) AS avg_order_value
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN products p
ON o.product_id = p.product_id
GROUP BY c.name;
# INSIGHT: Customers above overall AOV are premium buyers -> upsell targets.

#Overall Business Average Order Value (benchmark)
SELECT 
    COALESCE(SUM(o.quantity * p.price) / NULLIF(COUNT(o.order_id), 0), 0) 
    AS overall_avg_order_value
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id;
#INSIGHT: This is the benchmark — compare individual customer AOV against this number.


#STEP 2:CASE WHEN(customer segmentation)&Real business insights
#Task 1 — Spending Segmentation- Label each customer:
SELECT 
	c.name, 
	COALESCE(SUM(o.quantity * p.price), 0) AS total_sales,
CASE WHEN COALESCE(SUM(o.quantity * p.price), 0)>=15000 THEN 'High Spender' 
	 WHEN COALESCE(SUM(o.quantity * p.price), 0)>=10000 THEN 'Medium Spender' 
	 ELSE 'Low Spender' 
END AS spending_status 
FROM customers c 
LEFT JOIN orders o 
ON c.customer_id=o.customer_id 
LEFT JOIN products p 
ON o.product_id=p.product_id 
GROUP BY c.name;
#INSIGHT: 8 out of 20 customers (40%) fall into Low/Medium spending 
#segments -> significant scope to increase revenue through upselling 
#and targeted campaigns. 60% are already High Spenders indicating 
#a strong customer base — focus on retaining them with loyalty programs.

#Task 2- Frequency Segmentation
SELECT 
	c.name, 
	COUNT(o.order_id) AS total_orders,
CASE 
	WHEN COUNT(o.order_id)=0 THEN 'Inactive'
	WHEN COUNT(o.order_id)=1 THEN 'New'
	WHEN COUNT(o.order_id)=2 THEN 'Returning'
	WHEN COUNT(o.order_id)>=3 THEN 'Loyal'
	ELSE 'Unknown'
END AS order_frequency
FROM customers c 
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.name;
# INSIGHT: 17 out of 20 customers (85%) are Loyal -> exceptionally strong retention rate. Only 1 New customer (5%) and 2 Returning (10%)
#suggest the existing base is highly engaged. 
#Focus should be on acquiring new customers rather than retention, as current customer loyalty is already very strong.

#Task 3 — City wise total sales-Which city generates most revenue?
SELECT c.city, COALESCE(SUM(o.quantity * p.price), 0) AS total_sales 
FROM customers c 
LEFT JOIN orders o 
ON c.customer_id=o.customer_id
LEFT JOIN products p
ON o.product_id=p.product_id
GROUP BY c.city
ORDER BY total_sales DESC;
# INSIGHT 1: SOUTH is the highest revenue-generating city (~31.78% contribution) -> key market for retention and expansion.
# INSIGHT 2: EAST has the lowest revenue -> indicates potential issues in customer acquisition or engagement.
# INSIGHT 3: Significant revenue gap across cities suggests uneven market penetration.
# INSIGHT 4: WEST and NORTH show moderate performance -> strong opportunity for upselling and targeted marketing.

#Task 4 — Best selling product category
SELECT p.category, COUNT(o.order_id) AS total_orders 
FROM orders o 
LEFT JOIN products p
ON o.product_id=p.product_id
GROUP BY p.category
ORDER BY total_orders DESC
LIMIT 1;
# INSIGHT: Home category has the highest demand -> prioritize inventory, marketing, and product expansion in this segment.

#Task 5 — Most popular product
SELECT p.product_name, COUNT(o.order_id) AS total_orders 
FROM orders o 
LEFT JOIN products p
ON o.product_id=p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC
LIMIT 1;
# INSIGHT: Product 3 drives the highest number of orders -> can be used for promotions, bundling, or cross-selling.

#Task 6 - Revenue by product category
SELECT 
    p.category,
COALESCE(SUM(o.quantity * p.price), 0) AS total_sales
FROM orders o
LEFT JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;
# INSIGHT: Revenue is concentrated in specific categories -> focusing on these can maximize ROI and profitability.
#task 7 - Quantity Segmentation
SELECT 
    c.name,
	COALESCE(SUM(o.quantity), 0) AS total_quantity,    
    CASE 
        WHEN COALESCE(SUM(o.quantity), 0) >= 10 THEN 'Bulk Buyer'
        WHEN COALESCE(SUM(o.quantity), 0) >= 5 THEN 'Regular Buyer'
        ELSE 'Light Buyer'
    END AS buyer_type
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.name;
# INSIGHT: Bulk buyers contribute significantly to volume -> offering discounts on large quantities can further boost sales.

#Task 8- Loyalty & Frequency
SELECT 
    c.name,
    COALESCE(SUM(o.quantity * p.price), 0) AS total_sales,
    COUNT(o.order_id) AS total_orders,
    CASE 
    WHEN COALESCE(SUM(o.quantity * p.price), 0)>=15000 
    AND COUNT(o.order_id) >=3 THEN 'High Value & Loyal'
    WHEN COALESCE(SUM(o.quantity * p.price), 0)>=15000 THEN 'High Value but Infrequent'
    ELSE 'Regular'
END AS customer_type
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
LEFT JOIN products p 
ON o.product_id = p.product_id
GROUP BY c.name;
# INSIGHT: High Value & Loyal -> Reward them — loyalty program, exclusive offers. 
#High Value but Infrequent -> Re-engage them — why aren't they coming back? Special discount to bring them back.
#Regular -> Nurture them — upsell campaigns to move them up.


# FINAL BUSINESS SUMMARY:
# - Revenue is driven by a small group of high-value customers.
# - Customer retention is exceptionally strong (85% Loyal customers) -> focus should shift to new customer acquisition.
# - Certain cities and product categories dominate sales.
# - Business should focus on:
#     1. Retaining high-value customers
#     2. Improving low-performing regions
#     3. Increasing repeat purchases

# TOOLS USED:
# - SQL (Joins, Aggregations, CASE WHEN)
# - Business Analysis (Customer Segmentation, Revenue Analysis)

# KEY SKILLS DEMONSTRATED:
# - Data Cleaning & Joining
# - Customer Segmentation
# - KPI Analysis
# - Business Insight Generation