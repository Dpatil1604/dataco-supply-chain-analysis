-- ================================================
-- QUERY 3: Region Profitability Analysis
-- Business Question: Which regions have highest 
-- late delivery and lowest profit?
-- ================================================
-- Concepts Used:
-- AVG()        = average of a column
-- SUM()        = total of a column
-- ::INT        = convert text to number
-- WHERE > 0    = filter only late orders
-- GROUP BY     = group by region
-- ORDER BY DESC = highest profit first
--
-- Thinking Process:
-- Step 1 — Business question: region + delay + profit
-- Step 2 — Columns needed: Order Region, 
--           Delivery Delay, Order Profit Per Order
-- Step 3 — AVG for delay, SUM for profit
-- Step 4 — WHERE to filter only late orders
-- Step 5 — GROUP BY region, ORDER BY profit
--
-- Excel Equivalent:
-- PT2 → Order Region in Rows
-- AVG Delivery Delay + SUM Profit in Values
-- ================================================

SELECT "Order Region",
AVG("Delivery Delay"::INT) AS avg_delay,
SUM("Order Profit Per Order") AS total_profit
FROM supply_chain
WHERE "Delivery Delay"::INT > 0
GROUP BY "Order Region"
ORDER BY total_profit DESC;

-- ================================================
-- OUTPUT:
-- Western Europe  | 1.63 days | 360,640  ← highest
-- Central America | 1.61 days | 354,741
-- South America   | 1.62 days | 184,862
-- ...
-- Central Asia    | 1.68 days |   6,248  ← lowest
--
-- FINDING:
-- Western Europe has highest profit not USA
-- I thought USA would be highest because rich country
-- My assumption was wrong - data does not match assumption
-- Central Asia = highest delay 1.67 days + lowest profit
-- All regions have almost same delay around 1.6 days
--
-- KEY ANALYTICAL INSIGHT:
-- Delay is NOT the main reason for profit difference
-- All regions have same delay so something else is causing
-- profit difference between regions
-- Main reasons are likely discount strategy + order volume
-- This is my own observation from connecting findings
--
-- BUSINESS MEANING:
-- Central Asia has double problem - high delay + low profit
-- Company needs to investigate discount strategy per region
-- Not just delivery operations
-- Delay alone does not explain profit differences
--
-- NEW CONCEPT LEARNED:
-- Always look for multiple reasons not just one
-- One metric never tells the full story
-- Connect findings across queries for deeper insight
-- ================================================