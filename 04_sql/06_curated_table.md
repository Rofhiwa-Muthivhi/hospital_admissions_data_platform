## Curated Table

After completing the data profiling, data quality checks, and deduplication, I created a curated table called `dbo.hospital_admissions`.

The purpose of the curated table is to have a clean version of the hospital admissions data that can be used for validation and analysis, while keeping the raw table unchanged.

For the deduplication, I used `ROW_NUMBER()` and grouped records by `patient_id` and `admission_date`. This allowed me to identify multiple records for the same admission and keep only one record.

I also compared the duplicate records across the different fields. The results showed that the duplicate records contained the same information, meaning they were actual duplicates rather than different versions of the same admission.


