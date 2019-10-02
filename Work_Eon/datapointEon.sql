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
-- Average air pressure per lcoation per all years
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




SELECT      s.name AS "Subscription", AVG(ROUND((SYSDATE - c.birth_date)/365,0)) AS "Average Age"
FROM        (DIM_SUBSCRIPTION s JOIN FACT_SUBTYPES f ON s.sub_id = f.sub_id)
            JOIN DIM_CUSTOMER c on f.person_id = c.person_id
GROUP BY    s.name;
