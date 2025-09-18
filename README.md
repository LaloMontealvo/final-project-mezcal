# Final Project: Mezcal Industry Growth

## Introduction
This project analyzes the mezcal industry using an end-to-end data analytics approach.  
The aim was to consolidate official datasets, clean and structure them in SQL, apply statistical hypothesis testing in Python, and finally visualize insights in Tableau to tell the story of mezcal’s growth.

---

## Project Pipeline
1. **Data Collection**: Official CSV files extracted from regulatory reports (COMERCAM) and academic/sector studies (Interciencia, DataBridge, Maguey–Mezcal).
2. **Data Cleaning & Wrangling**: Minimal cleaning (`csv_mini_clean`), handling duplicates, nulls, and inconsistencies.
3. **SQL Schema**: Creation of structured tables (Production, Bottling National/Export, Indicators, Brands) with foreign keys to ensure data integrity. ERD diagram included.
4. **Hypothesis Testing**:  
   - H1: Domestic vs Export Share  
   - H2: Registered Brands after 2021  
   - H3: Certified Producers trend  
   - H4: Production declines as temporary shocks  
   Each tested with appropriate statistical methods (proportion z-test, regression, confidence intervals).
5. **Visualization (Tableau)**: Interactive dashboard with production trends, market shares, brands, producers, state participation, and economic indicators.

6. Mezcal-final/
│
├── data/
│ ├── raw/ # Original CSVs (comercam, interciencia, databrigde, maguey_mezcal)
│ └── processed/ # Cleaned datasets for analysis and SQL upload
│
├── notebooks/
│ ├── 01_data_overview.ipynb
│ ├── clean_mezcal_csv_visualization.ipynb
│ └── hypotheses_exploration.ipynb
│
├── sql/
│ ├── final_schema.sql
│ ├── ERD.mwb
│ └── ERD.png
│
├── figures/ # Charts and supporting images
├── docs/ # Documentation (functions, data sources)
├── src/ # Modular code (cleaning, utils)
└── README.md

## Functions & Methods
See [`docs/functions_methods.md`](docs/functions_methods.md) for a detailed list of Python functions, SQL scripts, and Tableau steps used.

---

## Data Sources
See [`docs/data_sources.md`](docs/data_sources.md) for a full inventory of raw datasets, provenance, and scope.

---

## Results & Insights
- **Production**: Sustained growth with temporary shocks (2014, 2023).  
- **Exports**: Dominant share, national stable but minor.  
- **Brands**: Stabilizing after the 2021 peak.  
- **Producers**: Positive trend, but not statistically significant evidence of acceleration.  

---

## Deliverables
- Clean datasets (`/data/processed/`)  
- SQL schema and ERD (`/sql/`)  
- Hypothesis testing notebooks (`/notebooks/`)  
- Interactive Tableau dashboard  
- Final presentation slides  
## Presentation
Final slides (Google Slides): https://docs.google.com/presentation/d/1JJY0O03tqqFcEj83QzFRgjWwRd292hhJ7yXJpeSyeCM/edit?usp=sharing
---

## Team & Acknowledgements
Developed as the Final Project for the Ironhack Data Analytics Bootcamp.  
Special thanks to instructors and colleagues for guidance and feedback.

---

## Repository Structure
