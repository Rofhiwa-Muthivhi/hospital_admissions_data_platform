
![Hospital Admissions Data Pipeline Banner](06_assets/banner.png)

## 📌 Project Overview

This project is a hands-on data engineering project focused on building a data pipeline for hospital admissions data.

The goal is to take raw hospital admission data that contains duplicates and potential data quality issues, process it through an ETL pipeline, and produce a clean and reliable dataset that can be used for reporting and analysis.

The project uses a synthetic dataset, so no real patient information is involved.

---

## 🎯 Business Context

A hospital generates data every time a patient visits and goes through the admission process. This data can provide useful information about the patients being served, the diseases they are being treated for, the severity of their conditions, the wards being used, and how long patients stay in the hospital.

For hospital management to make informed decisions, the underlying data needs to be accurate and reliable.

If duplicate or inconsistent admission records are not handled properly, they can lead to inaccurate reporting and misleading insights.

This project focuses on building the data engineering foundation needed to turn raw hospital admission data into trusted data for analysis and reporting.

---

## ❗ Business Problem

The hospital admission data contains duplicate records and potential data quality issues that could affect the accuracy of management reporting.

The challenge is to build a pipeline that can:

* Load the raw admission data without changing the source.
* Identify duplicate admission events.
* Apply the correct natural key for an admission.
* Standardize and validate the data.
* Produce a clean and deduplicated curated dataset.
* Provide reliable data for analysis and reporting.

The final dataset should allow a data analyst to confidently investigate hospital admission patterns and provide useful insights to hospital management.

---

## 🎯 Project Objective

The main objective is to build a reliable ETL pipeline that transforms raw hospital admission data into a clean, deduplicated and reporting-ready dataset.

The pipeline will focus on:

* Data ingestion
* Data quality checks
* Data standardization
* Duplicate detection
* Deduplication
* Data validation
* Curated data preparation
* SQL-based analysis

---

## 🔍 Key Business Questions

Using the curated dataset, the project will investigate questions such as:

* What is the admission rate by severity level?
* Which diseases have the highest number of admitted patients?
* Which wards have the most admissions?
* What is the average length of stay by severity?
* Are there unusual admission outcomes that require further investigation?
* What is the age distribution of admitted patients?

These questions are intended to demonstrate how reliable data can support hospital reporting and operational decision-making.

---

## 🏗️ Project Pipeline

```text
Raw CSV
   ↓
Raw Landing Table
   ↓
Data Quality Checks
   ↓
Duplicate Detection
   ↓
Deduplication / Merge
   ↓
Curated Table
   ↓
SQL Analysis
   ↓
Reporting & Insights
```

The raw dataset contains **108 records**, including deliberate duplicate admission entries. The target curated dataset is **100 unique admission events**.

---

## 📂 Project Structure

```text
hospital_admissions_data_platform/
│
├── 01_dataset/
│
├── 02_project_specification/
│
├── 03_documentation/
│
├── 04_sql/
│
├── 05_assets/
│
└── README.md
```

---

## 🛠️ Tools & Technologies

* SQL Server / SSMS
* SQL
* Git
* GitHub
* Git Bash
* VS Code
* Google Sheets
* Draw.io

---

## 📊 Dataset

The dataset contains 11 columns covering patient information and hospital admission details:

* Patient ID
* First Name
* Surname
* National ID
* Date of Birth
* Disease
* Severity
* Admission Status
* Ward
* Admission Date
* Discharge Date

The data is entirely synthetic and was created specifically for this training project.

---

## 🔑 Natural Key

An important part of the project is identifying what makes one admission event unique.

For this dataset, the natural key is:

```text
(patient_id, admission_date)
```

A patient can have multiple admissions, so `patient_id` alone cannot be used to identify a unique admission event.

---

## 🔐 Data Governance

The dataset used in this project is completely synthetic and does not contain real patient information.

If this pipeline were to be adapted for real hospital data, additional data governance, privacy, security and access-control requirements would need to be reviewed before implementation.

---

## 👤 About This Project

This project is part of my data engineering learning journey. I am using it to strengthen my understanding of ETL pipelines, data quality, SQL, data modelling and building reliable datasets for reporting and decision-making.

My focus is not only on getting the SQL queries to work, but on understanding **why the data needs to be structured and processed in a particular way** and how the final data can support a real business problem.
