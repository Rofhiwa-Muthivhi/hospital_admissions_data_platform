## Data Quality

The purpose of this stage is to investigate the issues identified during data profiling and determine whether they are actual data-quality problems or expected business rules.

## 1. Admission Status and Ward

#### Question
Do patients who were not admitted have no ward assigned?

#### Result
The results show that all 63 admitted records have an assigned ward, while all 45 not-admitted records have `N/A` as the ward.

#### Finding
The `N/A` ward values appear to be intentional rather than missing data. They correspond to patients who were not admitted.
No inconsistency was identified in this check.

## 2. Admission Status and Discharge Date

#### Question
Do patients who were not admitted have a missing discharge date?

#### Result
All 63 admitted records have a discharge date, while all 45 not-admitted records have a missing discharge date.

#### Finding
The missing discharge dates appear to be expected because these patients were not admitted and therefore did not have a hospital stay.
No inconsistency was identified in this check.

## 3. Admission and Discharge Date Validation

#### Question
Are any patients discharged before their admission date?

#### Why I performed this check
I performed this check to make sure the admission and discharge dates follow a logical sequence. A discharge date should not occur before the admission date.

#### Result
The query returned 0 records.

#### Finding
No invalid admission and discharge date sequences were found in the raw data. The date relationship is consistent for the records checked.