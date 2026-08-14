USE hospital;
GO

SELECT TOP (1000) [patient_id]
      ,[first_name]
      ,[surname]
      ,[national_id]
      ,[date_of_birth]
      ,[disease]
      ,[severity]
      ,[admission_status]
      ,[ward]
      ,[admission_date]
      ,[discharge_date]
  FROM [hospital].[dbo].[hospital_admissions_raw]

-- Check raw table row count
SELECT COUNT(*) AS raw_row_count
FROM [hospital].[dbo].[hospital_admissions_raw];