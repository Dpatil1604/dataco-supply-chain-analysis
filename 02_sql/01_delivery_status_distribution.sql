-- ================================================
-- QUERY 1: Delivery Status Distribution
-- Business Question: Which delivery status appears most?
-- ================================================
-- Concepts: SELECT, COUNT(*), GROUP BY, ORDER BY DESC
-- Excel Equivalent: Pivot Table → Delivery Status 
-- in Rows → COUNT in Values → sorted High to Low
-- ================================================

SELECT "Delivery Status",
COUNT(*) AS total_orders
FROM supply_chain
GROUP BY "Delivery Status"
ORDER BY total_orders DESC;

-- ================================================
-- OUTPUT:

--   | Delivery Status    | order_count
--   | text               | bigint
-- ------------------------------------
-- 1 | Late delivery      | 98977
-- 2 | Advance shipping   | 41592
-- 3 | Shipping on time   | 32196
-- 4 | Shipping canceled  |  7754

--
-- FINDING:
-- Late Delivery = 98,977 orders = 54.8% of all orders
-- More than HALF of all orders are delivered late
-- This is a serious operational problem for the business
-- Advance Shipping = 41,592 (23%)
-- Shipping On Time = 32,196 (17.8%)
-- Shipping Canceled = 7,754 (4.3%)
-- 
-- Business Meaning:
-- Only 17.8% of orders arrive on time
-- Company has a major delivery performance problem
-- ================================================