USE hospital;
GO

-- ============================================
-- Hospital Admissions Deduplication
-- ============================================

-- How can I number each record within the same admission event?
SELECT patient_id,
       admission_date,
       ward,

    ROW_NUMBER() OVER (
        PARTITION BY patient_id, admission_date
        ORDER BY patient_id
    ) AS admission_row_number

FROM [hospital].[dbo].[hospital_admissions_raw]
ORDER BY patient_id,admission_date;
GO


-- ============================================
-- Compare Duplicate Admission Records
-- ============================================

-- Which fields contain different values within the same admission event?
SELECT patient_id,
       admission_date,
       COUNT(*) AS record_count,

       COUNT(DISTINCT first_name) AS first_name_versions,
       COUNT(DISTINCT surname) AS surname_versions,
       COUNT(DISTINCT national_id) AS national_id_versions,
       COUNT(DISTINCT date_of_birth) AS date_of_birth_versions,
       COUNT(DISTINCT disease) AS disease_versions,
       COUNT(DISTINCT severity) AS severity_versions,
       COUNT(DISTINCT admission_status) AS admission_status_versions,
       COUNT(DISTINCT ward) AS ward_versions,
       COUNT(DISTINCT discharge_date) AS discharge_date_versions
FROM [hospital].[dbo].[hospital_admissions_raw]
GROUP BY patient_id,admission_date
HAVING COUNT(*) > 1
ORDER BY patient_id,admission_date;
GO


-- ============================================
-- Create Deduplicated Admission Records
-- ============================================

-- Which record should be retained for each patient admission event?
WITH ranked_admissions AS
(
    SELECT
        patient_id,
        first_name,
        surname,
        national_id,
        date_of_birth,
        disease,
        severity,
        admission_status,
        ward,
        admission_date,
        discharge_date,

        ROW_NUMBER() OVER (
            PARTITION BY patient_id, admission_date
            ORDER BY patient_id
        ) AS admission_row_number

    FROM [hospital].[dbo].[hospital_admissions_raw]
)

SELECT patient_id,
       first_name,
       surname,
       national_id,
       date_of_birth,
       disease,
       severity,
       admission_status,
       ward,
       admission_date,
       discharge_date

FROM ranked_admissions
WHERE admission_row_number = 1;
GO