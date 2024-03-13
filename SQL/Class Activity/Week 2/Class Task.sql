create database Atom_camp_week2;

-- 1. Exercise: Find the average monthly rate for each service type in service_packages. Use the ROUND function here to make result set neater
SELECT service_type, ROUND(AVG(monthly_rate), 2) AS average_monthly_rate FROM service_packages GROUP BY service_type;

-- 2. Exercise: Identify the customer who has used the most data in a single service_usage record. (covers ORDER BY and LIMIT that we did in last class)
 
SELECT CUSTOMER_ID FROM SERVICE_USAGE ORDER BY DATA_USED DESC LIMIT 1;

-- 3. Exercise: Calculate the total minutes used by all customers for mobile services.
SELECT SUM(MINUTES_USED) AS TOAL_MINUTES FROM SERVICE_USAGE WHERE SERVICE_TYPE = 'Mobile';

-- 4. Exercise: List the total number of feedback entries for each rating level.
SELECT COUNT(FEEDBACK_ID) AS FEEDBACK_ENTRIES FROM FEEDBACK GROUP BY RATING;

-- 5. Exercise: Calculate the total data and minutes used per customer, per service type
SELECT CUSTOMER_ID , SERVICE_TYPE , SUM(DATA_USED) AS TOTAL_DATA_USED , SUM(MINUTES_USED) AS TOTAL_MINUTES_USED FROM SERVICE_USAGE GROUP BY CUSTOMER_ID , SERVICE_TYPE ;

-- 7. Exercise: Group feedback by service impacted and rating to count the number of feedback entries.
SELECT COUNT(*) AS FEEDBACK_ENTRIES FROM FEEDBACK GROUP BY SERVICE_IMPACTED , RATING ;

-- 8. Exercise: Show the total amount due by each customer, but only for those who have a total amount greater than $100.

SELECT CUSTOMER_ID , SUM(AMOUNT_DUE) AS TOTAL_AMOUNT_DUE FROM BILLING GROUP BY CUSTOMER_ID HAVING TOTAL_AMOUNT_DUE > 100;

-- 9. Determine which customers have provided feedback on more than one type of service, but have a total rating less than 10.

SELECT customer_id
FROM feedback
GROUP BY customer_id
HAVING COUNT(SERVICE_IMPACTED) > 1 
AND SUM(rating) < 10;

-- 1. Exercise: Categorize customers based on their subscription date: ‘New’ for those subscribed after 2023-01-01, ‘Old’ for all others.
SELECT
    customer_id,
    subscription_ID,
    CASE
        WHEN START_date > '2023-01-01' THEN 'New'
        ELSE 'Old'
    END AS customer_category
FROM
    SUBSCRIPTIONS;

-- 2. Exercise: Provide a summary of each customer’s billing status, showing ‘Paid’ if the payment_date is not null, and ‘Unpaid’ otherwise.    
 SELECT 
    customer_id,
    CASE 
        WHEN payment_date IS NOT NULL THEN 'Paid'
        ELSE 'Unpaid'
    END AS billing_status
FROM 
    billing;   
    
-- 4. Exercise: In service_usage, label data usage as ‘High’ if above the average usage, ‘Low’ if below.
SELECT
    customer_id,
    CASE
        WHEN data_used > (
            SELECT AVG(data_used) FROM service_usage
        ) THEN 'High'
        ELSE 'Low'
    END AS data_usage_label
FROM
    service_usage;
    
-- 5. Exercise: For each feedback given, categorise the service_impacted into ‘Digital’ for ‘streaming’ or ‘broadband’ and ‘Voice’ for ‘mobile’.

SELECT 
	FEEDBACK_ID IS NOT NULL,
    CASE 
		WHEN SERVICE_IMPACTED = 'streaming' OR SERVICE_IMPACTED = 'broadband' THEN 'Digital'
        WHEN SERVICE_IMPACTED = 'mobile' THEN 'Voice'
	END AS CATEGORISE_SERVICE_IMPACTED
FROM 
	FEEDBACK;
   
-- 6. Exercise: Update the discounts_applied field in billing to 10% of amount_due for bills with a payment_date past the due_date, otherwise set it to 5%.   

UPDATE BILLING 
SET DISCOUNTS_APPLIED = CASE 
							WHEN AMOUNT_DUE > DUE_DATE THEN 0.10 * AMOUNT_DUE
                            ELSE 0.05 * AMOUNT_DUE
                            END;
                            
                            
-- 7. Exercise: Classify each customer as ‘High Value’ if they have a total amount due greater than $500, or ‘Standard Value’ if not.
 SELECT 
    customer_id,
    CASE 
        WHEN  SUM(AMOUNT_DUE) > 500 THEN 'High Value'
        ELSE 'Standard Value'
    END AS CUSTOMER_CLASSIFICATOIN
FROM 
    billing
GROUP BY 
	CUSTOMER_ID;

-- 8. Exercise: Mark each feedback entry as ‘Urgent’ if the rating is 1 and the feedback text includes ‘outage’ or ‘down’.

SELECT 
    RATING IS NOT NULL,
    FEEDBACK_TEXT IS NOT NULL,
    CASE 
        WHEN rating = 1 AND (feedback_text LIKE '%outage%' OR feedback_text LIKE '%down%') THEN 'Urgent'
        ELSE NULL
    END AS FEEDBACK_ENTRY
FROM 
    feedback;


-- 9. Exercise: In billing, create a flag for each bill that is ‘Late’ if the payment_date is after the due_date, ‘On-Time’ if it’s the same, and ‘Early’ if before.
SELECT 
    payment_date is not null,
    due_date is not null,
    CASE 
        WHEN payment_date > due_date THEN 'Late'
        WHEN payment_date = due_date THEN 'On-Time'
        ELSE 'Early'
    END AS payment_flag
FROM 
    billing;
		
