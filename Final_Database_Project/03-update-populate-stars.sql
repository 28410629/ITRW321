--RESET FOR update
DELETE FROM FACT_SUBTYPES;
DELETE FROM FACT_SALARYPAID;
DELETE FROM FACT_READING;
DELETE FROM DIM_SUBSCRIPTION;
DELETE FROM DIM_CUSTOMER;
DELETE FROM DIM_SALARY;
DELETE FROM DIM_EMPLOYEE;
DELETE FROM DIM_TIME;
DELETE FROM DIM_LOCATION;
DELETE FROM DIM_STATION;

--##################READINGS STAR SCHEME####################
--------------------------------------------------------------------------------
--Populate DIM_TIME
--------------------------------------------------------------------------------
INSERT INTO DIM_TIME (time_id, hour, day, week, month, year)
SELECT DISTINCT
    READING_DATE,
    TO_CHAR(READING_DATE, 'HH24') AS HOUR,
    EXTRACT (day FROM READING_DATE) AS DAY,
    to_number(to_char(READING_DATE,'ww')) AS WEEK,
    EXTRACT (month FROM READING_DATE) AS MONTH,
    EXTRACT (year FROM READING_DATE) AS YEAR
FROM STATIONREADING;
--------------------------------------------------------------------------------
--Populate DIM_STATION
--------------------------------------------------------------------------------
INSERT INTO DIM_LOCATION
    SELECT location.locationid, location.locationname
    FROM location;

--------------------------------------------------------------------------------
--Populate DIM_STATION
--------------------------------------------------------------------------------
INSERT INTO DIM_STATION
    SELECT station.stationid, station.isactive
    FROM station;
--------------------------------------------------------------------------------
--Populate FACT_READING
--------------------------------------------------------------------------------
INSERT INTO FACT_READING
SELECT s.station_id, l.location_id, t.time_id,
    NVL((
        SELECT AVG(stationreading.air_pressure)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
    ),0) A,
    NVL((
        SELECT AVG(stationreading.ambient_light)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
    ),0) L,
    NVL((
        SELECT AVG(stationreading.humidity)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
   ),0) H,
    NVL((
        SELECT AVG(stationreading.temperature)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
    ),0)T
FROM dim_station s, dim_location l, dim_time t
WHERE (
        SELECT AVG(stationreading.air_pressure)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
       ) IS NOT NULL AND
       (
        SELECT AVG(stationreading.ambient_light)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
       ) IS NOT NULL AND
       (
        SELECT AVG(stationreading.humidity)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
       ) IS NOT NULL AND
       (
        SELECT AVG(stationreading.temperature)
        FROM stationreading
        WHERE stationid = s.station_id
        AND stationreading.READING_DATE = T.TIME_ID
       ) IS NOT NULL;
--------------------------------------------------------------------------------
--###################SUBTYPE STAR SCHEME####################
--------------------------------------------------------------------------------
--Populate DIM_SUBSCRIPTION
--------------------------------------------------------------------------------
INSERT INTO DIM_SUBSCRIPTION
SELECT  c.subscription_type AS "Subscription_Type",
        (SELECT NAME FROM SUBSCRIPTION WHERE Subscription_Type = C.Subscription_Type) AS NAME
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.subscription_type, 2;
--------------------------------------------------------------------------------
--Populate DIM_CUSTOER
--------------------------------------------------------------------------------
INSERT INTO DIM_CUSTOMER
SELECT  c.personid AS "Person_ID",
        p.birth_date AS "Birth_Date"
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.personid,
            p.birth_date;
--------------------------------------------------------------------------------
--Populate FACT_SUBTYPE
--------------------------------------------------------------------------------
INSERT INTO FACT_SUBTYPES
SELECT  p.personid AS "Person_ID",
        c.subscription_type AS "Subscription_Type"
FROM    PERSON p,
        CUSTOMER c,
        SUBSCRIPTION s
WHERE   c.PersonID = p.PersonID
        AND c.subscription_type = s.subscription_type
GROUP BY    p.personid,
            c.subscription_type;
--------------------------------------------------------------------------------

--###################SUBTYPE STAR SCHEME####################
--------------------------------------------------------------------------------
-----------------Populate DIM_EMPLOYEE
--------------------------------------------------------------------------------
INSERT INTO DIM_EMPLOYEE
SELECT  p.personid AS "Person_ID",
        e.positiontype AS "Employee Position Type"
FROM    PERSON p,
        EMPLOYEE e
WHERE   e.PersonID = p.PersonID
GROUP BY    p.personid,
            e.positiontype;
--------------------------------------------------------------------------------
--Populate DIM_SALARY
--------------------------------------------------------------------------------
INSERT INTO DIM_SALARY
SELECT  s.salaryid AS "Salary_ID",
        AVG(s.amount) AS "Salary_Amount"
FROM    PERSON p,
        EMPLOYEE e,
        SALARY s
WHERE   e.PersonID = p.PersonID AND
        s.personid = e.personid
GROUP BY    s.salaryid;
--------------------------------------------------------------------------------
--Populate FACT_SALARYPAID
--------------------------------------------------------------------------------
INSERT INTO FACT_SALARYPAID
SELECT  e.person_id AS "Person_ID",
        s.salary_id AS "Salary_ID",
        t.time_id AS "Time_ID"
FROM    DIM_EMPLOYEE e,
        DIM_SALARY s,
        DIM_TIME t
GROUP BY    e.person_id,
            s.salary_id,
            t.time_id;
--------------------------------------------------------------------------------
