## Weather-Forecasting-Analysis-and-Visualisation

This project shows my scripts and output for the above project. The project was initiated on LinkedIn by Aditya Sharma, which I participated in.

## :bookmark_tabs: Table of Contents
- 📝 About the Project
- 📂 Dataset
- 📙 Case Study Questions
- 🏆 Solution Script


## :memo: About the Project
Weather prediction is one of the most certainly required information in all over the regions. It involves collecting global meteorological surface and upper-air observations, preparing global surface and upper air pressure, temperature, moisture, and wind analyses at frequent time intervals based upon these observations we predict some data for upcoming days weather conditions

## :open_file_folder: Dataset
This data contains day wise weather attributes from 2022 to July 2033 (predicted data)

 <details><summary>View Dataset Columns</summary>
 <p> 

 Columns are as follows :
   - [ ] Date
   - [ ] Average temperature (°F)
   - [ ] Average humidity (%)
   - [ ] Average dewpoint (°F)
   - [ ] Average barometer (in)
   - [ ] Average windspeed (mph)
   - [ ] Average gust speed (mph)
   - [ ] Average direction (°degree)
   - [ ] Rainfall for month (in)
   - [ ] Rainfall for year (in)
   - [ ] Maximum rain per minute
   - [ ] Maximum temperature (°F)
   - [ ] Minimum temperature (°F)
   - [ ] Maximum humidity (%)
   - [ ] Minimum humidity (%)
   - [ ] Maximum pressure
   - [ ] Minimum pressure
   - [ ] Maximum wind speed (mph)
   - [ ] Maximum gust speed (mph)
   - [ ] Maximum heat index (°F)
</p>
</details>

## :closed_book: Data Cleaning Tasks
Each of the following data cleaning tasks were carried out on the data using SQL:

 - Task 1: Correct years for given data set  
 - Task 2: removal of duplicate rows and duplicate columns
 - Task 3: fix a few labels in the given data set 
 - Task 4: encoding data into suitable format

## :closed_book: Case Study Analysis
Each of the following case study questions were derived from the data using SQL:

  1. Give the count of the minimum number of days for the time when temperature reduced.
  2. Find the temperature as Cold / hot by using the case and avg of values of the given data set.
  3. Can you check for all 4 consecutive days when the temperature was below 30 Fahrenheit.
  4. Can you find the maximum number of days for which temperature dropped.
  5. Can you find the average of average humidity from the dataset (NOTE: should contain the following clauses: group by, order by, date).
  6. Use the GROUP BY clause on the Date column and make a query to fetch details for average windspeed.
  7. If the maximum gust speed increases from 55mph, fetch the details for the next 4 days.
  8. Find the number of days when the temperature went below 0 degrees Celsius.
  9. Create another table with a “Foreign key” relation with the existing given data set.


 ## 	:trophy: Solutions
 
  *View the Data Cleaning scripts:* [HERE](https://github.com/ifeoluwa-23/Weather-Forecasting-Analysis-and-Visualisation/blob/main/Data%20Cleaning%20Script.sql)
  
  *View the Case Study Analysis scripts:* [HERE](https://github.com/ifeoluwa-23/Weather-Forecasting-Analysis-and-Visualisation/blob/main/Solution%20Script.sql)
