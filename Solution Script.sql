/* This script contains the queries for solving all listed requirements in the project:
Weather Forecasting Analysis and Visualisation
*/
------------------------------------------------------------------------------------------------------------------------------------
/* Question 1
Give the count of the minimum number of days for the time when temperature reduced */

SELECT format(COUNT(*),0) as Minimum_No_of_Days
FROM
(
  SELECT 
    Date,
    Temp,
    LAG(Temp) OVER (ORDER BY Date) AS prev_temp
  FROM 
    wd
) AS t
WHERE 
  Temp < prev_temp;
  
---------------------------------------------------------------------------------------------------------------------------
/* Question 2
Find the temperature as Cold / hot by using the case and avg of values of the given data set 
Avg Temp = 44.67*/

SELECT 
    Date,
    Temp,
    CASE
        WHEN
            Temp <= (SELECT 
                    AVG(Temp)
                FROM
                    wd)
        THEN
            'cold'
        ELSE 'hot'
    END AS Temp_Type
FROM
    wd
GROUP BY 1;

---------------------------------------------------------------------------------------------------------------------------
/* Question 3
Can you check for all 4 consecutive days when the temperature was below 30 Fahrenheit*/
SELECT 
    *
FROM
    (SELECT 
        Date, Temp, @row:=IF((Temp < 30), @row + 1, 0) AS row_num
    FROM
        wd, (SELECT @row:=0) r
    ORDER BY Date) t
WHERE
    row_num BETWEEN 1 AND 4;
---------------------------------------------------------------------------------------------------------------------------

/* Question 4
Can you find the maximum number of days for which temperature dropped*/

SELECT 
    MAX(temp_sum) AS Max_No_of_days
FROM
    (SELECT 
        Date,
            Temp,
            @prev_temp AS prev_temp,
            (@sum:=IF((Temp < @prev_temp), @sum + 1, 0)) AS temp_sum,
            (@prev_temp:=Temp) AS _temp
    FROM
        wd, (SELECT @sum:=0, @prev_temp:=NULL) r
    ORDER BY Date) t;

---------------------------------------------------------------------------------------------------------------------------
/* Question 5
Can you find the average of average humidity from the dataset
(should contain the following clauses: group by, order by, date) */

SELECT 
    Date, AVG(AvgHum) AS Average_AVGHum
FROM
    wd
GROUP BY Date
ORDER BY Date;

---------------------------------------------------------------------------------------------------------------------------
/* Question 6
Use the GROUP BY clause on the Date column and make a query to fetch details for average windspeed */

SELECT 
    Date, AvgWS
FROM
    wd
GROUP BY Date;

---------------------------------------------------------------------------------------------------------------------------
/* Question 7
Please add the data in the dataset for 2034 and 2035 as well as forecast predictions for these years  */



---------------------------------------------------------------------------------------------------------------------------
/* Question 8
If the maximum gust speed increases from 55mph, fetch the details for the next 4 days  */
SELECT 
    *
FROM
    wd
WHERE
    MaxGS > 55;

---------------------------------------------------------------------------------------------------------------------------
/* Question 9
Find the number of days when the temperature went below 0 degrees Celsius  
we added a new column and converted the temperature from feh to celcius */

alter table wd
add column Temp_Cel float;

UPDATE wd 
SET 
    Temp_Cel = FORMAT((5 / 9) * (Temp - 32), 2);

SELECT 
    COUNT(*) AS Temp_Below_Zero
FROM
    wd
WHERE
    Temp_Cel < 0;
---------------------------------------------------------------------------------------------------------------------------
/* Question 10
Create another table with a “Foreign key” relation with the existing given data set. */

-- we discovered 2033-07-28 had a duplicate, we introduced the row id and delete the record as well as the new row
alter table wd
add column id int auto_increment primary key;

delete from wd
where id in (
select id from (select id, row_number() over (partition by Date order by Date) as row_num
	from wd) t where row_num > 1);
    
alter table wd
drop column id;
-------------------------------------------------------------------

--  we declare Date column as the primary key
alter table wd
add primary key (Date);

-- create the new temp_info table and referencing date column
CREATE TABLE temp_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Temp_id DATE NOT NULL,
    Temp FLOAT NOT NULL,
    MaxTemp FLOAT NOT NULL,
    MinTemp FLOAT NOT NULL,
    CONSTRAINT tp_info FOREIGN KEY (Temp_id)
        REFERENCES wd (Date)
); 

-- inserting three rows into the new table

insert into temp_info (Temp_id, Temp, MaxTemp, MinTemp)
values ('2027-01-01', 26.9, 34.6, 15.9),
       ('2027-01-02', 35.2, 44.6, 18),
       ('2027-01-03', 39.4, 45.8, 31.9);

SELECT 
    *
FROM
    temp_info;
SELECT 
    *
FROM
    wd;