-- ================================================
-- QUERY 4: Discount Impact on Profit
-- Business Question: Do higher discounts 
-- reduce profit?
-- ================================================
-- Concepts Used:
-- COUNT(*)     = count total orders per group
-- SUM()        = total profit per bucket
-- AVG()        = average profit per order
-- ::NUMERIC    = convert for ROUND to work
-- ::FLOAT      = convert text to number for AVG
-- ROUND(,2)    = keep 2 decimal places
-- GROUP BY     = group by discount bucket
-- ORDER BY DESC = highest avg profit first
--
-- Thinking Process:
-- Step 1 — Business question: discount vs profit
-- Step 2 — Columns needed: Discount Bucket +
--           Order Profit Per Order
-- Step 3 — SUM for total, AVG for fair comparison
-- Step 4 — COUNT to see order volume per bucket
-- Step 5 — ORDER BY avg profit to see pattern
--
-- Why AVG matters here:
-- HIGH bucket has fewer orders so SUM looks small
-- AVG shows profit per order fairly
-- Same lesson as percentage vs count from Query 2
-- ================================================

SELECT "Discount Bucket",
COUNT(*) AS total_orders,
ROUND(SUM("Order Profit Per Order"::NUMERIC), 2) AS total_profit,
ROUND(AVG("Order Profit Per Order"::FLOAT)::NUMERIC, 2) AS avg_profit_per_order
FROM supply_chain
GROUP BY "Discount Bucket"
ORDER BY avg_profit_per_order DESC;

-- ================================================
-- OUTPUT:
-- LOW    | 90,258 | 2,143,684 | 23.75 avg
-- MEDIUM | 70,203 | 1,454,008 | 20.71 avg
-- HIGH   | 20,058 |   369,209 | 18.41 avg
--
-- FINDING:
-- As discount increases profit decreases consistently
-- HIGH discount attracts customers but reduces profit
-- Medium discount is safer side for company
-- Only 20,058 orders have high discount
-- Company already limiting high discounts
--
-- KEY INSIGHT:
-- High discount = less profit = weaker service quality
-- Bad service = less customers in long term
-- Discount strategy directly affects business health
--
-- BUSINESS MEANING:
-- Limit high discount orders immediately
-- Focus on low discount for sustainable profit
-- Medium discount acceptable but needs monitoring
--
-- NEW CONCEPT LEARNED:
-- AVG hides negative individual orders
-- Always check both AVG and individual level
-- One number never tells complete story
-- ================================================