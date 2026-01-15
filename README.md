# Sales Insights & Analysis - AtliQ Hardware  

A **Data-Driven Business Intelligence Project** analyzing AtliQ Hardware’s (Mock Company) multi-year sales performance using **MySQL + Power BI**.  
This dashboard uncovers hidden insights behind declining company sales despite apparent market growth, helping leadership identify high-ROI markets and fix reporting inefficiencies.   

## Key Highlights
- Built an **Interactive Power BI Dashboard** powered by cleaned and transformed SQL data.  
- **Disproved false growth assumption** — sales dropped YoY (2017–2020) despite expanding markets.  
- Normalized multi-currency transactions (USD → INR), removed duplicates, and validated data integrity.  
- Identified **Delhi NCR & Mumbai** as top-grossing but **Lucknow & Surat** as most efficient markets.  
- Replaced manual Excel reporting with automated, interactive (YoY - monthly) insights.

## Tools & Skills
**SQL(MySQL)** | **Power BI - Dashboard Tools & DAX** | **Data Modeling** | **ETL** | **Data Cleaning** | **Business Analysis**


**Dashboard:**  I apologize I was unable to publish the Power BI report online due to lack of a work email. The report can be opened/launched and viewed in person when needed.

<details>
  <summary><b>3 Pages of Dashboard Screenshots (Click to Expand)</b></summary>

  **Page 1:**  
  ![Sales Insight Analysis - Page 1](https://github.com/user-attachments/assets/0ce79d17-f0d0-48e3-8b9e-4e9717c592ea)

  **Page 2:**  
  ![Sales Insight Analysis - Page 2](https://github.com/user-attachments/assets/4dc67739-5ccf-4b90-adb3-8cccc6358808)

  **Page 3:**  
  ![Sales Insight Analysis - Page 3](https://github.com/user-attachments/assets/1caff170-d511-49cb-ae02-3fb6fff2d06c)

</details>


**Executive Presentation Deck:** [View Google Slides](https://docs.google.com/presentation/d/1e68ZcCHOzPbsdyf8bYjK0_WDwdPrHvC-m7F55FYTLYE/present)  
**Full Case Study Below ↓**



# AtliQ Hardware Sales Insights (Approach & Findings)
**A Data-Driven Sales Performance Dashboard built using SQL (exploration) and Power BI (cleaning, modeling & visualization)**  

---

## Business Context
AtliQ Hardware is a computer hardware manufacturer that supplies peripherals across India.  
As the company expanded into new markets, its management team — led by the **(Sales Director)** — began noticing mismatched sales trends across regions.  
The Sales Director had made the assumption: **Despite apparent market growth, total revenue kept declining each year**.  
This project aimed to identify the root causes behind those inconsistencies and build a unified reporting system for interactive YoY insights.

---

## Business Problem
AtliQ’s existing manual Excel reports led to inconsistent and delayed insights, making strategic decision-making difficult.  
Key issues included:
- Fragmented sales data scattered across regions.  
- Poor visibility of top- and low-performing markets.  
- A false perception of *“growth”* — markets expanded but actual sales were dropping.

---

## Key Challenges
1. **Data Fragmentation:** No centralized data source or reliable reporting structure.  
2. **Data Quality Issues:** Duplicates, invalid transactions (`sales_amount ≤ 0`), and mixed currencies (USD vs INR).  
3. **Misinterpreted Market Growth:** Sales expansion mistaken for revenue growth due to unvalidated reporting.  

---

## Approach Overview
**Framework Used:** AIMS Grid – *(Assumptions | Information | Methodology | Solutions)*  

1. **Data Exploration (MySQL):**  
   - Explored 5 datasets (`Transactions`, `Markets`, `Products`, `Customers`, `Date`).  
   - Identified duplicate transactions and multi-currency inconsistencies.  
   - Calculated top / bottom 5 markets by total revenue.

The SQL Queries formed the foundation for modeling and dashboarding later in Power BI, ensuring accurate metrics validation and clean relationships between dimension and fact tables.

<details> <summary><b>Key SQL Queries & Insights (Click to Expand)</b></summary> 
   
Used SQL to explore and extract sales insights from AtliQ Hardware’s sales database, consisting of **5 tables**:
`Products`, `Date`, `Transactions`, `Customers`, and `Markets`.

#### **Transactions using USD Currency**

**Performed basic validation queries (e.g., checking for multi-currency transactions) to ensure data consistency before proceeding with sales and market analysis.**

```
  select*
  from sales.transactions 
  where currency = "USD";
```

*Result:* **Transaction details using USD currency**

****AND Count of How many in total (using USD)****

```
  select count(*) as "Total Number of Transactions using USD currency"
  from sales.transactions
  where currency = "USD";
```

*Result:* **2 transactions in USD**


#### **Total Revenue (Jan–Jun 2020) vs. Previous Years**
   
  ```
  select*, T.sales_amount as "Total Revenue up till June 2020"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2020 and T.currency = "INR";
```
```
  select sum(T.sales_amount) as "Total Revenue 2019"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2019 and T.currency = "INR";
```
```
  select sum(T.sales_amount) as "Total Revenue 2018"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2018 and T.currency = "INR";
```
```
  select sum(T.sales_amount) as "Total Revenue 2017"
  from sales.transactions as T
  inner join sales.date as D on D.date = T.order_date
  where D.year = 2017 and T.currency = "INR";
```
   *Results:*
   * **2020:** `₹11,014`
   * **2019:** `₹433,012`
   * **2018:** `₹621,779`
   * **2017:** `₹685,749`
     
   *Insight:* **(Revenue trend shows decline year-over-year.)**
   

#### **Top 5 Most Profitable Markets**
```
  select  markets_name, sum(sales_amount) as "Total Sales"
  from sales.transactions as T
  join sales.markets as M on T.market_code = M.markets_code
  group by T.market_code 
  order by sum(sales_qty) desc
  limit 5;
```
*Results:*
   * Delhi NCR – `₹520,721,134`
   * Mumbai – `₹150,180,636`
   * Nagpur – `₹55,026,321`
   * Kochi – `₹18,813,466`
   * Ahmedabad – `₹13,252,673`
     

#### **Bottom 5 Least Profitable Markets**
```
  select M.markets_name, sum(T.sales_amount) as "Total Sales"
  from sales.transactions as T
  join sales.markets as M on M.markets_code = T.market_code
  group by T.market_code 
  order by sum(T.sales_amount) asc
  limit 5;
```
*Results:*
   * Bengaluru	– `₹373,115`
   * Bhubaneshwar	– `₹893,857`
   * Surat	– `₹2,605,796`
   * Lucknow	– `₹3,094,007`
   * Patna	– `₹4,428,393`

 
**Further Querying revelead:**
<br><img width="752" height="206" alt="image" src="https://github.com/user-attachments/assets/bc9b3eae-c5cb-4bc5-9862-9eef66561a36" />
So here I noticed that there were 2 duplicate records of the same transactions "USD/r" and "USD", after looking at the whole dataset I figured out the whole dataset in either "INR/R" or "USD/R" and these 2 transactions in "USD" are duplicate records. So we will clean them in Power BI and build the dashboard with these values removed. <br>


**These SQL queries served as preliminary data exploration steps to validate joins, assess data quality, and gain a basic understanding of key business metrics prior to performing deeper analysis, transformation and visualization in Power BI.**

</details>


2. **Data Cleaning & Modeling (Power BI):**
   - Identified and structured a Star Schema in Power BI by connecting relationships between the Transactions fact table and dimension tables for
     Markets, Customers, Products, and Date.
   - Removed duplicates and invalid records. 2 USD/R and 2 USD transactions (duplicated records of same).
   - Removed all the transactions where sales amount (total amount in INR) was either 0 or less.
   - Standardized all figures to **INR** using a fixed 2020 rate (USD × 75.63).
   
<details> <summary><b>Key Power BI DAX-Expressions (Click to Expand)</b></summary>
   
**Star Schema:**
<br><img width="626" height="303" alt="image" src="https://github.com/user-attachments/assets/b6ed9d0b-4000-4b20-90b2-3b7b7d58fcf6" />


<br>


<br>

**Final Currency values being used:** <br>
`
= Table.SelectRows(#"Removing - values <= 0", each ([currency] = "INR#(cr)" or [currency] = "USD#(cr)"))
`
<br>

<br>

**The Normalized values for the USD currency to INR (as of 2020 - last updated) would be:** <br>
`
= Table.AddColumn(#"Cleanup currency", "Norm_sales_amount", each if [currency] = "USD#(cr)" then [sales_amount]*75.63 else[sales_amount])
`

<br>

**The 2 transactions in USD currency have converted to INR amount in Noramlized sales column:** <br>
<img width="971" height="58" alt="image" src="https://github.com/user-attachments/assets/997fc9bd-47e7-4236-b2c0-b09c4ea6e373" />

<br>
<br>

</details>


3. **Visualization (Power BI):**  
   - Built a 3-page interactive dashboard:  
     - **Key Insights**  
     - **Profit Analysis**  
     - **Performance Insights**

---

## Key Insights
- **Revenue Decline Identified:** Despite new markets, yearly sales fell from 2017 → 2020.  
- **Top Markets:** Delhi NCR and Mumbai contributed ~70 % of revenue.  
- **Efficient Markets:** Lucknow, Surat and Bhubaneshwar were among the top most in terms of profit efficiency (Profit %), despite not being at the top in terms of Revenue.
- **Currency Standardization:** Unified USD and INR data improved report accuracy.  
- **Duplicate Records Removed:** Eliminated false spikes and inaccurate sales entries.  

---

## Business Impact
| **Metric** | **Before** | **After** |
|-------------|-------------|------------|
| Data Quality | Inconsistent & duplicated | Cleaned & standardized dataset |
| Reporting Process | Manual Excel (4–6 hrs/week) | Automated Power BI Dashboard |
| Sales Visibility | Regional only | Company-wide performance overview |
| Decision-Making | Reactive | Proactive & data-driven |

---

## Tools & Techniques
| **Category** | **Used For** |
|---------------|--------------|
| AIMS Grid | Defining Project Purpose, Stakeholders, End Result, Success Critera|
| MySQL | Data exploration & validation |
| Power BI | Data cleaning, modeling & visualization |
| Power Query + DAX | Data transformation & KPI calculations |
| Excel | Initial data view / file imports |
| Data Analysis | Business storytelling & trend diagnosis |

---

## Key Outcomes
- Built an **interactive Power BI dashboard** consolidating all sales data.  
- Reframed company’s “growth narrative” — sales were declining despite market expansion.  
- Delivered real-time visibility into KPIs and profit trends across markets.  
- Enabled management to allocate resources based on profit efficiency instead of sales volume.  
- Automated reporting process, saving 4–6 hours per week.  

---

## Deliverables
- **Executive Deck:** [View Slides](your-slides-link-here)  
- **GitHub README:** [Detailed Project Story](your-readme-link-here)  
- **Interactive Dashboard:** [View Dashboard](your-powerbi-link-here)

---

## Future Enhancements
- Add advanced SQL for profit ratio and market efficiency analysis.  
- Automate data refresh pipeline from MySQL → Power BI.  
- Expand KPIs to include customer retention and product-level profitability.  
- Integrate forecasting models for sales prediction.  

---

*Developed by Harsh Mishra*  
*Open for Data Analyst / BI opportunities*  
