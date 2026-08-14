## Dataset Overview

The source file is hospital_admissions_raw.csv. It contains 108 rows and 11 columns, including patient information and hospital admission details.

The dataset is completely synthetic and contains 100 unique admission events and 8 intentional duplicate admission entries.

## Column Understanding

| # | Column | My Understanding |
|---:|---|---|
| 1 | `patient_id` | Identifies the patient within the hospital system. |
| 2 | `first_name` | Patient's first name. |
| 3 | `surname` | Patient's surname. |
| 4 | `national_id` | Fabricated national identification number. |
| 5 | `date_of_birth` | Patient's date of birth. |
| 6 | `disease` | Diagnosis recorded at admission. |
| 7 | `severity` | How severe the patient's condition is: low, medium or high. |
| 8 | `admission_status` | Shows whether the patient was admitted or not admitted. |
| 9 | `ward` | Ward assigned to the patient when applicable. |
| 10 | `admission_date` | Date of the admission event. |
| 11 | `discharge_date` | Date the patient was discharged, where applicable. |


## Initial Observations

From my initial look at the data, I noticed that some ward values are N/A, mainly where the patient was marked as Not Admitted. I also noticed blank discharge_date values for some of these records.

I will confirm these relationships through SQL rather than assuming they are data-quality errors.

## Admission Event

A patient can have more than one admission, so patient_id alone cannot identify a unique admission.

For this dataset, the natural key is:

(patient_id, admission_date)

This will be important when identifying duplicates and creating the curated table.