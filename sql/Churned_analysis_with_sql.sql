SELECT TOP 5 *
FROM   customer_churn;

-- Total Customers
SELECT count(*)
FROM   customer_churn; --1000000

-- Top 10 High value customers
SELECT   TOP 10 Customer_Name,
                Age,
                state,
                Customer_Value,
                Subscription_Type,
                Contract_Type,
                Tenure_Group,
                Age_Group,
                churn
FROM     customer_churn
ORDER BY Customer_Value DESC;

-- Total churned customers -- 2,60,158
SELECT count(*)
FROM   customer_churn
WHERE  Churn_Flag = 1;

-- Churned Rate 
SELECT CAST (ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100.0 / COUNT(*), 2) AS DECIMAL (10, 2)) AS Churn_Rate
FROM   customer_churn; --26.02%

-- Total and Average Monthly Revenue
SELECT FORMAT(SUM(Monthly_Charges), 'C', 'en-US') AS Total_Monthly_Revenue, -- $1,401,159,112.87
       FORMAT(AVG(Monthly_Charges), 'C', 'en-US') AS AVG_Monthly_Revenue -- $1,401.16
FROM   customer_churn;

-- Total Revenue by State
SELECT   state,
         FORMAT(SUM(Monthly_Charges), 'C', 'en-US') AS Total_Monthly_Revenue_state
FROM     customer_churn
GROUP BY state
ORDER BY Total_Monthly_Revenue_state DESC;

-- Total Monthly Revenue of Churned customers
SELECT FORMAT(SUM(Monthly_Charges), 'C', 'en-US') AS Total_Monthly_Revenue_churned -- $364,323,324.87
FROM   customer_churn
WHERE  Churn_Flag = 1;

-- Total Revenue of Churned customers by State
SELECT   state,
         FORMAT(SUM(Monthly_Charges), 'C', 'en-US') AS Total_Monthly_Revenue_state_churned
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY state
ORDER BY Total_Monthly_Revenue_state_churned DESC;

--Average monthly charges by Contract type
SELECT   contract_type,
         FORMAT(AVG(Monthly_Charges), 'C', 'en-US') AS AVG_Monthly_Revenue_ct
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY contract_type
ORDER BY AVG_Monthly_Revenue_ct DESC;

SELECT   contract_type,
         CAST (ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100.0 / (SELECT COUNT(*)
                                                                           FROM   customer_churn
                                                                           WHERE  Churn_Flag = 1), 2) AS DECIMAL (10, 2)) AS Churn_Rate_Pct
FROM     customer_churn
GROUP BY contract_type
ORDER BY Churn_Rate_Pct DESC;

-- Average Tenure Months
SELECT AVG(Tenure_Months) AS AVG_Tenure_Months --36
FROM   customer_churn;

--Churn by Contract type
SELECT   contract_type,
         count(*) AS Total_Churned_Customers_ct
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY contract_type;

--Churn by subscription_type
SELECT   subscription_type,
         count(*) AS Total_Churned_Customers_st
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY subscription_type
ORDER BY Total_Churned_Customers_st DESC;

--Churn by Payment_Method
SELECT   subscription_type,
         CAST (ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100.0 / (SELECT COUNT(*)
                                                                           FROM   customer_churn
                                                                           WHERE  Churn_Flag = 1), 2) AS DECIMAL (10, 2)) AS Churn_Rate_Pct
FROM     customer_churn
GROUP BY subscription_type
ORDER BY Churn_Rate_Pct DESC;

SELECT   Payment_Method,
         count(*) AS Total_Churned_Customers_pm
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY Payment_Method
ORDER BY Total_Churned_Customers_pm DESC;

--Churn by Internet_Service
SELECT   Internet_Service,
         count(*) AS Total_Churned_Customers_is
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY Internet_Service
ORDER BY Total_Churned_Customers_is DESC;

--Churn by Tech_Support
SELECT   Internet_Service,
         subscription_type,
         CAST (ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100.0 / (SELECT COUNT(*)
                                                                           FROM   customer_churn
                                                                           WHERE  Churn_Flag = 1), 2) AS DECIMAL (10, 2)) AS Churn_Rate_Pct
FROM     customer_churn
GROUP BY Internet_Service, subscription_type
ORDER BY Churn_Rate_Pct DESC;

SELECT   Tech_Support,
         count(*) AS Total_Churned_Customers_ts
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY Tech_Support
ORDER BY Total_Churned_Customers_ts DESC;

--Churn by Tenure_Group
SELECT   Tech_Support,
         CAST (ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100.0 / (SELECT COUNT(*)
                                                                           FROM   customer_churn
                                                                           WHERE  Churn_Flag = 1), 2) AS DECIMAL (10, 2)) AS Churn_Rate_Pct
FROM     customer_churn
GROUP BY Tech_Support
ORDER BY Churn_Rate_Pct DESC;

SELECT   Tenure_Group,
         count(*) AS Total_Churned_Customers_tg
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY Tenure_Group
ORDER BY Total_Churned_Customers_tg DESC;

--Churn by Age_Group
SELECT   Age_Group,
         count(*) AS Total_Churned_Customers_ag
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY Age_Group
ORDER BY Total_Churned_Customers_ag DESC;

--Churn by State
SELECT   State,
         count(*) AS Total_Churned_Customers_s
FROM     customer_churn
WHERE    Churn_Flag = 1
GROUP BY State
ORDER BY Total_Churned_Customers_s DESC;


--Business Summary
--Massive Financial Exposure ($364.32M Monthly / ~$4.37B Annual)
--Out of 1,000,000 total customers, 260,158 have churned (a 26.02% overall churn rate). 
--The average monthly charge of churned customers ($1,401.55 on Month-to-Month) matches the 
--base average ($1,401.16), meaning churn is eroding high-paying core accounts rather than low-value users.
--Month-to-Month Contracts Drive Drop-Offs
--45.2% of all churned users (117,582 accounts) are on Month-to-Month plans. Long-term lock-in drops 
--churn significantly (One Year: 77,945; Two Year: 64,631).
--Entry-Tier Dissatisfaction
--The Basic plan accounts for 41.8% of churn (108,851), compared to Standard (77,924) and 
--Premium (73,383), pointing toward poor onboarding experience or an unfavorable price-to-value 
--ratio early on.
--Network & Service Quality Risks (Fiber)
--Fiber internet leads churn with 90,885 customers, significantly outpacing DSL (65,132), 
--5G (52,175), and Cable (51,966). For a premium connection tier, this flags network stability or 
--aggressive competitor pricing.
--Ineffective Support Buffering
--Churn is nearly split down the middle regardless of customer support contact: 51% without 
--Tech Support (132,711) vs. 49% with Tech Support (127,447). Reaching support fails to retain customers, 
--highlighting poor First Call Resolution (FCR) or service recovery.
--Tenure Retention Paradox:
--Churn peaks in mid-to-late cohorts: 25–48 months (86,903) and 49–72 months (86,441). 
--Customer loss is not isolated to early drop-offs (0–12 months: 43,408); loyal long-term accounts are 
--leaving upon contract completion.
--Regional Concentration (50% in Two States):
--Maharashtra (65,158 churned, $91.29M lost) and Uttar Pradesh (64,852 churned, $90.94M lost) 
--generate half of the total churn and revenue loss.


