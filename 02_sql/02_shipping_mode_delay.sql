-- ================================================
-- QUERY 2: Shipping Mode Delay Analysis
-- Business Question: Which shipping mode has 
-- the highest late delivery rate?
-- ================================================
-- Concepts Used:
-- COUNT(*) = count total orders per group
-- SUM()    = add up late_delivery_risk (0 or 1)
-- ::INT    = convert text to number (type casting)
-- * 100.0  = convert to percentage
-- ROUND(,2)= keep 2 decimal places
-- GROUP BY = group by shipping mode
-- ORDER BY DESC = highest late % first
--
-- Thinking Process:
-- Step 1: What columns do I need?
--         Shipping Mode + Late_delivery_risk
-- Step 2: What do I want to see?
--         Total orders, late orders, late %
-- Step 3: Build one line at a time
--
-- Excel Equivalent:
-- PT2 → Shipping Mode in Rows
-- COUNT total + COUNT late + late % calculated
-- ================================================

SELECT "Shipping Mode",
COUNT(*) AS total_orders,
SUM("Late_delivery_risk"::INT) AS late_orders,
ROUND(SUM("Late_delivery_risk"::INT) * 100.0 / COUNT(*), 2) AS late_percentage
FROM supply_chain
GROUP BY "Shipping Mode"
ORDER BY late_percentage DESC;

-- ================================================
-- OUTPUT:
-- First Class    | 27,814  | 26,513 | 95.32%
-- Second Class   | 35,216  | 26,987 | 76.63%
-- Same Day       | 9,737   | 4,454  | 45.74%
-- Standard Class | 107,752 | 41,023 | 38.07%
--
-- FINDING:
-- First Class = 95.32% late = WORST performer
-- Surprising because it is most expensive mode
-- Standard Class = 38.07% = BEST performer
-- Despite handling highest volume (107,752 orders)
--
-- Business Meaning:
-- Company failing premium customers the most
-- Customers paying more getting worse service
-- Standard Class more efficient despite 4x volume
--
-- Excel vs SQL lesson:
-- Excel showed Second Class worst by raw count
-- SQL showed First Class worst by percentage
-- Percentage always more accurate than raw count
-- ================================================