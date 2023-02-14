/* This script contains all queries used in cleaning the data used for the project */

use test1;
-- renaming table name
RENAME TABLE weatherdataset TO df;

------------------------------------------------
-- deleting the unwanted rows
DELETE FROM df LIMIT 28;
---------------------------------------------------
SELECT 
    *
FROM
    df;
---------------------------------------------------------------------------------------------------------------------------
/* To make row 1 the colum header, we needed to create a new table and declare the header we wanted
*/
CREATE TABLE draftdata (
    Date TEXT,
    Temp TEXT,
    AvgHum TEXT,
    AvgDPt TEXT,
    AvgBaro TEXT,
    AvgWS TEXT,
    AvgGS TEXT,
    AvgDir TEXT,
    RainfallMonth TEXT,
    RainfallYear TEXT,
    MaxRainPMin TEXT,
    MaxTemp TEXT,
    MinTemp TEXT,
    MaxHum TEXT,
    MinHum TEXT,
    MaxPre TEXT,
    MinPre TEXT,
    MaxWS TEXT,
    MaxGS TEXT,
    MaxHI TEXT,
    Date1 TEXT,
    Month TEXT,
    DiffPre TEXT,
    NewCol TEXT
);  -- creating a new table using the right header
---------------------------------------------------------------------------------------------------------------------------
/* we now insert the records in the previous table into the new table with correct header.
The offset function was used to remove the first row */

insert into draftdata
select * 
from df
limit 10000 offset 1; 
---------------------------------------------------------------------------------------------------------------------------
/* the new table contains records with single quotes, we remove this by creating a new table and insert the 
clean record into it using the INSERT and REPLACE functions*/

CREATE TABLE draftdata1 (
    Date TEXT,
    Temp TEXT,
    AvgHum TEXT,
    AvgDPt TEXT,
    AvgBaro TEXT,
    AvgWS TEXT,
    AvgGS TEXT,
    AvgDir TEXT,
    RainfallMonth TEXT,
    RainfallYear TEXT,
    MaxRainPMin TEXT,
    MaxTemp TEXT,
    MinTemp TEXT,
    MaxHum TEXT,
    MinHum TEXT,
    MaxPre TEXT,
    MinPre TEXT,
    MaxWS TEXT,
    MaxGS TEXT,
    MaxHI TEXT,
    Date1 TEXT,
    Month TEXT,
    DiffPre TEXT,
    NewCol TEXT
);

INSERT INTO draftdata1
SELECT REPLACE(Date, '''', '') as Date,
       REPLACE(Temp, '''', '') as Temp,
	   REPLACE(AvgHum, '''', '') as AvgHum,
	   REPLACE(AvgDPt, '''', '') as AvgDPt,
	   REPLACE(AvgBaro, '''', '') as AvgBaro,
	   REPLACE(AvgWS, '''', '') as AvgWS,
	   REPLACE(AvgGS, '''', '') as AvgGS,
       REPLACE(AvgDir, '''', '') as AvgDir,
       REPLACE(RainfallMonth, '''', '') as RainfallMonth,
       REPLACE(RainfallYear, '''', '') as RainfallYear,
       REPLACE(MaxRainPMin, '''', '') as MaxRainPMin,
       REPLACE(MaxTemp, '''', '') as MaxTemp,
       REPLACE(MinTemp, '''', '') as MinTemp,
       REPLACE(MaxHum, '''', '') as MaxHum,
       REPLACE(MinHum, '''', '') as MinHum,
       REPLACE(MaxPre, '''', '') as MaxPre,
       REPLACE(MinPre, '''', '') as MinPre,
       REPLACE(MaxWS, '''', '') as MaxWS,
       REPLACE(MaxGS, '''', '') as MaxGS,
       REPLACE(MaxHI, '''', '') as MaxHI,
       REPLACE(Date1, '''', '') as Date1,
       REPLACE(Month, '''', '') as Month,
       REPLACE(DiffPre, '''', '') as DiffPre,
       REPLACE(NewCol, '''', '') as NewCol
FROM draftdata;

---------------------------------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    draftdata1;
/* to change the date format to each year, we need to delete the 2022-02-29 records due to two reasons:
1. not able to change the date as changing each reflects on both records
2. since data runs from 2022 to 2033, we are supposed to have three records of leap years (2024,2028,2032)
but the data has only two.

We also need to delete empty rows
*/

DELETE FROM draftdata1 
WHERE
    Date = '2022-02-29' OR Date = ''
    OR Date IS NULL;
---------------------------------------------------------------------------------------------------------------------------
/* deleting duplicate rows*/

DELETE a FROM draftdata1 a
        INNER JOIN
    draftdata1 b 
WHERE
    a.Date < b.Date AND a.Date = b.Date;

---------------------------------------------------------------------------------------------------------------------------
/*
to change the date with year increment, we upate the date in the current column for year increment*/

-- we discovered that the last two records of DiffPre has semicolon, we use the script below to remove them
UPDATE draftdata1 
SET 
    DiffPre = REPLACE(DiffPre, ';', '')
WHERE
    DiffPre LIKE '%;';


SET @year_offset = 2021;
UPDATE draftdata1 
SET 
    Date = DATE_ADD(Date,
        INTERVAL (@year_offset:=IF(MONTH(Date) = 01 AND DAY(Date) = 01,
            @year_offset + 1,
            @year_offset)) - 2022 YEAR);
---------------------------------------------------------------------------------------------------------------------------
/* to change the data type for necessary columns
*/
alter table draftdata1
modify column Date date,
modify column Temp float,
modify column AvgHum float,
modify column AvgDPt float,
modify column AvgBaro float,
modify column AvgWS float,
modify column AvgGS float,
modify column AvgDir float,
modify column RainfallMonth float,
modify column RainfallYear float,
modify column MaxRainPMin float,
modify column MaxTemp float,
modify column MinTemp float,
modify column MaxHum float,
modify column MinHum float,
modify column MaxPre float,
modify column MinPre float,
modify column MaxWS float,
modify column MaxGS float,
modify column MaxHI float,
modify column DiffPre float;
---------------------------------------------------------------------------------------------------------------------------
/*dropping unnecessary columns such as Date1 and NewCol
*/
ALTER TABLE draftdata1
DROP COLUMN Date1,
DROP COLUMN NewCol;

RENAME TABLE draftdata1 TO wd;

SELECT 
    *
FROM
    wd;
