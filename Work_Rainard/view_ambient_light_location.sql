CREATE OR REPLACE VIEW area_ambient_light_view AS 
SELECT DISTINCT l.location_name, f.time_id, f.avg_ambientlight 
FROM FACT_READING f, DIM_TIME t, DIM_STATION s, DIM_LOCATION l 
WHERE f.location_id = l.location_id 
AND f.time_id = t.time_id 
ORDER BY l.location_name 
ASC; 
 
 