--------------------------------------------------------------------------------
--#################### 1. AVERGAE TEMPERATURE PER LOCATION ########################
--------------------------------------------------------------------------------

--Avergae temp per location for ALL TIME
SELECT
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for PAST HOUR
--------------------------------------------------------------------------------
SELECT
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-1/24)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for PAST DAY
--------------------------------------------------------------------------------
SELECT
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-1)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for WEEK
--------------------------------------------------------------------------------
SELECT
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-7)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for PAST YEAR
--------------------------------------------------------------------------------
SELECT
    L.LOCATION_NAME AS "Location Name",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-365)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--#################### 2. AVERGAE TEMPERATURE PER STATION ########################
--------------------------------------------------------------------------------

--Avergae temp per active station for ALL TIME
SELECT
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID AND S.ISACTIVE = 1
GROUP BY S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per active station for PAST HOUR
--------------------------------------------------------------------------------
SELECT
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID AND F.TIME_ID > (SYSDATE-1/24) AND S.ISACTIVE = 1
GROUP BY S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per active station for PAST DAY
--------------------------------------------------------------------------------
SELECT
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID AND F.TIME_ID > (SYSDATE-1) AND S.ISACTIVE = 1
GROUP BY S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per active station for PAST WEEK
--------------------------------------------------------------------------------
SELECT
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID AND F.TIME_ID > (SYSDATE-7) AND S.ISACTIVE = 1
GROUP BY S.STATION_ID;
--------------------------------------------------------------------------------
--Avergae temp per active station for PAST YEAR
--------------------------------------------------------------------------------
SELECT
    S.STATION_ID AS "Station ID",
    AVG(F.AVG_TEMP) AS "AVG Temp"
FROM FACT_READING F JOIN DIM_STATION S
ON S.STATION_ID=F.STATION_ID AND F.TIME_ID > (SYSDATE-365) AND S.ISACTIVE = 1
GROUP BY S.STATION_ID;
--------------------------------------------------------------------------------
--#################### 3. TOTAL SALARY PVER TIME PER EMPLOYEE TYPE ################
--------------------------------------------------------------------------------

--Total salary per employee type for ALL TIME
SELECT
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM    (DIM_EMPLOYEE E JOIN FACT_SALARYPAID F ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S ON F.SALARY_ID=S.SALARY_ID
GROUP BY E.POSITION_TYPE;
--------------------------------------------------------------------------------
--Total salary per employee type for PAST HOUR
--------------------------------------------------------------------------------
SELECT
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM    (DIM_EMPLOYEE E JOIN FACT_SALARYPAID F ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S ON F.SALARY_ID=S.SALARY_ID AND F.TIME_ID > (SYSDATE-1/24)
GROUP BY E.POSITION_TYPE;
--------------------------------------------------------------------------------
--Total salary per employee type for PAST DAY
--------------------------------------------------------------------------------
SELECT
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM    (DIM_EMPLOYEE E JOIN FACT_SALARYPAID F ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S ON F.SALARY_ID=S.SALARY_ID AND F.TIME_ID > (SYSDATE-1)
GROUP BY E.POSITION_TYPE;
--------------------------------------------------------------------------------
--Total salary per employee type for PAST WEEK
--------------------------------------------------------------------------------
SELECT
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM    (DIM_EMPLOYEE E JOIN FACT_SALARYPAID F ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S ON F.SALARY_ID=S.SALARY_ID AND F.TIME_ID > (SYSDATE-7)
GROUP BY E.POSITION_TYPE;
--------------------------------------------------------------------------------
--Total salary per employee type for PAST YEAR
--------------------------------------------------------------------------------
SELECT
        E.POSITION_TYPE AS "Employee Type",
        SUM(S.AMOUNT) as "Amount Paid"
FROM    (DIM_EMPLOYEE E JOIN FACT_SALARYPAID F ON E.PERSON_ID=F.PERSON_ID)
JOIN DIM_SALARY S ON F.SALARY_ID=S.SALARY_ID AND F.TIME_ID > (SYSDATE-365)
GROUP BY E.POSITION_TYPE;
--------------------------------------------------------------------------------
--#################### 4. AVERAGE HUMIDITY PER LOCATION ########################
--------------------------------------------------------------------------------

--Avergae humidity per location for ALL TIME
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Avergae humidity per location for PAST HOUR
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-1/24)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Avergae humidity per location for PAST DAY
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-1)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Avergae humidity per location for WEEK
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-7)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Avergae humidity per location for PAST YEAR
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-365)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--#################### 5. AVERAGE HUMIDITY PER STATION ########################
--------------------------------------------------------------------------------

--Avergae humidity per active station for ALL TIME
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Avergae humidity per active station for PAST HOUR
--------------------------------------------------------------------------------
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-1/24)
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Avergae humidity per active station for PAST DAY
--------------------------------------------------------------------------------
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-1)
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Avergae humidity per active station for PAST WEEK
--------------------------------------------------------------------------------
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-7)
GROUP BY s.station_id;
--------------------------------------------------------------------------------
--Avergae humidity per active station for PAST YEAR
--------------------------------------------------------------------------------
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_humidity),2) "Average Humidity"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-365)
GROUP BY s.station_id;

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
--Average humidity per location for PAST DAY
--------------------------------------------------------------------------------
SELECT l.location_name "Location Name", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_location l
ON l.location_id = f.location_id
AND f.time_id > (SYSDATE-1)
GROUP BY l.location_name;
--------------------------------------------------------------------------------
--Average humidity per location for WEEK
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
--Avergae humidity per active station for PAST HOUR
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
SELECT s.station_id "Station ID", ROUND(AVG(f.avg_ambientlight),2) "Average Ambient Light"
FROM fact_reading f
JOIN dim_station s
ON s.station_id = f.station_id
AND s.isactive = 1
AND f.time_id > (SYSDATE-365)
GROUP BY s.station_id;
