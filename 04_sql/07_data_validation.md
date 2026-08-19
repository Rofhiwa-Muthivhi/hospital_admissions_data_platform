# Data Validation

After cleaning and deduplicating the hospital admissions data, I ran a number of validation checks on the curated table to make sure the data was ready for the analysis stage.

## 1. Row Count Validation

I compared the number of records in the raw table with the number of records in the curated table.

The raw table has 108 rows, while the curated table should have 100 rows. I subtracted the curated row count from the raw row count to calculate how many rows were removed during deduplication.

The expected result is 8 rows removed, which represents the duplicate admission entries in the raw data.

## 2. Duplicate Validation

I checked the curated table for duplicate admission events using `patient_id` and `admission_date`.

These two columns are used together because the same patient can have more than one admission on different dates. The query groups the data using these two columns and checks if any combination appears more than once.

The expected result is no records returned, which means that no duplicate admission events remain in the curated table.

## 3. NULL Validation

I checked the important columns in the curated table for NULL values.

The query uses `CASE` statements to count how many NULL values are present in each column. This helps me identify whether important patient and admission information is missing.

## 4. Data Type Validation

I checked the data types of the columns in the curated table using `INFORMATION_SCHEMA.COLUMNS`.

This allows me to confirm the data type and character length of each column and make sure the curated table has the expected structure.

## 5. Date Validation

I checked whether any discharge date occurs before the admission date.

A discharge date should not be earlier than the admission date, so the query returns any records where `discharge_date < admission_date`.

The expected result is no records returned.

## 6. Business-Rule Validation

I checked whether the admission status agrees with the discharge date.

According to the dataset rules, a patient marked as `Not Admitted` should have a blank discharge date. The query therefore looks for `Not Admitted` records where a discharge date is present.

The expected result is no records returned.

## 7. Final Curated-Table Validation

Finally, I checked the overall state of the curated table before moving to the analysis stage.

The query gives me the total number of records, the number of unique patients, the number of unique admissions, and the earliest and latest admission dates.

This gives me a final overview of the curated data and helps confirm that the table is ready for the next stage of the project.
