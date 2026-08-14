USE hospital;
GO

-- ============================================ 
-- Hospital Admissions Data Quality Checks
-- ============================================

-- Do all patients who were not admitted have no ward assigned?
SELECT admission_status,
       ward,
       COUNT(*) AS record_count
FROM [hospital].[dbo].[hospital_admissions_raw]
GROUP BY admission_status,ward
ORDER BY admission_status,record_count DESC;
GO

-- Do all patients who were not admitted have a missing discharge date?
SELECT admission_status,
       CASE
          WHEN discharge_date IS NULL THEN 'Missing'
         ELSE 'Present'
      END AS discharge_date_status,
      COUNT(*) AS record_count
FROM [hospital].[dbo].[hospital_admissions_raw]
GROUP BY admission_status,
       CASE
         WHEN discharge_date IS NULL THEN 'Missing'
        ELSE 'Present'
      END
ORDER BY admission_status,discharge_date_status;
GO



-- ============================================
-- Duplicate Admission Event Profiling
-- ============================================

-- How many times does each patient admission event appear?
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
       discharge_date,
       COUNT(*) OVER (
           PARTITION BY patient_id, admission_date
       ) AS admission_record_count
FROM [hospital].[dbo].[hospital_admissions_raw]
ORDER BY patient_id,admission_date;
GO


-- Are any patients discharged before their admission date?
SELECT patient_id,
       admission_status,
       admission_date,
       discharge_date
FROM [hospital].[dbo].[hospital_admissions_raw]
WHERE discharge_date IS NOT NULL AND discharge_date < admission_date;
GO