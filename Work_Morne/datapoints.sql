--#################### AVERGAE TEMPERATURE PER LOCATION ########################
--------------------------------------------------------------------------------
--Avergae temp per location for ALL TIME
SELECT
    L.LOCATION_NAME,
    AVG(F.AVG_TEMP)
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for PAST HOUR
SELECT
    L.LOCATION_NAME,
    AVG(F.AVG_TEMP)
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-1/24)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for PAST DAY
SELECT
    L.LOCATION_NAME,
    AVG(F.AVG_TEMP)
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-1)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for WEEK
SELECT
    L.LOCATION_NAME,
    AVG(F.AVG_TEMP)
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-7)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
--Avergae temp per location for PAST YEAR
SELECT
    L.LOCATION_NAME,
    AVG(F.AVG_TEMP)
FROM FACT_READING F JOIN DIM_LOCATION L
ON L.LOCATION_ID=F.LOCATION_ID AND F.TIME_ID > (SYSDATE-365)
GROUP BY L.LOCATION_NAME;
--------------------------------------------------------------------------------
