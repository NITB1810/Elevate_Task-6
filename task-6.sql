
USE olist;

-- Monthly Revenue
SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS total_revenue
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;

-- Monthly Order Volume
SELECT 
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY year, month
ORDER BY year, month;

-- Monthly Revenue & Order Volume Together
SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;

-- Monthly Average Order Value (AOV)
SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;

 -- Revenue Trend for 2017 Only
SELECT 
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS total_revenue
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
GROUP BY month
ORDER BY month;

-- Last 6 Months Revenue
SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS total_revenue
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year DESC, month DESC
LIMIT 6;

-- Quarterly Revenue
SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    QUARTER(o.order_purchase_timestamp) AS quarter,
    SUM(p.payment_value) AS total_revenue
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY year, quarter
ORDER BY year, quarter;

-- Monthly Revenue by Payment Type
SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    p.payment_type,
    SUM(p.payment_value) AS total_revenue
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
GROUP BY year, month, p.payment_type
ORDER BY year, month;

-- Monthly Orders by Customer State
SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY year, month, c.customer_state
ORDER BY year, month, total_orders DESC;

-- Best Month by Revenue Each Year
SELECT year, month, total_revenue
FROM (
    SELECT 
        EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
        EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
        SUM(p.payment_value) AS total_revenue,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp)
                     ORDER BY SUM(p.payment_value) DESC) AS rn
    FROM orders o
    JOIN order_payments p ON o.order_id = p.order_id
    GROUP BY year, month
) ranked
WHERE rn = 1;