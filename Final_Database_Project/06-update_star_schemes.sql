
--##################READINGS STAR SCHEME#################### MERGE - DONE
--------------------------------------------------------------------------------
--Update DIM_TIMES
--------------------------------------------------------------------------------
MERGE INTO DIM_TIME T
USING
        (SELECT DISTINCT
            READING_DATE,
            TO_CHAR(READING_DATE, 'HH24') AS HOUR,
            EXTRACT (day FROM READING_DATE) AS DAY,
            to_number(to_char(READING_DATE,'ww')) AS WEEK,
            EXTRACT (month FROM READING_DATE) AS MONTH,
            EXTRACT (year FROM READING_DATE) AS YEAR
            FROM STATIONREADING) R
ON (T.TIME_ID = R.READING_DATE)
WHEN NOT MATCHED THEN
INSERT (time_id, hour, day, week, month, year)
VALUES (R.READING_DATE,
        TO_CHAR(R.READING_DATE, 'HH24'),
        EXTRACT (day FROM R.READING_DATE),
        to_number(to_char(R.READING_DATE,'ww')) ,
        EXTRACT (month FROM R.READING_DATE),
        EXTRACT (year FROM R.READING_DATE));


--Populate second tiem table
MERGE INTO DIM_TIME_SALARY T
USING
        (SELECT DISTINCT
            DATEPAID,
            TO_CHAR(DATEPAID, 'HH24') AS HOUR,
            EXTRACT (day FROM DATEPAID) AS DAY,
            to_number(to_char(DATEPAID,'ww')) AS WEEK,
            EXTRACT (month FROM DATEPAID) AS MONTH,
            EXTRACT (year FROM DATEPAID) AS YEAR
            FROM SALARY) R
ON (T.TIME_ID = R.DATEPAID)
WHEN NOT MATCHED THEN
INSERT (time_id, hour, day, week, month, year)
VALUES (R.DATEPAID,
        TO_CHAR(R.DATEPAID, 'HH24'),
        EXTRACT (day FROM R.DATEPAID),
        to_number(to_char(R.DATEPAID,'ww')) ,
        EXTRACT (month FROM R.DATEPAID),
        EXTRACT (year FROM R.DATEPAID));
--------------------------------------------------------------------------------
--Populate DIM_location
--------------------------------------------------------------------------------
MERGE INTO DIM_LOCATION L
USING
    (SELECT location.locationid, location.locationname
     FROM location) R
ON (L.LOCATION_ID = R.LOCATIONID)
WHEN MATCHED THEN
    UPDATE SET L.LOCATION_NAME = R.LOCATIONNAME
    WHERE L.LOCATION_ID = R.LOCATIONID AND L.LOCATION_NAME <> R.LOCATIONNAME
WHEN NOT MATCHED THEN
    INSERT (LOCATION_ID, LOCATION_NAME)
    VALUES(R.LOCATIONID, R.LOCATIONNAME);



--------------------------------------------------------------------------------
--Populate DIM_STATION
--------------------------------------------------------------------------------
MERGE INTO DIM_STATION S
USING
    (SELECT station.stationid, station.isactive
     FROM station) R
ON (S.STATION_ID = R.STATIONID)
WHEN MATCHED THEN
    UPDATE SET S.ISACTIVE = R.ISACTIVE
    WHERE S.STATION_ID = R.STATIONID AND S.ISACTIVE <> R.ISACTIVE
WHEN NOT MATCHED THEN
    INSERT (STATION_ID, ISACTIVE)
    VALUES(R.STATIONID, R.ISACTIVE);
--------------------------------------------------------------------------------
--Populate FACT_READING
--------------------------------------------------------------------------------

MERGE INTO FACT_READING F
USING
        (SELECT DISTINCT s.stationid, s.locationid, r.reading_date,
            NVL((
                SELECT AVG(stationreading.air_pressure)
                FROM stationreading
                WHERE stationid = s.stationid
                AND stationreading.READING_DATE = r.reading_date
            ),0) AIR,
            NVL((
                SELECT AVG(stationreading.ambient_light)
                FROM stationreading
                WHERE stationid = s.stationid
                AND stationreading.READING_DATE = r.reading_date
            ),0) LIGHT,
            NVL((
                SELECT AVG(stationreading.humidity)
                FROM stationreading
                WHERE stationid = s.stationid
                AND stationreading.READING_DATE = r.reading_date
           ),0) HUMID,
            NVL((
                SELECT AVG(stationreading.temperature)
                FROM stationreading
                WHERE stationid = s.stationid
                AND stationreading.READING_DATE = r.reading_date
            ),0)TEMP
        FROM station  s JOIN stationreading r
        ON s.stationid = r.stationid) R
ON (F.STATION_ID = R.STATIONID AND F.LOCATION_ID=R.LOCATIONID AND F.TIME_ID=R.READING_DATE)
WHEN MATCHED THEN
    UPDATE SET  AVG_AIRPRESSURE = R.AIR,
                AVG_AMBIENTLIGHT = R.LIGHT,
                AVG_HUMIDITY = R.HUMID,
                AVG_TEMP = R.TEMP
    WHERE
                (F.STATION_ID = R.STATIONID AND F.LOCATION_ID=R.LOCATIONID AND F.TIME_ID=R.READING_DATE)
                AND
                (F.AVG_AIRPRESSURE <> R.AIR
                OR F.AVG_AMBIENTLIGHT <> R.LIGHT
                OR F.AVG_HUMIDITY <> R.HUMID
                OR F.AVG_TEMP <> R.TEMP)
