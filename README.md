# 📊 Telecom Customer Churn & Retention Analysis

[![Python](https://img.shields.io/badge/Python-3.9%2B-blue?logo=python&logoColor=white)](https://www.python.org/)
[![Pandas](https://img.shields.io/badge/Pandas-Data%20Cleaning-150458?logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![SQL Server](https://img.shields.io/badge/MS%20SQL%20Server-T--SQL-CC292B?logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/en-us/sql-server/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Interactive%20Dashboard-F2C811?logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 📌 Executive Summary

Customer churn directly erodes recurring subscription revenue and drives up acquisition costs. In this portfolio project, I engineered an end-to-end data pipeline analyzing **1,000,000 subscriber records** to evaluate churn dynamics, quantify financial losses, and model potential revenue recovery through strategic retention initiatives[cite: 1].

### 🎯 Key Baseline Metrics
* **Total Customers:** 10,00,000 (1 Million accounts)[cite: 1]
* **Churned Customers:** 2,60,158[cite: 1]
* **Overall Churn Rate:** **26.02%** (~1 in every 4 subscribers)[cite: 1]
* **Total Monthly Billing Revenue:** $1.40 Billion ($1,401,159,112.87)[cite: 1]
* **Monthly Revenue Loss to Churn:** **$364.32 Million** (~$4.37 Billion annual revenue loss)[cite: 1]
* **Average Monthly Billing:** $1,401.16 (Base average) vs. $1,401.55 (Month-to-Month churned average), showing that churn is eroding high-paying core accounts rather than low-value users.
* **What-If ROI Impact:** A targeted **5% reduction in churn** preserves **$18.22 Million/month**, delivering **$218.59 Million annually** back to the business[cite: 1].

---

## 🖥️ Interactive Power BI Dashboards

The reporting framework consists of a 2-page interactive dashboard designed in Power BI[cite: 1, 2]:

### Page 1: Executive KPI & Revenue Impact Overview
![Executive Dashboard](assets/dashboard_page1.png)
* **Global Slicers:** State, Subscription Type, Internet Service, Contract Type, Payment Method[cite: 1].
* **Macro KPI Cards:** Real-time visibility into Total Customers, Churned Accounts, Monthly Revenue, Churn %, and Lost Revenue[cite: 1].
* **State Revenue Exposure:** Bar chart comparing Total vs. Lost Monthly Revenue across states[cite: 1].
* **Dynamic What-If Parameter:** Interactive DAX slider allowing stakeholders to simulate churn reduction rates (defaulted at 5%)[cite: 1].
* **High-Risk Ledger:** Tabular view identifying top churned customers with high cumulative lifetime spend[cite: 1].

---

### Page 2: Behavioral & Cohort Breakdown
![Breakdown Analysis](assets/dashboard_page2.png)
* **Service Breakdown:** Visual distribution across Internet Service types (Fiber, DSL, 5G, Cable)[cite: 2].
* **Contract Duration:** Comparison of Month-to-Month volatility against 1-year and 2-year stability[cite: 2].
* **Subscription Tier Split:** Churn distribution across Basic, Standard, and Premium tiers[cite: 2].
* **Payment Methods & Tech Support:** Analysis of churn across payment channels and tech support interactions[cite: 2].
* **Tenure Group Cohorts:** Visualizing customer loss across different lifecycle stages[cite: 2].

---

## 🔍 Key Data Insights & Analytical Findings

| Dimension | Primary Finding | Business Diagnostic |
| :--- | :--- | :--- |
| **Contract Duration** | **Month-to-Month drives 45.20% (117,582)** of total churn[cite: 2]. | Zero exit barriers drive immediate drop-offs compared to 1-Year (29.96%) and 2-Year (24.84%) plans[cite: 2]. |
| **Internet Service** | **Fiber optics accounts for 34.93% (90,885)** of churn[cite: 2]. | Outpaces DSL (25.04%), 5G (20.06%), and Cable (19.97%), pointing toward network stability issues or aggressive competitor offers[cite: 2]. |
| **Subscription Tier** | **Basic tier leads attrition at 41.84% (108,851)**[cite: 2]. | Standard (29.95%) and Premium (28.21%) churn less; entry-tier users experience onboarding friction or low perceived value[cite: 2]. |
| **Regional Concentration** | **Maharashtra ($91.29M) & UP ($90.94M)** drive **50.0% ($182.23M)** of all revenue loss[cite: 1]. | Revenue loss is heavily concentrated; retention initiatives must prioritize these two geographic regions[cite: 1]. |
| **Tenure Paradox** | **25–48 mo (33.40%) & 49–72 mo (33.23%)** are the largest exit cohorts[cite: 2]. | Veteran customers who completed 2 to 6 years are leaving post-contract, highlighting a lack of loyalty perks[cite: 2]. |
| **Tech Support Inefficacy** | **51.01% No Support vs. 48.99% Support** usage among churners[cite: 2]. | Contacting tech support fails to prevent cancellation, indicating need for better First Contact Resolution (FCR)[cite: 2]. |
| **Payment Channels** | **UPI represents 70,005 accounts (26.91%)**, followed by Credit Card (22.18%) and Debit Card (22.14%)[cite: 2]. | Non-recurring / manual payment setups show higher drop-offs compared to auto-debit mechanisms. |

---

## ⚙️️ Technical Architecture & Pipeline

```
Raw CSV (1,000,000 Records)
   └── Python (Pandas ETL & Feature Engineering)
         └── Data Cleansing & Validation
               └── MS SQL Server (Relational Storage & T-SQL Queries)
                     └── Power BI (Data Modeling, DAX Measures, What-If Simulation)
```

### 1. Python Data Cleaning & Feature Engineering
* Stripped leading/trailing whitespace across string fields (`.str.strip()`) to avoid duplicate SQL grouping[cite: 4].
* Standardized text casing across categorical columns (`.str.title()`)[cite: 4].
* Converted charges, tenure, and age into numeric datatypes, and formatted interaction dates[cite: 4].
* Derived custom features:
  * `Churn_Flag`: Binary `1/0` indicator for clean aggregation in SQL and DAX[cite: 6].
  * `Customer_Value`: Cumulative lifetime spend (`Tenure_Months * Monthly_Charges`)[cite: 1, 5].
  * `Tenure_Group`: Binned into `0-12`, `13-24`, `25-48`, and `49-72 months`[cite: 2, 5].
  * `Age_Group`: Categorized into `Young`, `Adult`, and `Senior`[cite: 1, 6].

### 2. SQL Server Analysis (T-SQL)
* Built structured queries to calculate churn rates, group revenue by state, and rank top churners.
* Sample query for contract-level churn distribution:

```sql
SELECT 
    contract_type,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) AS Churned_Customers,
    CAST(
        ROUND(
            COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100.0 / 
            (SELECT COUNT(*) FROM customer_churn WHERE Churn_Flag = 1), 
            2
        ) AS DECIMAL(10, 2)
    ) AS Churn_Rate_Pct
FROM customer_churn
GROUP BY contract_type
ORDER BY Churn_Rate_Pct DESC;
```

### 3. Power BI DAX Financial Simulation
Dynamic parameter logic used to calculate potential revenue savings:
```dax
Potential Monthly Revenue Saved = 
[Lost Monthly Revenue] * 'Churn Reduction %'[Churn Reduction Value]

Potential Annual Revenue Saved = 
[Potential Monthly Revenue Saved] * 12
```

---

## 💡 Practical Business Recommendations

1. **Incentivize Annual Contracts:** Offer a 10%–12% discount or speed bump for Month-to-Month customers moving to 1-Year plans, targeting the 45.2% churn segment[cite: 2].
2. **Targeted Fiber Network Audits:** Run infrastructure quality checks across Maharashtra and Uttar Pradesh to resolve line drops and speed issues[cite: 1, 2].
3. **Tenure Loyalty Milestone Rewards:** Introduce milestone benefits (free streaming add-ons or speed boosts) for accounts completing 2 and 4 years to counter long-term renewal drop-offs[cite: 2].
4. **Basic Tier Value Enhancement:** Add basic features (such as free security tools or automated onboarding checkups) to reduce early cancellations[cite: 2].
5. **Tech Support First-Contact Resolution:** Equip support agents with the ability to offer quick billing credits or issue waivers during downtime to retain dissatisfied users[cite: 2].

---

## 📁 Repository Structure

```text
Customer_Churn_Analysis/
│
├── data/
│   ├── raw/                        # Original raw dataset
│   └── processed/                  # Cleaned dataset (cleaned_customer_churn.csv)
│
├── notebooks/
│   └── customer_churn_eda.ipynb    # Python cleaning & feature engineering notebook
│
├── sql/
│   └── churn_analysis_queries.sql  # T-SQL analytical and KPI queries
│
├── powerbi/
│   └── customer_churn_dashboard.pbix # Power BI dashboard file
│
├── assets/
│   ├── dashboard_page1.png         # Executive dashboard screenshot
│   └── dashboard_page2.png         # Breakdown dashboard screenshot
│
├── reports/
│   └── Customer_Churn_Analysis_Report.docx # Word document project report
│
├── .gitignore
├── LICENSE
├── requirements.txt
└── README.md
```

---

## 🚀 How to Run Locally

### Prerequisites
* Python 3.9+
* Microsoft SQL Server & SQL Server Management Studio (SSMS)
* Microsoft Power BI Desktop

### Steps
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/bansal-deepu/Customer_Churn_Analysis.git](https://github.com/bansal-deepu/Customer_Churn_Analysis.git)
   cd Customer_Churn_Analysis
   ```
2. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
3. **Run Data Preparation:**
   * Open `notebooks/customer_churn_eda.ipynb` in Jupyter Notebook[cite: 3].
   * Run all cells to process the data and generate engineered features[cite: 5].
4. **Database Staging & SQL Analysis:**
   * Import `cleaned_customer_churn.csv` into MS SQL Server[cite: 6].
   * Run the scripts in `sql/churn_analysis_queries.sql`.
5. **View Dashboard:**
   * Open `powerbi/customer_churn_dashboard.pbix` in Power BI Desktop to interact with the visualizations and What-If parameter slider[cite: 1, 2].

---

## 📜 License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 👤 Author
**Deepanshu Bansal**  
* [LinkedIn](https://www.linkedin.com/in/deepanshu-bansal-55db36)  
* [GitHub Profile](https://github.com/bansal-deepu)  
* Email: Bansaldeepanshu1976@gmail.com
