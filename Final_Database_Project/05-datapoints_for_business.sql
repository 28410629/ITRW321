--------------------------------------------------------------------------------
--#################### 1. AVERGAE TEMPERATURE PER LOCATION #####################
--------------------------------------------------------------------------------
-- average temperature per lcoation per hour
SELECT
    T.HOUR AS "Hours of past day",
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-1
GROUP by T.HOUR, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- average temperature per lcoation per week
SELECT
    T.DAY AS "Days of previous week",
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-7
GROUP by T.DAY, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- average temperature per lcoation per month
SELECT
    T.DAY AS "Days of previous month",
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-30
GROUP by T.DAY, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- average temperature per lcoation per year
SELECT
    T.MONTH AS "Months of previous year",
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-365
GROUP by T.MONTH, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- average temperature per lcoation per all years
SELECT
    T.YEAR AS "Year",
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID
GROUP by T.YEAR, L.LOCATION_NAME;

--------------------------------------------------------------------------------
--#################### 2. AVERGAE TEMPERATURE PER STATION ######################
--------------------------------------------------------------------------------

--Avergae temp per station per hour for last day
SELECT
    T.HOUR AS "Hours of past day",
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-1
GROUP by T.HOUR, S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per station per day for last week
SELECT
    T.DAY AS "Day of past week",
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-7
GROUP by T.DAY, S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per station per day for last month
SELECT
    T.DAY AS "Day of past month",
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-30
GROUP by T.DAY, S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per station per month for last year
SELECT
    T.MONTH AS "Month of past year",
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-365
GROUP by T.MONTH, S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per station per year for all time
SELECT
    T.YEAR AS "Year",
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID
GROUP by T.YEAR, S.STATION_ID;
--------------------------------------------------------------------------------





--------------------------------------------------------------------------------
--#################### 3. TOTAL SALARY PER TIME PER EMPLOYEE TYPE #############
--------------------------------------------------------------------------------

--Total salary per employee type per day for PAST MONTH
SELECT
        T.DAY AS "Day",
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM
(FACT_SALARYPAID F JOIN DIM_EMPLOYEE E
    ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S
    ON F.SALARY_ID=S.SALARY_ID
JOIN DIM_TIME_SALARY T
    ON T.TIME_ID = F.TIME_ID
    AND T.TIME_ID > SYSDATE-30
GROUP BY T.DAY, E.POSITION_TYPE;
--------------------------------------------------------------------------------
--Total salary per employee type per month for PAST YEAR
SELECT
        T.MONTH AS "Month",
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM
(FACT_SALARYPAID F JOIN DIM_EMPLOYEE E
    ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S
    ON F.SALARY_ID=S.SALARY_ID
JOIN DIM_TIME_SALARY T
    ON T.TIME_ID = F.TIME_ID
    AND T.TIME_ID > SYSDATE-365
GROUP BY T.MONTH, E.POSITION_TYPE;
--------------------------------------------------------------------------------
--Total salary per employee type per year for all time
SELECT
        T.YEAR AS "Year",
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM
(FACT_SALARYPAID F JOIN DIM_EMPLOYEE E
    ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S
    ON F.SALARY_ID=S.SALARY_ID
JOIN DIM_TIME_SALARY T
    ON T.TIME_ID = F.TIME_ID
GROUP BY T.YEAR, E.POSITION_TYPE;




--------------------------------------------------------------------------------
--#################### 4. AVERAGE HUMIDITY PER LOCATION ########################
--------------------------------------------------------------------------------

-- average humidity for the last day group in hours
SELECT t.hour AS "Past 24 Hours", l.location_name AS "Location Name", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_LOCATION l
ON l.location_id = f.location_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-1
GROUP BY t.hour, l.location_name;

--------------------------------------------------------------------------------
-- average temperature per lcoation per week
SELECT t.day AS "Past Week's Calendar Days", l.location_name AS "Location Name", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_LOCATION l
ON l.location_id = f.location_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-7
GROUP BY t.day, l.location_name;

--------------------------------------------------------------------------------
-- average temperature per lcoation per month
SELECT t.day AS "Past Month's Calendar Days", l.location_name AS "Location Name", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_LOCATION l
ON l.location_id = f.location_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-30
GROUP BY t.day, l.location_name;

--------------------------------------------------------------------------------
-- average temperature per lcoation per year
SELECT t.month AS "Past Year's Calendar Months", l.location_name AS "Location Name", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_LOCATION l
ON l.location_id = f.location_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-365
GROUP BY t.month, l.location_name;

--------------------------------------------------------------------------------
-- average temperature per lcoation per all years
SELECT t.year AS "All Calendar Years", l.location_name AS "Location Name", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_LOCATION l
ON l.location_id = f.location_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
GROUP BY t.year, l.location_name;


--------------------------------------------------------------------------------
--#################### 5. AVERAGE HUMIDITY PER STATION ########################
--------------------------------------------------------------------------------
--Avergae temp per station per hour for last day

SELECT t.hour AS "Past 24 Hours", s.station_id AS "Station ID", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_STATION s
ON s.station_id = f.station_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-1
GROUP by t.hour, s.station_id;

--------------------------------------------------------------------------------
--Avergae temp per station per day for last week
SELECT t.day AS "Past Week's Calendar Days", s.station_id AS "Station ID", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_STATION s
ON s.station_id = f.station_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-7
GROUP by t.day, s.station_id;

--------------------------------------------------------------------------------
--Avergae temp per station per day for last month
SELECT t.day AS "Past Month's Calendar Days", s.station_id AS "Station ID", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_STATION s
ON s.station_id = f.station_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-30
GROUP by t.day, s.station_id;

--------------------------------------------------------------------------------
--Avergae temp per station per month for last year
SELECT t.month AS "Past Year's Calendar Months", s.station_id AS "Station ID", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_STATION s
ON s.station_id = f.station_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
AND t.time_id > SYSDATE-365
GROUP by t.month, s.station_id;

--------------------------------------------------------------------------------
--Avergae temp per station per year for all time
SELECT t.year AS "All Calendar Years", s.station_id AS "Station ID", AVG(f.avg_humidity) AS "Average Humidity"
FROM FACT_READING f
JOIN DIM_STATION s
ON s.station_id = f.station_id
JOIN DIM_TIME t
ON f.time_id = t.time_id
GROUP by t.year, s.station_id;

--------------------------------------------------------------------------------





--------------------------------------------------------------------------------
--#################### 6. AVERAGE ambientlight PER lOCATION ########################
--------------------------------------------------------------------------------

--Average ambientlight per location for ALL TIME
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Average ambientlight per location for PAST HOUR
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-1/24)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Average ambientlight per location for PAST DAY
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-1)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Average ambientlight per location for WEEK
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-7)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Average ambientlight per location for PAST YEAR
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-365)
GROUP BY l.location_name;







