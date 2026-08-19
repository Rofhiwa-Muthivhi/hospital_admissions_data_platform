USE hospital;
GO

-- =======================================================================
-- Row Count Validation
-- The subquery counts the rows in the raw and curated tables.
-- The '-' subtracts the curated row count from the raw row count
-- to calculate how many rows were removed during deduplication.
-- AS rows_removed gives the calculated result a meaningful column name.
-- =======================================================================

SELECT
    (SELECT COUNT(*) 
     FROM dbo.hospital_admissions_raw) AS raw_row_count,

    (SELECT COUNT(*) 
     FROM dbo.hospital_admissions) AS curated_row_count,

    (SELECT COUNT(*) 
     FROM dbo.hospital_admissions_raw)
    -
    (SELECT COUNT(*) 
     FROM dbo.hospital_admissions) AS rows_removed;
GO


-- ====================================================
-- Duplicate Validation
-- Check whether any duplicate admission events remain
-- in the curated table after deduplication.
-- ====================================================

SELECT patient_id,
       admission_date,
       COUNT(*) AS record_count
FROM [hospital].[dbo].[hospital_admissions]
GROUP BY patient_id,
         admission_date
HAVING COUNT(*) > 1
ORDER BY patient_id,
         admission_date;
GO

USE hospital;
GO


-- ============================================
-- NULL Validation
-- Check for NULL values in important columns
-- of the curated hospital admissions table.
-- ============================================

SELECT SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) AS patient_id_nulls,
       SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS first_name_nulls,
       SUM(CASE WHEN surname IS NULL THEN 1 ELSE 0 END) AS surname_nulls,
       SUM(CASE WHEN national_id IS NULL THEN 1 ELSE 0 END) AS national_id_nulls,
       SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_nulls,
       SUM(CASE WHEN disease IS NULL THEN 1 ELSE 0 END) AS disease_nulls,
       SUM(CASE WHEN severity IS NULL THEN 1 ELSE 0 END) AS severity_nulls,
       SUM(CASE WHEN admission_status IS NULL THEN 1 ELSE 0 END) AS admission_status_nulls,
       SUM(CASE WHEN ward IS NULL THEN 1 ELSE 0 END) AS ward_nulls,
       SUM(CASE WHEN admission_date IS NULL THEN 1 ELSE 0 END) AS admission_date_nulls,
       SUM(CASE WHEN discharge_date IS NULL THEN 1 ELSE 0 END) AS discharge_date_nulls
FROM [hospital].[dbo].[hospital_admissions];
GO


-- ============================================
-- Data Type Validation
-- Check the data types of all columns
-- in the curated hospital admissions table.
-- ============================================

SELECT COLUMN_NAME,
       DATA_TYPE,
       CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'hospital_admissions' AND TABLE_SCHEMA = 'dbo'
ORDER BY ORDINAL_POSITION;
GO

USE hospital;
GO

-- ============================================
-- Date Validation
-- Check for records where the discharge date
-- occurs before the admission date.
-- ============================================

SELECT patient_id,
       admission_date,
       discharge_date
FROM [hospital].[dbo].[hospital_admissions]
WHERE discharge_date < admission_date
ORDER BY admission_date;
GO

USE hospital;
GO

USE hospital;
GO

-- ============================================
-- Business-Rule Validation
-- Check whether admission status agrees
-- with the discharge date.
-- According to the dataset specification,
-- Not Admitted records should have a blank
-- discharge date.
-- ============================================

SELECT patient_id,
       admission_status,
       admission_date,
       discharge_date
FROM [hospital].[dbo].[hospital_admissions]
WHERE admission_status = 'Not Admitted'
      AND discharge_date IS NOT NULL
ORDER BY patient_id;
GO

-- =====================================================
-- Final Curated-Table Validation
-- Check the final curated table for basic completeness
-- before moving to the analysis stage.
-- =====================================================

SELECT COUNT(*) AS total_records,
       COUNT(DISTINCT patient_id) AS unique_patients,
       COUNT(DISTINCT patient_id + '-' + CONVERT(VARCHAR(10), admission_date, 120)) AS unique_admissions,
       MIN(admission_date) AS earliest_admission,
       MAX(admission_date) AS latest_admission
FROM [hospital].[dbo].[hospital_admissions];
GO

