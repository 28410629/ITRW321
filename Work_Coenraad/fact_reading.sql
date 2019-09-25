/* Removes facts from fact_reading for update */
DELETE FROM fact_reading;

/* Ensure that location dimension is up to date */
DELETE FROM dim_location;

INSERT INTO dim_location
    SELECT location.locationid, location.locationname
    FROM location;
    
/* Ensure that station dimension is up to date */
DELETE FROM dim_station;

INSERT INTO dim_station
    SELECT station.stationid, station.isactive
    FROM station;

/* Populate fact table */
DECLARE
    l_today_date DATE := SYSDATE;
    l_today_timestamp TIMESTAMP := SYSTIMESTAMP;
BEGIN
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
    INSERT INTO fact_reading
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
    FROM stationreading r
    FULL OUTER JOIN station s
    ON s.stationid = r.stationid 
    GROUP BY s.stationid, s.locationid, l_today_date;
END;
