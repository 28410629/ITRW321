DECLARE
    l_today_date DATE := SYSDATE;
    l_today_timestamp TIMESTAMP := SYSTIMESTAMP;
BEGIN
    time := SYSDATE;
    INSERT INTO DIM_TIME (time_id, hour, day, week, month, year)
    VALUES    
    (
        l_today_date, 
        EXTRACT (hour FROM l_today_timestamp),
        EXTRACT (day FROM l_today_date),
        EXTRACT (month FROM l_today_date),
        EXTRACT (month FROM l_today_date),
        EXTRACT (year FROM l_today_date)
    );
    INSERT INTO FACT_READING
    (
        SELECT s.stationid, s.locationid, l_today_date, (
            /* Nested query for air pressure for a station id. */
            SELECT AVG(stationreading.air_pressure)
            FROM stationreading
            WHERE stationid = s.stationid
        ), (
            /* Nested query for ambient light for a station id. */
            SELECT AVG(stationreading.ambient_light)
            FROM stationreading
            WHERE stationid = s.stationid
        ), (
            /* Nested query for humdity for a station id. */
            SELECT AVG(stationreading.humidity)
            FROM stationreading
            WHERE stationid = s.stationid
        ), (
            /* Nested query for temperature for a station id. */
            SELECT AVG(stationreading.temperature)
            FROM stationreading
            WHERE stationid = s.stationid
    )
    FROM stationreading R
    JOIN station S
    ON s.stationid = r.stationid
    GROUP BY s.stationid, s.locationid, l_today_date
    );
END;
