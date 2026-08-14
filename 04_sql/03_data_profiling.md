# Data Profiling

The purpose of data profiling is to understand what was loaded into the raw table before making any changes to the data.

I am using SQL to establish a baseline for the dataset and identify areas that need further investigation.

## 1)Hospital Amissions
#### Total Number of Raw Records

I ran this query to confirm how many records were loaded into the raw table. This gives me a baseline before any deduplication or transformation takes place.
Result: The raw table contains **108 records**.
This confirms that the raw dataset was loaded successfully and that the duplicate records are still present.

#### Number of Unique Patients

I ran this query to find out how many unique patients are represented in the raw data. I want to compare this with the total number of records to see whether some patients appear more than once.
Result: There are **100 unique patients**.
The difference between 108 records and 100 unique patients shows that some patients appear more than once in the raw table. At this stage, I cannot assume that all repeated patients are duplicates because a patient could have more than one legitimate admission.

#### Admission Date Range

I ran this query to understand the period covered by the admission records. This helps me establish the time range of the dataset before performing further analysis.
Result: The admission dates range from:
- **Earliest:** 2026-01-04
- **Latest:** 2026-08-08

#### Discharge Date Range

I ran this query to understand the period covered by the discharge records and to get an initial view of the relationship between admission and discharge dates.
The discharge dates range from:
- **Earliest:** 2026-01-09
- **Latest:** 2026-08-14
The discharge dates extend beyond the latest admission date, which is expected because patients can be discharged after their admission date.


## 2)Categorical profiling

The categorical profiling shows that the raw dataset contains three severity levels: low, medium and high. There are 63 admitted records and 45 not-admitted records. The ward results show 45 N/A values, which matches the number of not-admitted records. This may indicate that patients who were not admitted were not assigned a ward, but I will confirm this during the data-quality stage. The disease profiling also shows a range of different diagnoses, with Sprained Ankle currently having the highest number of records in the visible results.

## 3)Missing Value Profiling

I ran this query to check for NULL or blank values across the main columns in the raw table. I wanted to understand which fields were actually missing before making any cleaning decisions.
The raw table contains 108 records. No NULL or blank values were found in the patient, demographic, disease, severity, admission status, ward or admission date fields.
The only NULL values were found in **discharge_date**, with 45 records affected.
The ward column returned 0 missing values because the **N/A** values are stored as text rather than NULL.
