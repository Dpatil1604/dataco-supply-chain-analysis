-- ================================================
-- QUERY 6: CTE — Double Trouble Regions
-- Business Question: Which regions have BOTH
-- high delay AND low profit simultaneously?
-- ================================================
-- New Concept: CTE (Common Table Expression)
-- 
-- What is CTE:
-- Normal query = one question one answer
-- CTE = save first answer temporarily
--       then ask second question on top of it
--
-- Why CTE needed here:
-- WHERE cannot filter on AVG or SUM directly
-- CTE calculates AVG and SUM first
-- Then we filter on those calculated values
--
-- Think of it like Excel:
-- Make pivot table first
-- Then filter that pivot table further
-- Same logic in SQL using CTE
--
-- Syntax:
-- WITH cte_name AS (
--     first query here
-- )
-- SELECT * FROM cte_name
-- WHERE condition;
--
-- Thinking Process:
-- Step 1 — Find all regions with avg delay + total profit
-- Step 2 — From that result filter double trouble zones
-- Cutoff: avg_delay > 0.6 AND total_profit < 50,000
-- ================================================

WITH regions AS (
    SELECT "Order Region",
    AVG("Delivery Delay"::INT) AS avg_delay,
    SUM("Order Profit Per Order"::NUMERIC) AS total_profit
    FROM supply_chain
    GROUP BY "Order Region"
)
SELECT *
FROM regions
WHERE avg_delay > 0.6 AND total_profit < 50000
ORDER BY total_profit ASC;

-- ================================================
-- OUTPUT:
-- Central Asia   | 0.6455 delay | 13,045 profit
-- Central Africa | 0.6398 delay | 33,447 profit
--
-- FINDING:
-- Only 2 regions qualify as double trouble zones
-- Central Asia = worst — highest delay + lowest profit
-- Central Africa = second worst
--
-- WHY THESE REGIONS:
-- Both are remote locations
-- Remote = longer travel distance
-- Longer distance = higher shipping cost
-- Higher cost = lower profit margin
-- Also = more chances of delay
--
-- BUSINESS MEANING:
-- Central Asia needs most urgent attention
-- Review shipping routes and pricing strategy
-- Consider whether these markets are worth serving
-- at current cost structure
--
-- NEW CONCEPT LEARNED:
-- CTE = Common Table Expression
-- Used when WHERE cannot filter on aggregates
-- Makes complex queries simple and readable
-- WITH cte_name AS () → SELECT FROM cte_name
-- ================================================