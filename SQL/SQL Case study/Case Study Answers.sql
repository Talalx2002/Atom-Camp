-- Case Study Questions

-- 1. How many customers has Foodie-Fi ever had?

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS TOTAL_NUMBER_OF_CUSTOMERS FROM SUBSCRIPTIONS ;

-- 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start
-- of the month as the group by value

SELECT DATE_FORMAT(start_date, '%Y-%m-01') AS start_of_month, COUNT(*) AS trials_started
FROM subscriptions
WHERE plan_id IN (
    SELECT plan_id 
    FROM plans 
    WHERE plan_name = 'trial'
)
GROUP BY DATE_FORMAT(start_date, '%Y-%m-01');

-- 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown
-- by count of events for each plan_name
SELECT p.plan_name, 
       s.start_date,
       COUNT(*) AS events_count
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE YEAR(s.start_date) > 2020
GROUP BY p.plan_name, s.start_date
ORDER BY p.plan_name, s.start_date;

-- 4. What is the customer count and percentage of customers who have churned rounded to 1
-- decimal place?

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS CUSTOMER_COUNT,
ROUND( (COUNT(DISTINCT(CUSTOMER_ID)) / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions) ) *100 ,1) AS PERCENTAGE
FROM SUBSCRIPTIONS
WHERE PLAN_ID IN (
    SELECT PLAN_ID
    FROM plans 
    WHERE PLAN_NAME = 'churn' OR PRICE IS NULL
);

-- 5. How many customers have churned straight after their initial free trial - what percentage is
-- this rounded to the nearest whole number?

SELECT COUNT(DISTINCT(SUB.CUSTOMER_ID)) AS CUSTOMER_COUNT,
ROUND( (COUNT(DISTINCT(SUB.CUSTOMER_ID)) / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions) ) *100 ,1) AS PERCENTAGE
FROM SUBSCRIPTIONS SUB
JOIN PLANS P ON SUB.PLAN_ID = P.PLAN_ID
WHERE
P.PLAN_NAME="TRIAL" AND
SUB.START_DATE = DATE_ADD(SUB.START_DATE , INTERVAL 7 DAY);



