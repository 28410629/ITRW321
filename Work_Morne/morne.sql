--RESET FOR update
DELETE FROM FACT_SUBTYPES;
DELETE FROM DIM_SUBSCRIPTION;
DELETE FROM DIM_CUSTOMER;


-----------------SUBTYPE STAR SCHEME

-----------------Populate DIM_SUBSCRIPTION

INSERT INTO DIM_SUBSCRIPTION
SELECT  c.subscription_type AS "Subscription_Type",
        (SELECT NAME FROM SUBSCRIPTION WHERE Subscription_Type = C.Subscription_Type) AS NAME
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.subscription_type, 2;

-----------------Populate DIM_CUSTOER

INSERT INTO DIM_CUSTOMER
SELECT  c.personid AS "Person_ID",
        p.birth_date AS "Birth_Date"
FROM    PERSON p,
        CUSTOMER c
WHERE   c.PersonID = p.PersonID
GROUP BY    c.personid,
            p.birth_date;


-----------------Populate FACT_SUBTYPE

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
