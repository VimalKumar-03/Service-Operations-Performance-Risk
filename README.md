# 📊 Service Operations Performance & Risk Dashboard

# Tools: Python | MySQL | Power BI
# Domain: Service Operations | Backlog & Risk Analytics

# 🔹 Project Overview
This project analyzes customer service operations data to track:
Open case backlog
Department & region workload
High-risk pending cases
Resolution performance
Customer satisfaction
The goal is to help management monitor risk, prioritize work, and improve service performance.

# 🔹 Dataset Summary

Total Records: 30,000 cases
Key Columns:
Case_ID
Department
Region
Priority
Created_Date
Closed_Date
Resolution_Days
SLA_Days
Customer_Rating
Agent_ID

# Null Values
Closed_Date, Resolution_Days, and Customer_Rating contain NULL values for open cases
NULLs were not filled to keep the real operational status of pending cases.

# 🔹 Data Cleaning (Python)

Using Pandas:
Converted date columns to proper datetime
Created Resolution_Days
Identified open and closed cases using Closed_Date

# Performed basic exploratory analysis by:
Department
Region
Priority

# 🔹 SQL Analysis (MySQL)

Closed cases were analyzed in SQL to calculate:
Average resolution days
Department-wise performance
Region-wise performance
Agent performance
Customer rating analysis

# 🔹 Power BI Dashboard

The dashboard includes:
KPIs
Total Cases
Open Cases
Closed Cases
Average Resolution Days
Average Customer Rating
Visuals
Open Cases Trend by Month
Open Cases by Department
Open Cases by Region
Open Cases by Priority
High-Risk Open Cases by Department
Filters (Slicers)
Department
Region
Priority

# 🔹 Key Insights

Identified departments with maximum backlog

Highlighted high-risk (High & Critical) pending cases

Tracked workload trend over time

Measured operational efficiency using resolution time and ratings

# 🔹 Why NULL Values Were Preserved

Open cases do not have closure dates.
Filling these values would:

Misrepresent resolution time

Distort SLA calculations

Give incorrect business insights

So NULL values were intentionally preserved.

# 🔹 Conclusion

This project demonstrates a complete end-to-end data analytics workflow:

Data Cleaning → Python

Performance Analysis → MySQL

Visualization → Power BI

It reflects real-world service operations and risk monitoring dashboards used in companies like EXL.
