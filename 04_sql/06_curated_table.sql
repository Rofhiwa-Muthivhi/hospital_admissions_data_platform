USE hospital;
GO

-- ============================================
-- Create Curated Hospital Admissions Table
-- ============================================

-- Create the curated table from the deduplicated admission records
-- Creates a temporary result set where number is assigned to each record.
WITH ranked_admissions AS
(
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

           ROW_NUMBER() OVER (
              PARTITION BY patient_id, admission_date  -- For each patient and addmission date, numner the records starting from 1
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

INTO dbo.hospital_admissions  -- create a new table called hospital_admission and insert the partitioned records in there.

FROM ranked_admissions
WHERE admission_row_number = 1; -- Keep only the first record for each patient_id + admission_date
GO

