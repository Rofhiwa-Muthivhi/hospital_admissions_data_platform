# Hospital Admissions Data Pipeline — Student Project

A hands-on data engineering exercise: take a messy, duplicate-riddled hospital
admissions extract and turn it into a clean, deduplicated dataset you can
confidently report on.

The data is **entirely synthetic** — no real patients, no real ID numbers —
built specifically so it contains realistic data quality problems to solve.

---

## What's in this repo

| File | Purpose |
|---|---|
| `hospital_admissions_raw.csv` | Sample data to load. 108 rows: 100 unique patients + 8 duplicate admission entries. |
| `hospital_pipeline.sql` | Reference schema + dedup/merge logic. Don't peek until you've had a go yourself. |
| `hospital_admissions_spec.docx` | Full spec: data dictionary, prerequisites, and the practice questions below. |

---

## What you need before starting

- A SQL engine: Postgres, Snowflake, or SQL Server all work (scripts are written for Postgres; swap syntax as needed)
- A way to load a local CSV into a table (`psql \copy`, `COPY INTO`, or your platform's import tool)
- A query tool/IDE (DBeaver, VS Code with a SQL extension, or your platform's console)
- Comfort with: `SELECT` / `JOIN` / `GROUP BY`, window functions (`ROW_NUMBER`, `PARTITION BY`), and basic date arithmetic

---

## What you need to do

1. **Fork/clone this repo.**
2. **Load `hospital_admissions_raw.csv` into a raw landing table, exactly as provided.** Don't pre-clean it — the duplicates are the point.
3. **Design your own schema and dedup logic** for the curated table before checking the reference in `hospital_pipeline.sql`.
   - Think carefully about what the *natural key* for one admission event actually is.
4. **Run your dedup/merge step** and confirm you land on exactly 100 rows, with no duplicate admission events.
5. **Answer the practice questions below** using your curated table, and commit your queries + answers to this repo (e.g. in an `answers.sql` or `answers.md` file).

---

## Practice questions

### A. Data quality & deduplication
1. How many rows landed in the raw table, and how many remained after dedup? What does the difference tell you?
2. Write a query that finds every duplicate admission entry in the raw table *before* you dedupe it.
3. Why is `(patient_id, admission_date)` the correct natural key here, instead of `patient_id` alone? Describe a scenario where deduping on `patient_id` alone would silently delete a legitimate admission.
4. One duplicate pair in this dataset differs only by ward casing (`"ICU"` vs `"icu"`). What other kinds of near-duplicates (typos, whitespace, date format drift) could break a naive dedup query, and how would you guard against each?
5. Write a query that proves, after your merge runs, no `(patient_id, admission_date)` pair appears twice.

### B. Clinical / operational questions
6. What is the admission rate (Admitted vs Not Admitted) for each severity level (low / medium / high)?
7. Which disease has the highest number of admitted patients?
8. Which ward has the most admissions — does that match what you'd expect given the severity mix?
9. What is the average length of stay (`discharge_date − admission_date`) by severity level?
10. Are there any patients marked "Not Admitted" despite having a high-severity disease? Is that a data quality issue, a business rule exception, or something to flag to a clinician?
11. What is the age distribution (from `date_of_birth`) of admitted patients? Is any age group over- or under-represented?

### C. Pipeline design
12. How would you automate this pipeline to run every time a new CSV of admissions lands? What should trigger a run?
13. How would you detect a *new* kind of duplicate you haven't seen yet (e.g. same `national_id` but a different `patient_id` — a possible registration error) before it reaches the curated table?
14. If this pipeline were pointed at real patient data tomorrow, what would need to change or be reviewed first?

---

## Submission

Push your work to your fork with:
- Your schema + dedup/merge SQL
- Your answers to the practice questions (queries + short written answers)
- A short note on any data quality issue you found that *isn't* covered by the questions above, if you spot one

## A note on the data

This dataset was generated for training purposes only. Names, ID numbers,
diagnoses, and outcomes are all fabricated. If you ever adapt this pipeline
pattern for real patient data, it must go through your organization's data
governance and privacy review first — none of that applies to this practice
dataset, but it will matter the moment real data is involved.
