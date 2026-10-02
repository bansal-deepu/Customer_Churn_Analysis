# 📊 Telecom Customer Churn & Revenue Retention Analysis

[![Python](https://img.shields.io/badge/Python-3.9%2B-blue?logo=python&logoColor=white)](https://www.python.org/)
[![Pandas](https://img.shields.io/badge/Pandas-Data%20Cleaning-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![SQL Server](https://img.shields.io/badge/MS%20SQL%20Server-T--SQL-CC292B?logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/en-us/sql-server/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Interactive%20Dashboard-F2C811?logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 📌 Executive Summary

Customer churn is one of the most critical challenges facing telecommunications providers. In this project, I engineered an end-to-end data pipeline to analyze **1,000,000 subscriber records** to determine why customers are leaving, quantify the monthly financial impact, and model strategic retention scenarios.

### 🎯 Key Baseline Metrics
* **Total Customer Base:** 10,00,000 (1 Million accounts)
* **Total Churned Accounts:** 2,60,158
* **Overall Churn Rate:** **26.02%** (~1 in every 4 customers)
* **Total Monthly Billing Revenue:** $1.40 Billion ($1,401,159,112.87)
* **Monthly Revenue Loss to Churn:** **$364.32 Million** (~$4.37 Billion annualized bleed)
* **Core Vulnerability:** Churned users on month-to-month plans generate an average monthly billing of **$1,401.55**, matching the company baseline ($1,401.16). This proves churn is eroding core, high-paying accounts rather than inactive low-tier accounts.
* **What-If ROI Impact:** A targeted **5% reduction in churn** preserves **$18.22 Million/month**, delivering **$218.59 Million annually** back to the business.

---

## 🖥️ Dashboard Architecture & Visualizations

The Power BI dashboard is designed across two interactive analytical views:

### Page 1: Executive KPI & Revenue Impact Overview
![Executive Dashboard](assets/dashboard_page1.png)
* **Global Slicers:** State, Subscription Type, Internet Service, Contract Type, Payment Method.
* **Macro KPI Cards:** Real-time visibility into Total Base, Churned Customers, Monthly Run-rate, and Lost Revenue.
* **State Revenue Comparison:** Total vs. Lost monthly revenue breakdown across top markets.
* **Dynamic What-If Parameter:** Interactive DAX slider allowing management to model custom churn reduction targets (0%–20%).
* **High-Risk Ledger:** Live audit identifying veteran churners with cumulative lifetime spending approaching $180,000.

---

### Page 2: Behavioral & Cohort Breakdown
![Breakdown Analysis](assets/dashboard_page2.png)
* **Internet Infrastructure:** Highlights Fiber Optic disproportionately driving churn.
* **Contract Duration:** Compares Month-to-Month volatility against 1-year and 2-year stability.
* **Tenure Group Dynamics:** Visualizes mid-to-late lifecycle retention paradox.
* **Support Contact Neutrality:** Analyzes churn distribution between support contacts and non-contacts.

---

## 🔍 Key Data Insights & Diagnostics

| Dimension | Primary Finding | Business Diagnostic |
| :--- | :--- | :--- |
| **Contract Duration** | **Month-to-Month accounts for 45.20% (117,582)** of all churn. | Zero exit barriers drive immediate cancellation upon experiencing service or pricing friction. |
| **Internet Service** | **Fiber users represent 34.93% (90,885)** of churned accounts. | Fiber outpaces DSL (25.04%), 5G (20.06%), and Cable (19.97%), pointing toward local fiber line instability or aggressive competitor pricing. |
| **Subscription Tier** | **Basic tier drives 41.84% (108,851)** of attrition. | Entry-level users experience early onboarding friction or perceive a low value-to-price ratio. |
| **Geographic Concentration** | **Maharashtra ($91.29M) & UP ($90.94M)** drive **50.0% ($182.23M)** of total revenue loss. | Risk is geographically concentrated; localized retention operations must prioritize these two regions. |
| **Tenure Paradox** | **25–48 mo (33.40%) & 49–72 mo (33.23%)** are the highest exit cohorts. | Veteran customers who completed 2 to 6 years are leaving post-contract, revealing a lack of loyalty incentives. |
| **Tech Support Inefficacy** | **51.01% No Support vs. 48.99% Support** usage among churners. | Reaching customer care does not buffer churn, exposing poor First Contact Resolution (FCR). |
| **Payment Channels** | **UPI leads churn at 70,005 accounts (26.91%)**, followed by Credit Cards (22.18%). | Non-recurring / manual payment setups show higher drop-off compared to auto-debit setups. |

---

## ⚙️ Technical Architecture & Pipeline
