# Workforce-Analytics-Attrition-Optimization-Project-for-IT-Services
_Predictive & Explainable Modeling for Proactive Workforce Retention_

## 📊 Project Overview
This project applies **machine learning, SQL-based validation, and Power BI analytics** to transform employee attrition from a historical HR metric into a **predictive workforce risk signal**.

Using a real-world HR dataset, the project uncovers:
- Employees at elevated attrition risk
- Structural and demographic drivers of attrition
- Actionable insights through *explainable machine learning*

The solution integrates **data auditing, predictive modeling, and executive-ready dashboards**, enabling leadership teams to take **proactive, data-driven retention actions**.

---

## 🧠 Key Skills Demonstrated
| Skill Area | Tools & Techniques |
|-----------|------------------|
| Data Auditing | SQL integrity checks, snapshot validation, business rule enforcement |
| Data Preparation | Pandas, NumPy, feature engineering, encoding strategies |
| Machine Learning | Logistics Regression, Random Forest, model evaluation (ROC-AUC, precision, recall) |
| Explainable AI | Feature importance analysis, coefficient interpretation, model consistency checks |
| Analytics & BI | Power BI data modeling, DAX measures, tooltips, slicers |
| Visualization | Risk segmentation, trend analysis, driver-based insights |
| Business Analytics | Workforce risk integration, HR strategy alignment |
| Version Control | GitHub repo with structured documentation and assets |

---

## 📂 Project Structure

📁 Workforce-Analytics-Attrition-Optimization
│
├── 📁 Data
│   ├── 📁 Processed
│   │   ├── attrition_feature_importance.csv
│   │   ├── employee_analytics.csv
│   │   ├── employee_attrition_scored.csv
│   │   └── employee_ml.csv
│   └── 📁 Raw
│       └── employee_raw.csv
│
├── 📁 Images
│   ├── Dashboard 1.png
│   ├── Screenshot 1.png
│   ├── Screenshot 2.png
│   ├── Screenshot 3.png
│   ├── Screenshot 4.png
│   ├── Screenshot 5.png
│   ├── Screenshot 6.png
│   └── Screenshot 7.png
│
├── 📁 notebook
│   └── employee_attrition_prediction.ipynb
│
├── 📁 powerbi
│   └── HR_attrition_analytics.pbix
│
├── 📁 sql
│   ├── 01_data_audit.sql
│   └── 02_transformations.sql
│
├── 📄 Report.pdf
└── README.md



---

## 🧬 Dataset Source
- Kaggle: [Employee Attrition Dataset](https://www.kaggle.com/datasets/HRAnalyticRepository/employee-attrition-data)
- Size: **49,648 employee records**
- Multi-year workforce snapshots
- Attrition rate: **~3%**
- Attributes include demographic, organizational, tenure, and job-level features  

This dataset reflects **real-world class imbalance**, making it suitable for applied predictive modeling and responsible ML evaluation.

---

## 🎯 Dashboards & KPIs

### Dashboard 1 — *Workforce & Attrition Insights*
![Dashboard 1](Images/Dashboard%201.png)

**Objective:**  
Provide a **descriptive and diagnostic foundation** for understanding workforce composition and historical attrition patterns prior to predictive modeling.

**Key Visuals**
- Workforce headcount by year
- Active vs terminated employees trend
- Attrition rate over time
- Attrition by department
- Attrition by business unit
- Attrition by tenure band

**KPIs**
- Total Employees
- Active Employees
- Terminated Employees
- Attrition Rate
- Early Exit Percentage
- Average Tenure

**Business Value**  
Validates KPI logic, data integrity, and workforce trends, ensuring a strong analytical baseline before introducing machine-learning predictions.

---

### Dashboard 2 — *Attrition Risk & Prediction*
![Dashboard 2](Images/Screenshot%201.png)

**Objective:**  
Translate machine-learning predictions into **actionable, explainable workforce risk insights** for HR and leadership teams.

**Key Visuals**
- Attrition risk distribution (Low / Medium / High)
- Average predicted risk by department *(with tooltip)*
- Average predicted risk by job title *(with tooltip)*
- Risk concentration by driver category
- Model explainability: feature importance
- High-risk employee analysis (aggregated, non-identifying)

**Tooltip Design (Explainability Layer)**
- Average predicted attrition risk
- Employee count context
- Risk band distribution

**Purpose:**  
Prevents misinterpretation of averages and supports responsible, data-driven decision-making.

---

## 🧪 Machine Learning & Model Performance

| Model | ROC-AUC | Key Characteristics |
|-----|--------|-------------------|
| Logistic Regression | 0.88 | High interpretability, strong baseline |
| Random Forest | **0.94** | Best performance, captures non-linear patterns |

**Model Selection:** Random Forest  
Selected for superior predictive accuracy while retaining transparency through feature importance analysis.

**Key Insights**
- Short tenure is a strong stabilizing factor against attrition
- Age, job role, and location contribute meaningfully to attrition risk
- Logistic Regression and Random Forest highlight **consistent top drivers**, reinforcing model reliability

---

## 💡 Value Delivered
✔ Early identification of employees at attrition risk  
✔ Transparent and explainable ML-driven insights  
✔ Business-ready dashboards for HR leadership  
✔ Strong alignment between predictive analytics and workforce strategy  
✔ Demonstrates end-to-end data science capability from audit to insight  

---

## 📺 Video Demo
🔗 *Coming soon: Walkthrough of dashboards with key insights*

---

## 👤 Author
**Shreya Deshpande**  
Data Scientist (Early Career)  
Python • SQL • Machine Learning • Power BI

