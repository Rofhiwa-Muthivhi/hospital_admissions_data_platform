USE hospital;
GO

-- ============================================
-- Hospital Admissions Data Profiling
-- ============================================

-- How many records were loaded into the raw admissions table?
SELECT COUNT(*) AS total_rows
FROM [hospital].[dbo].[hospital_admissions_raw];
GO

-- How many unique patients are represented in the raw admissions data?
SELECT COUNT(DISTINCT patient_id) AS unique_patients
FROM [hospital].[dbo].[hospital_admissions_raw];
GO

-- What is the date range covered by the hospital admissions?
SELECT MIN(admission_date) AS earliest_admission_date,
       MAX(admission_date) AS latest_admission_date
FROM [hospital].[dbo].[hospital_admissions_raw];
GO

-- What is the date range covered by patient discharges?
SELECT MIN(discharge_date) AS earliest_discharge_date,
       MAX(discharge_date) AS latest_discharge_date
FROM [hospital].[dbo].[hospital_admissions_raw];
GO

-- ============================================
-- Categorical Data Profiling
-- ============================================

-- How are patients distributed across the different severity levels?
SELECT severity,
       COUNT(*) AS record_count
FROM [hospital].[dbo].[hospital_admissions_raw]
GROUP BY severity
ORDER BY record_count DESC;
GO

-- How many patients were admitted compared with those who were not admitted?
SELECT admission_status,
     COUNT(*) AS record_count
FROM [hospital].[dbo].[hospital_admissions_raw]
GROUP BY admission_status
ORDER BY record_count DESC;
GO

-- How are admissions distributed across the different wards?
SELECT ward,
       COUNT(*) AS record_count
FROM [hospital].[dbo].[hospital_admissions_raw]
GROUP BY ward
ORDER BY record_count DESC;
GO

-- Which diseases appear most frequently in the raw admissions data?
SELECT disease,
       COUNT(*) AS record_count
FROM [hospital].[dbo].[hospital_admissions_raw]
GROUP BY disease
ORDER BY record_count DESC;
GO


-- ============================================
-- Missing Value Profiling
-- ============================================

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN patient_id IS NULL OR LTRIM(RTRIM(patient_id)) = '' THEN 1 ELSE 0 END) AS patient_id_missing,
    SUM(CASE WHEN first_name IS NULL OR LTRIM(RTRIM(first_name)) = '' THEN 1 ELSE 0 END) AS first_name_missing,
    SUM(CASE WHEN surname IS NULL OR LTRIM(RTRIM(surname)) = '' THEN 1 ELSE 0 END) AS surname_missing,
    SUM(CASE WHEN national_id IS NULL OR LTRIM(RTRIM(national_id)) = '' THEN 1 ELSE 0 END) AS national_id_missing,
    SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_missing,
    SUM(CASE WHEN disease IS NULL OR LTRIM(RTRIM(disease)) = '' THEN 1 ELSE 0 END) AS disease_missing,
    SUM(CASE WHEN severity IS NULL OR LTRIM(RTRIM(severity)) = '' THEN 1 ELSE 0 END) AS severity_missing,
    SUM(CASE WHEN admission_status IS NULL OR LTRIM(RTRIM(admission_status)) = '' THEN 1 ELSE 0 END) AS admission_status_missing,
    SUM(CASE WHEN ward IS NULL OR LTRIM(RTRIM(ward)) = '' THEN 1 ELSE 0 END) AS ward_missing,
    SUM(CASE WHEN admission_date IS NULL THEN 1 ELSE 0 END) AS admission_date_missing,
    SUM(CASE WHEN discharge_date IS NULL THEN 1 ELSE 0 END) AS discharge_date_missing
FROM [hospital].[dbo].[hospital_admissions_raw];
GO