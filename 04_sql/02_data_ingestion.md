## Data Ingestion

I loaded the **hospital_admissions_raw.csv** file into SQL Server without pre-cleaning the data.

The raw data was loaded into:

**hospital.dbo.hospital_admissions_raw**
I kept the data as it was provided because the duplicate records are intentionally included in the exercise and need to be handled later in the pipeline.

#### Ingestion Method

I used the SQL Server **Import Flat File** wizard in SSMS to load the CSV into the `hospital` database.

The table was created under the `dbo` schema with the name:`hospital_admissions_raw`

No duplicates were removed and no data-quality transformations were performed during ingestion.

#### Validation
After loading the data, I checked the number of records in the raw table.**Raw records loaded: 108**

This confirms that the raw dataset was successfully loaded and the duplicate records are still present.

