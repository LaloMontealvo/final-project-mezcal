# Functions & Methods Used

This document lists the main functions, methods, and tools applied during the Mezcal Final Project.

---

## Python (Data Cleaning & Analysis)
- **pandas.read_csv()** → Load raw CSV files.  
- **.dropna()** → Handle missing values.  
- **.drop_duplicates()** → Remove duplicate rows.  
- **.astype() / pd.to_numeric() / pd.to_datetime()** → Type conversions.  
- **.groupby()** → Aggregate values (e.g., by year, country, category).  
- **.size() / .count() / .sum()** → Descriptive stats.  
- **.unstack() / .reset_index()** → Reshape data.  
- **matplotlib.pyplot.plot(), bar(), line()** → Visualizations.  
- **statsmodels.api.OLS()** → Regression tests.  
- **scipy.stats.proportions_ztest()** → Proportion test for H1.  

---

## SQL (Data Organization & Integrity)
- **CREATE TABLE** → Structured schema with primary keys.  
- **FOREIGN KEY** → Relationships between production, bottling, indicators.  
- **INSERT INTO** → Populate tables from processed CSVs.  
- **JOINs (INNER, LEFT, ANTI-JOIN)** → Integrity checks.  
- **CREATE VIEW** → Consolidated clean datasets for analysis.  

---

## Tableau (Visualization & Storytelling)
- Line charts (Production trends).  
- Bar charts (Export vs. National share).  
- Map visualization (State participation).  
- Dashboard combining all KPIs.  

---

## Project Workflow
1. **Data Overview Notebook** → CSV cleaning and minimal processing.  
2. **SQL Schema** → Create relational model and validate integrity.  
3. **Hypotheses Notebook** → Statistical testing and findings.  
4. **Tableau Dashboard** → Final storytelling with interactive visuals.
