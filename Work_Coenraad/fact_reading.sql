INSERT INTO FACT_READING
(
SELECT S.STATION_ID, S.LOCATION_ID, 
    /* Create time id for use for insert */
    SYSDATE
, (
    /* Nested query for air pressure for a station id. */
    SELECT AVG(AIR_PRESSURE)
    FROM STATIONREADING
    WHERE STATIONID = S.STATIONID
), (
    /* Nested query for ambient light for a station id. */
    SELECT AVG(AIR_PRESSURE)
    FROM STATIONREADING
    WHERE STATIONID = S.STATIONID
), (
    /* Nested query for humdity for a station id. */
    SELECT AVG(AIR_PRESSURE)
    FROM STATIONREADING
    WHERE STATIONID = S.STATIONID
), (
    /* Nested query for temperature for a station id. */
    SELECT AVG(AIR_PRESSURE)
    FROM STATIONREADING
    WHERE STATIONID = S.STATIONID
)
FROM STATIONREADING R
JOIN STATION S
ON S.STATIONID = R.STATIONID
GROUP BY S.STATIONID, S.STATION_ID, S.LOCATION_ID, SYSDATE
);