-- ================================================
-- QUERY 5: Top 10 Loss Making Products
-- Business Question: Which products lose 
-- the most money?
-- ================================================
-- Concepts Used:
-- COUNT(*)     = total orders per product
-- SUM()        = total profit per product
-- AVG()        = average profit per order
-- ::NUMERIC    = for ROUND to work
-- ::FLOAT      = convert text to number
-- ROUND(,2)    = 2 decimal places
-- GROUP BY     = group by product name
-- ORDER BY ASC = lowest profit first
-- LIMIT 10     = show only top 10 results
--
-- Thinking Process:
-- Step 1 — Which products lose most money?
-- Step 2 — Columns: Product Name + 
--           Order Profit Per Order
-- Step 3 — SUM for total loss, AVG for per order loss
-- Step 4 — ORDER BY ASC to get worst first
-- Step 5 — LIMIT 10 to get only top 10
-- ================================================

SELECT "Product Name",
COUNT(*) AS total_orders,
ROUND(SUM("Order Profit Per Order"::NUMERIC), 2) AS total_profit,
ROUND(AVG("Order Profit Per Order"::FLOAT)::NUMERIC, 2) AS avg_profit_per_order
FROM supply_chain
GROUP BY "Product Name"
ORDER BY avg_profit_per_order ASC
LIMIT 10;

-- ================================================
-- OUTPUT:
-- SOLE E35 Elliptical         | 15  | -965.12 | -64.34
-- Bushnell Pro X7 Rangefinder | 11  | -255.95 | -23.27
-- SOLE E25 Elliptical         | 10  | -169.56 | -16.96
-- CDs of rock                 | 271 |  383.85 |   1.42
-- Toys                        | 529 |  900.71 |   1.70
-- Sports Books                | 405 |  883.01 |   2.18
-- Clicgear 8.0 Shoe Brush     | 285 |  815.54 |   2.86
-- Fighting video games        | 838 | 2717.52 |   3.24
-- Hirzl Women's Golf Glove    | 311 | 1193.24 |   3.84
-- Hirzl Men's Golf Glove      | 282 | 1175.66 |   4.17
--
-- FINDING:
-- SOLE E35 loses 64.34 on every single order
-- Both SOLE elliptical products are top loss makers
-- Same brand same category both unprofitable
-- Entire elliptical product line needs review
--
-- BUSINESS RECOMMENDATIONS:
-- 1. Improve service quality for SOLE products
-- 2. Improve quality or reduce price
-- 3. Stop creating new elliptical versions
-- 4. Remove or reprice SOLE E25 and E35
-- 5. Review discount strategy on loss products
--
-- NEW CONCEPT LEARNED:
-- LIMIT = show only top N results
-- ORDER BY ASC = lowest first for worst performers
-- Negative AVG = company loses money every sale
-- Always check both total and average together
-- ================================================