CREATE OR REPLACE VIEW station_humidity_view AS 
SELECT DISTINCT s.station_id, f.time_id, f.avg_humidity 
FROM FACT_READING f, DIM_TIME t, DIM_STATION s, DIM_LOCATION l 
WHERE f.station_id = s.station_id 
AND f.time_id = t.time_id 
ORDER BY s.station_id
ASC; 