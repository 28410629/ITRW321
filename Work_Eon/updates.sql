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
    SELECT  E.PERSON_ID AS "Person_ID",
            S.SALARYID AS "Salary_ID",
            S.DATEPAID AS "Time_ID"
    FROM    DIM_EMPLOYEE E,
            SALARY S
    WHERE E.PERSON_ID=S.PERSONID
    GROUP BY    E.PERSON_ID,
                S.SALARYID,
                S.DATEPAID;
    --------------------------------------------------------------------------------
