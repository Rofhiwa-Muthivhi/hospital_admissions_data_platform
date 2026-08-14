# Deduplication

The raw hospital admissions table contains 108 records, but the project specification states that there are 100 unique admission events and 8 duplicate admission entries.

The purpose of this stage was to identify the duplicate admission records and build the logic needed to retain one record for each admission event.

## 1. Numbering Admission Records

I first used `ROW_NUMBER()` with `PARTITION BY patient_id, admission_date` to group records belonging to the same admission event and assign a number to each record.

The natural key for an admission event is:

`(patient_id, admission_date)`

This allowed me to identify which records were the first and subsequent occurrences within the same admission event.

## 2. Comparing Duplicate Records

I then compared the duplicate admission records to understand whether the records contained different values across their columns.

The comparison showed that the duplicate records were repeated admission events, with some differences caused by text formatting such as ward casing.

This confirmed that the duplicates should be handled using the admission event key rather than treating the records as separate admissions.

## 3. Creating the Deduplicated Result

I used a CTE together with `ROW_NUMBER()` to rank the records within each `(patient_id, admission_date)` group.

I then retained only records where:`admission_row_number = 1`

The result returned exactly **100 records**, reducing the raw dataset from 108 records to the expected 100 unique admission events.

The raw table was not changed. The deduplicated result will be used to create the curated `hospital_admissions` table in the next stage.