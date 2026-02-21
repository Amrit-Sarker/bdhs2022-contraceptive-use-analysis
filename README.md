# BDHS 2022 Contraceptive Use Analysis

This repository explores patterns and determinants of contraceptive use among women aged 15–49 in Bangladesh using the **Bangladesh Demographic and Health Survey (BDHS) 2022** dataset. The analysis includes visualizations, chi‑square tests of association, trend analysis by age, and logistic regression modeling.

---

## 🧠 Background

The BDHS is a nationally representative survey that collects data on fertility, family planning, maternal and child health, and socio‑demographic characteristics. This project analyzes how factors like age, education, wealth, residence, and division relate to contraceptive use.

---

## 🗂 Repository Structure

| File | Description |
|------|-------------|
| `bdhs2022-contraceptive-analysis.qmd` | Quarto document with full analysis and narrative storytelling |
| `bdhs2022-contraceptive-analysis.pdf` | Rendered PDF output of the Quarto report |
| `fertility.csv` | Cleaned analysis dataset (derived from BDHS 2022) |
| `README.md` | Project overview and guide |

---

## 📊 Key Analyses

### 1. **Exploratory Data Analysis (EDA)**  
- Distributions (total children, age at first birth)  
- Boxplots by education, wealth, and division  
- Bar plots showing contraceptive use patterns

### 2. **Trend Analysis by Age**  
- Smoothed curve showing contraceptive use peaks around mid‑30s

### 3. **Statistical Association Tests**
- Chi‑square tests show significant differences in contraceptive use by education, wealth, residence, and division

### 4. **Logistic Regression**
- Age, education, wealth, residence, and division included in a logistic model
- Confirms the associations observed in visual analysis

---

## 📈 Key Findings

- **Age:** Usage rises with age and peaks in the mid‑30s (inverse U‑shape)  
- **Education:** Primary and secondary education are linked with higher use; higher education is not significantly different  
- **Wealth:** Only the richest group shows statistically higher contraceptive use  
- **Residence:** Urban and rural usage rates are similar  
- **Division:** Clear regional variations in contraceptive use

> These results help understand socio‑demographic patterns of contraceptive use in Bangladesh and can inform targeted family planning programs.

---

## 📌 Notes on Data

- The dataset used (`fertility.csv`) is a *cleaned version* derived from BDHS 2022  
- The original BDHS dataset is not publicly included here due to licensing restrictions  
- To reproduce the analysis, users must download the official BDHS 2022 IR file from the DHS Program

---

## 🛠 Tools & Packages

- **R & Quarto**  
- R packages: `tidyverse`, `ggplot2`, `haven`  
- `Quarto` for documented reporting and PDF rendering

---

## 📁 How to Reproduce

1. Clone this repository  
2. Place the original BDHS 2022 IR file in your working directory  
3. Open and render the Quarto (.qmd) file  
4. Review the generated PDF or HTML

---

## 📬 Contact

Created by **Amrit Sarker**  
For questions or collaboration, feel free to reach out!

---