--------------------------------------------------------------------------------
--#################### 7. AVERAGE HUMIDITY PER STATION ########################
--------------------------------------------------------------------------------

--Avergae ambientlight per active station for ALL TIME
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Avergae ambientlight per active station for PAST HOUR
--------------------------------------------------------------------------------
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-1/24)
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Average ambientlight per active station for PAST DAY
--------------------------------------------------------------------------------
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-1)
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Average ambientlight per active station for PAST WEEK
--------------------------------------------------------------------------------
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-7)
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Average ambientlight per active station for PAST YEAR
--------------------------------------------------------------------------------
--Average age per subscription type
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-365)
GROUP BY s.station_id;

--------------------------------------------------------------------------------
--#################### 8. AVERGAE AIR PRESSURE PER LOCATION #####################
--------------------------------------------------------------------------------
-- Average air pressure per lcoation per hour
SELECT T.HOUR AS "Hour of past day", L.LOCATION_NAME AS "Location Name", AVG(F.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-1
GROUP by T.HOUR, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- Average air pressure per lcoation per week
SELECT T.DAY AS "Days of previous week", L.LOCATION_NAME AS "Location Name", AVG(f.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-7
GROUP by T.DAY, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- Average air pressure per lcoation per month
SELECT T.DAY AS "Days of previous month", L.LOCATION_NAME AS "Location Name", AVG(F.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-30
GROUP by T.DAY, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- Average air pressure per lcoation per year
SELECT T.MONTH AS "Months of previous year", L.LOCATION_NAME AS "Location Name", AVG(F.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-365
GROUP by T.MONTH, L.LOCATION_NAME;
--------------------------------------------------------------------------------
-- Average air pressure per lcoation per all time
SELECT T.YEAR AS "Year", L.LOCATION_NAME AS "Location Name", AVG(F.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID
GROUP by T.YEAR, L.LOCATION_NAME;
--------------------------------------------------------------------------------
--#################### 9. AVERGAE AIR PRESSURE PER STATION ######################
--------------------------------------------------------------------------------
--Average air pressure per station per hour for last day
SELECT T.HOUR AS "Hours of past day", S.STATION_ID AS "Station ID", AVG(f.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-1
GROUP by T.HOUR, S.STATION_ID;
--------------------------------------------------------------------------------
--Average air pressure per station per day for last week
SELECT T.DAY AS "Day of past week", S.STATION_ID AS "Station ID", AVG(f.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-7
GROUP by T.DAY, S.STATION_ID;
--------------------------------------------------------------------------------
--Average air pressure per station per day for last month
SELECT T.DAY AS "Day of past month", S.STATION_ID AS "Station ID", AVG(F.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-30
GROUP by T.DAY, S.STATION_ID;
--------------------------------------------------------------------------------
--Average air pressure per station per month for last year
SELECT T.MONTH AS "Month of past year", S.STATION_ID AS "Station ID", AVG(F.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID AND T.TIME_ID > SYSDATE-365
GROUP by T.MONTH, S.STATION_ID;
--------------------------------------------------------------------------------
--Average air pressure per station per year for all time
SELECT T.YEAR AS "Year", S.STATION_ID AS "Station ID", AVG(F.avg_airpressure) AS "Average Air Pressure"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID
JOIN DIM_TIME T
ON F.TIME_ID=T.TIME_ID
GROUP by T.YEAR, S.STATION_ID;
--------------------------------------------------------------------------------
--#################### 10. AVERGAE AGE PER SUBSCRIPTION TYPE ####################
--------------------------------------------------------------------------------
SELECT      s.name AS "Subscription", ROUND(AVG(ROUND((SYSDATE - c.birth_date)/365,0)),0) AS "Average Age"
FROM        (DIM_SUBSCRIPTION s JOIN FACT_SUBTYPES f ON s.sub_id = f.sub_id)
            JOIN DIM_CUSTOMER c on f.person_id = c.person_id
GROUP BY    s.name;
--------------------------------------------------------------------------------
