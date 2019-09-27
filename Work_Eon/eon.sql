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

-----------------Subype Fact Table

-----------------Populate Subscription Dimension

INSERT INTO dim_subscription
SELECT  c.subscription_type AS "Subscription_Type",
        p.firstname ||' '|| p.LastName AS "Name"
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.subscription_type,
            p.firstname ||' '|| p.LastName;

-----------------Populate Customer Dimension

INSERT INTO DIM_CUSTOMER
SELECT  c.personid AS "Person_ID",
        p.birth_date AS "Birth_Date"
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.personid,
            p.birth_date;


-----------------Populate Subtypes Fact Table

INSERT INTO fact_subtypes
SELECT  p.personid AS "Person_ID",
        c.subscription_type AS "Subscription_Type"
FROM    PERSON p,
        CUSTOMER c,
        SUBSCRIPTION s
WHERE   c.PersonID = p.PersonID
        AND c.subscription_type = s.subscription_type
GROUP BY    p.personid,
            c.subscription_type;

-----------------Salary Paid Fact Table

-----------------Populate Employee Dimension

INSERT INTO DIM_EMPLOYEE
SELECT  p.personid AS "Person_ID",
        e.positiontype AS "Employee Position Type"
FROM    PERSON p,
        EMPLOYEE e
WHERE   e.PersonID = p.PersonID
GROUP BY    p.personid,
            e.positiontype;

-----------------Populate Salary Dimension

INSERT INTO DIM_SALARY
SELECT  s.salaryid AS "Salary_ID",
        AVG(s.amount) AS "Salary_Amount"
FROM    PERSON p,
        EMPLOYEE e,
        SALARY s
WHERE   e.PersonID = p.PersonID AND
        s.personid = e.personid
GROUP BY    s.salaryid;

-----------------Populate SalaryPaid Fact Table

INSERT INTO FACT_SALARYPAID
SELECT  p.personid AS "Person_ID",
        s.salaryid AS "Salary_ID",
        t.timeid AS "Time_ID"
FROM    PERSON p,
        EMPLOYEE e,
        SALARY s,
        DIM_TIME t
WHERE   e.PersonID = p.PersonID
        AND s.personid = e.personid
GROUP BY    p.personid,
            s.salaryid,
            t.time_id;

-----------------Average area air pressure view
-------Unsure which is correct

CREATE OR REPLACE VIEW area_air_pressure_view AS
SELECT  DISTINCT l.location_name,
        f.time_id,f.avg_airpressure
FROM    FACT_READING f, DIM_TIME t,
        DIM_STATION s, DIM_LOCATION l
WHERE   f.location_id = l.location_id AND
        f.time_id = t.time_id
ORDER BY l.location_name ASC;

-------OR though the following one does not work when i try to create a view

CREATE OR REPLACE VIEW area_air_pressure_view AS
SELECT  DISTINCT l.location_name,
        f.time_id,AVG(f.avg_airpressure)
FROM    FACT_READING f, DIM_TIME t,
        DIM_STATION s, DIM_LOCATION l
WHERE   f.location_id = l.location_id AND
        f.time_id = t.time_id
GROUP BY l.location_name, f.time_id;

-----------------Average station air pressure view

CREATE OR REPLACE VIEW station_air_pressure_view AS
SELECT  DISTINCT s.station_id,
        f.time_id,f.avg_airpressure
FROM    FACT_READING f, DIM_TIME t,
        DIM_STATION s, DIM_LOCATION l
WHERE   f.station_id = s.station_id AND
        f.time_id = t.time_id
ORDER BY s.station_id ASC;

-----------------Average age of customer subscription view

CREATE OR REPLACE VIEW avg_sub_age_view  AS
SELECT      s.name AS "Subscription", AVG(ROUND((SYSDATE - c.birth_date)/365,0)) AS "Age"
FROM        (DIM_SUBSCRIPTION s JOIN FACT_SUBTYPES f ON s.sub_id = f.sub_id)
            JOIN DIM_CUSTOMER c on f.person_id = c.person_id
GROUP BY    s.name;