WHEN NOT MATCHED THEN
    INSERT(STATION_ID, LOCATION_ID, TIME_ID, AVG_AIRPRESSURE, AVG_AMBIENTLIGHT, AVG_HUMIDITY, AVG_TEMP)
    VALUES(R.STATIONID, R.LOCATIONID, R.READING_DATE, R.AIR, R.LIGHT, R.HUMID, R.TEMP);








--------------------------------------------------------------------------------
--###################SUBTYPE STAR SCHEME####################
--------------------------------------------------------------------------------
--Populate DIM_SUBSCRIPTION
--------------------------------------------------------------------------------
MERGE INTO DIM_SUBSCRIPTION D
USING
    (SELECT SUBSCRIPTION.SUBSCRIPTION_TYPE, SUBSCRIPTION.NAME
    FROM SUBSCRIPTION) S
ON (D.SUB_ID = S.SUBSCRIPTION_TYPE)
WHEN MATCHED THEN
    UPDATE SET D.NAME = S.NAME
    WHERE D.SUB_ID = S.SUBSCRIPTION_TYPE
    AND D.NAME <> S.NAME
WHEN NOT MATCHED THEN
    INSERT (SUB_ID, NAME)
    VALUES (S.SUBSCRIPTION_TYPE, S.NAME);
--------------------------------------------------------------------------------
--Populate DIM_CUSTOER
--------------------------------------------------------------------------------
MERGE INTO DIM_CUSTOMER D
USING
    (SELECT Pe.PERSONID, Pe.BIRTH_DATE
    FROM PERSON Pe JOIN CUSTOMER Cu
    ON Pe.PERSONID = Cu.PERSONID
    WHERE Pe.PERSONTYPE = 'C')  P
ON (D.PERSON_ID = P.PERSONID)
WHEN MATCHED THEN
    UPDATE SET D.BIRTH_DATE = P.BIRTH_DATE
    WHERE D.PERSON_ID = P.PERSONID
    AND D.BIRTH_DATE <> P.BIRTH_DATE
WHEN NOT MATCHED THEN
    INSERT (PERSON_ID, BIRTH_DATE)
    VALUES (P.PERSONID, P.BIRTH_DATE);
--------------------------------------------------------------------------------
--Populate FACT_SUBTYPE
--------------------------------------------------------------------------------
MERGE INTO FACT_SUBTYPES F
  USING
      ( SELECT  p.personid, c.subscription_type
        FROM    PERSON p,
                CUSTOMER c,
                SUBSCRIPTION s
        WHERE   c.PersonID = p.PersonID
        AND     c.subscription_type = s.subscription_type
      ) D
  ON (F.PERSON_ID = D.PERSONID AND F.SUB_ID = D.SUBSCRIPTION_TYPE)
  WHEN NOT MATCHED THEN
      INSERT (Person_ID, SUB_ID)
      VALUES (D.PERSONID, D.SUBSCRIPTION_TYPE);
--------------------------------------------------------------------------------

--###################SUBTYPE STAR SCHEME####################
--------------------------------------------------------------------------------
-----------------Populate DIM_EMPLOYEE
--------------------------------------------------------------------------------
MERGE INTO DIM_EMPLOYEE D
USING
    (SELECT Pe.PERSONID, Em.POSITIONTYPE
    FROM PERSON Pe JOIN EMPLOYEE Em
    ON Pe.PERSONID = Em.PERSONID
    WHERE Pe.PERSONTYPE = 'E')  P
ON (D.PERSON_ID = P.PERSONID)
WHEN MATCHED THEN
    UPDATE SET D.POSITION_TYPE = P.POSITIONTYPE
    WHERE D.PERSON_ID = P.PERSONID
    AND D.POSITION_TYPE <> P.POSITIONTYPE
WHEN NOT MATCHED THEN
    INSERT (PERSON_ID, POSITION_TYPE)
    VALUES (P.PERSONID, P.POSITIONTYPE);
--------------------------------------------------------------------------------
--Populate DIM_SALARY
--------------------------------------------------------------------------------
MERGE INTO DIM_SALARY D
USING
    (SELECT SALARY.SALARYID, SALARY.AMOUNT
    FROM SALARY) S
ON (D.SALARY_ID = S.SALARYID)
WHEN MATCHED THEN
    UPDATE SET D.AMOUNT = S.AMOUNT
    WHERE D.SALARY_ID = S.SALARYID
    AND D.AMOUNT <> S.AMOUNT
WHEN NOT MATCHED THEN
    INSERT (SALARY_ID, AMOUNT)
    VALUES (S.SALARYID, S.AMOUNT);
--------------------------------------------------------------------------------
--Populate FACT_SALARYPAID
--------------------------------------------------------------------------------
MERGE INTO FACT_SALARYPAID F
USING
    (SELECT E.PERSON_ID, S.SALARYID, S.DATEPAID
    FROM    DIM_EMPLOYEE E,
            SALARY S
    WHERE   E.PERSON_ID=S.PERSONID) D
ON (F.PERSON_ID = D.PERSON_ID AND F.Salary_ID=D.SalaryID AND F.TIME_ID = D.DATEPAID)
WHEN NOT MATCHED THEN
    INSERT (PERSON_ID, SALARY_ID, TIME_ID)
    VALUES (D.PERSON_ID, D.SALARYID, D.DATEPAID);
--------------------------------------------------------------------------------
