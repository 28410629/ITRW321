--RESET FOR update
DELETE FROM 
  FACT_SUBTYPES;
DELETE FROM 
  FACT_SALARYPAID;
DELETE FROM 
  FACT_READING;
DELETE FROM 
  DIM_SUBSCRIPTION;
DELETE FROM 
  DIM_CUSTOMER;
DELETE FROM 
  DIM_SALARY;
DELETE FROM 
  DIM_EMPLOYEE;
DELETE FROM 
  DIM_TIME;
DELETE FROM 
  DIM_LOCATION;
DELETE FROM 
  DIM_STATION;
DELETE FROM 
  DIM_TIME_SALARY;
--------------------------------------------------------------------------------
--  Populate DIM_TIMES
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
--  Populate second time table
--------------------------------------------------------------------------------
INSERT INTO DIM_TIME_SALARY (time_id, hour, day, week, month, year)
SELECT DISTINCT
    DATEPAID,
    TO_CHAR(DATEPAID, 'HH24') AS HOUR,
    EXTRACT (day FROM DATEPAID) AS DAY,
    to_number(to_char(DATEPAID,'ww')) AS WEEK,
    EXTRACT (month FROM DATEPAID) AS MONTH,
    EXTRACT (year FROM DATEPAID) AS YEAR
FROM SALARY;
--------------------------------------------------------------------------------
--  Populate DIM_location
--------------------------------------------------------------------------------
INSERT INTO DIM_LOCATION 
SELECT 
  location.locationid, 
  location.locationname 
FROM 
  location;
--------------------------------------------------------------------------------
--  Populate DIM_STATION
--------------------------------------------------------------------------------
INSERT INTO DIM_STATION 
SELECT 
  station.stationid, 
  station.isactive 
FROM 
  station;
--------------------------------------------------------------------------------
--  Populate FACT_READING
--------------------------------------------------------------------------------
INSERT INTO FACT_READING
SELECT DISTINCT s.stationid, s.locationid, r.reading_date,
    NVL((
        SELECT AVG(stationreading.air_pressure)
        FROM stationreading
        WHERE stationid = s.stationid
        AND stationreading.READING_DATE = r.reading_date
    ),0) A,
    NVL((
        SELECT AVG(stationreading.ambient_light)
        FROM stationreading
        WHERE stationid = s.stationid
        AND stationreading.READING_DATE = r.reading_date
    ),0) L,
    NVL((
        SELECT AVG(stationreading.humidity)
        FROM stationreading
        WHERE stationid = s.stationid
        AND stationreading.READING_DATE = r.reading_date
   ),0) H,
    NVL((
        SELECT AVG(stationreading.temperature)
        FROM stationreading
        WHERE stationid = s.stationid
        AND stationreading.READING_DATE = r.reading_date
    ),0)T
FROM station  s JOIN stationreading r
ON s.stationid = r.stationid;
--------------------------------------------------------------------------------
--  Populate DIM_SUBSCRIPTION
--------------------------------------------------------------------------------
INSERT INTO DIM_SUBSCRIPTION 
SELECT 
  c.subscription_type AS "SUB_ID", 
  c.name AS "NAME" 
FROM 
  SUBSCRIPTION c 
GROUP BY 
  c.subscription_type, 
  c.name;
--------------------------------------------------------------------------------
--Populate DIM_CUSTOER
--------------------------------------------------------------------------------
INSERT INTO DIM_CUSTOMER 
SELECT 
  c.personid AS "Person_ID", 
  p.birth_date AS "Birth_Date" 
FROM 
  PERSON p, 
  CUSTOMER c 
WHERE 
  c.PersonID = p.PersonID 
GROUP BY 
  c.personid, 
  p.birth_date;
--------------------------------------------------------------------------------
--  Populate FACT_SUBTYPE
--------------------------------------------------------------------------------
INSERT INTO FACT_SUBTYPES 
SELECT 
  p.personid AS "Person_ID", 
  c.subscription_type AS "Subscription_Type" 
FROM 
  PERSON p, 
  CUSTOMER c, 
  SUBSCRIPTION s 
WHERE 
  c.PersonID = p.PersonID 
  AND c.subscription_type = s.subscription_type 
GROUP BY 
  p.personid, 
  c.subscription_type;
--------------------------------------------------------------------------------
--  Populate DIM_EMPLOYEE
--------------------------------------------------------------------------------
INSERT INTO DIM_EMPLOYEE 
SELECT 
  p.personid AS "Person_ID", 
  e.positiontype AS "Employee Position Type" 
FROM 
  PERSON p, 
  EMPLOYEE e 
WHERE 
  e.PersonID = p.PersonID 
GROUP BY 
  p.personid, 
  e.positiontype;
--------------------------------------------------------------------------------
--Populate DIM_SALARY
--------------------------------------------------------------------------------
INSERT INTO DIM_SALARY 
SELECT 
  s.salaryid AS "Salary_ID", 
  AVG(s.amount) AS "Salary_Amount" 
FROM 
  PERSON p, 
  EMPLOYEE e, 
  SALARY s 
WHERE 
  e.PersonID = p.PersonID 
  AND s.personid = e.personid 
GROUP BY 
  s.salaryid;
--------------------------------------------------------------------------------
--Populate FACT_SALARYPAID
--------------------------------------------------------------------------------
INSERT INTO FACT_SALARYPAID 
SELECT 
  E.PERSON_ID AS "Person_ID", 
  S.SALARYID AS "Salary_ID", 
  S.DATEPAID AS "Time_ID" 
FROM 
  DIM_EMPLOYEE E, 
  SALARY S 
WHERE 
  E.PERSON_ID = S.PERSONID 
GROUP BY 
  E.PERSON_ID, 
  S.SALARYID, 
  S.DATEPAID;
--------------------------------------------------------------------------------
