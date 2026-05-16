-- ================================================
-- QUERY 7: Window Function — Shipping Mode Ranking
-- Business Question: Rank shipping modes by 
-- late delivery percentage
-- ================================================
-- New Concept: Window Function
--
-- What is Window Function:
-- GROUP BY = groups rows, individual rows disappear
-- Window Function = calculates across rows BUT
-- keeps all individual rows visible
--
-- RANK() OVER(ORDER BY column DESC)
-- RANK()    = assigns rank 1, 2, 3...
-- OVER()    = defines which rows to rank across
-- ORDER BY  = rank by what value
--
-- Important Rule Learned:
-- Cannot use alias inside OVER()
-- Must repeat full formula inside OVER()
-- Because SQL reads OVER() before creating alias
--
-- Excel Equivalent:
-- Adding a RANK column next to your data
-- All rows stay but each row gets rank number
--
-- Thinking Process:
-- Step 1 — calculate late % per shipping mode
-- Step 2 — add rank number based on late %
-- Rank 1 = worst, Rank 4 = best
-- ================================================

SELECT "Shipping Mode",
COUNT(*) AS total_orders,
SUM("Late_delivery_risk"::INT) AS late_orders,
ROUND(SUM("Late_delivery_risk"::INT) * 100.0 / COUNT(*), 2) AS late_percentage,
RANK() OVER(ORDER BY
    ROUND(SUM("Late_delivery_risk"::INT) * 100.0 / COUNT(*), 2)
DESC) AS delay_rank
FROM supply_chain
GROUP BY "Shipping Mode"
ORDER BY delay_rank;

-- ================================================
-- OUTPUT:
-- First Class    | 27,814  | 26,513 | 95.32% | Rank 1
-- Second Class   | 35,216  | 26,987 | 76.63% | Rank 2
-- Same Day       |  9,737  |  4,454 | 45.74% | Rank 3
-- Standard Class | 107,752 | 41,023 | 38.07% | Rank 4
--
-- FINDING:
-- First Class = Rank 1 worst despite being most expensive
-- Standard Class = Rank 4 best despite highest volume
-- Same Day = Rank 3 also decent performance
--
-- KEY INSIGHT:
-- First Class charges premium but delivers worst service
-- Customer trust issue - paying more getting less
-- Standard Class handles most orders but performs best
-- Worth investing more in Standard Class operations
--
-- BUSINESS RECOMMENDATIONS:
-- 1. Fix First Class operations urgently
--    or reconsider premium pricing
-- 2. Invest more in Standard Class
--    already best performer with most volume
-- 3. Small improvement in Standard Class
--    = biggest impact due to high volume
--
-- NEW CONCEPT LEARNED:
-- Window Function keeps all rows visible
-- Unlike GROUP BY which collapses rows
-- RANK() OVER() adds rank without removing rows
-- Cannot use alias inside OVER()
-- Must repeat full calculation inside OVER()
-- ================================================