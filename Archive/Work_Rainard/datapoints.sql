--------------------------------------------------------------------------------
--#################### 1. AVERAGE ambientlight PER lOCATION ########################
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
--#################### 2. AVERAGE HUMIDITY PER STATION ########################
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