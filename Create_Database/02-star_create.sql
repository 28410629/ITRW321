--RESET
DROP TABLE FACT_SALARYPAID;
DROP TABLE FACT_SUBTYPES;
DROP TABLE FACT_READING;
DROP TABLE DIM_STATION;
DROP TABLE DIM_LOCATION;
DROP TABLE DIM_CUSTOMER;
DROP TABLE DIM_SUBSCRIPTION;
DROP TABLE DIM_SALARY;
DROP TABLE DIM_EMPLOYEE;
DROP TABLE DIM_TIME;

--STAR SCHEME 1
CREATE TABLE DIM_STATION (
    "STATION_ID" NUMBER(6,0) PRIMARY KEY,
    "ISACTIVE" NUMBER(1,0)
  );

CREATE TABLE DIM_LOCATION (
  "LOCATION_ID" NUMBER(6, 0) PRIMARY KEY,
  "LOCATION_NAME"  VARCHAR(25)
);

CREATE TABLE DIM_TIME (
  "TIME_ID" DATE PRIMARY KEY,
  "HOUR" NUMBER(6, 0),
  "DAY" NUMBER(6, 0),
  "WEEK" NUMBER(6, 0),
  "MONTH" NUMBER(6, 0),
  "YEAR" NUMBER(6, 0)
);

CREATE TABLE FACT_READING (
  "STATION_ID" NUMBER(6,0),
  "LOCATION_ID" NUMBER(6,0),
  "TIME_ID" DATE,
  "AVG_AIRPRESSURE" NUMBER(8,2),
  "AVG_AMBIENTLIGHT" NUMBER(8,2),
  "AVG_HUMIDITY" NUMBER(8,2),
  "AVG_TEMP" NUMBER(8,2),
  CONSTRAINT FACT_PK PRIMARY KEY (TIME_ID, LOCATION_ID, STATION_ID)
);


ALTER TABLE FACT_READING
ADD CONSTRAINT STATION_FK
FOREIGN KEY("STATION_ID")
REFERENCES DIM_STATION("STATION_ID");

ALTER TABLE FACT_READING
ADD CONSTRAINT LOCATION_FK
FOREIGN KEY("LOCATION_ID")
REFERENCES DIM_LOCATION("LOCATION_ID");

ALTER TABLE FACT_READING
ADD CONSTRAINT TIMEP_FK
FOREIGN KEY("TIME_ID")
REFERENCES DIM_TIME("TIME_ID");

--STAR SCHEME 2

CREATE TABLE DIM_SUBSCRIPTION (
  "SUB_ID" NUMBER(6,0) PRIMARY KEY,
  "NAME" VARCHAR(12)
);

CREATE TABLE DIM_CUSTOMER (
  "PERSON_ID" NUMBER(6,0) PRIMARY KEY,
  "BIRTH_DATE" DATE
);

CREATE TABLE FACT_SUBTYPES (
  "PERSON_ID" NUMBER(6,0),
  "SUB_ID" NUMBER(6,0),
  CONSTRAINT SUB_PK PRIMARY KEY(PERSON_ID,SUB_ID)
);

ALTER TABLE FACT_SUBTYPES
ADD CONSTRAINT SUB_FK
FOREIGN KEY ("SUB_ID")
REFERENCES DIM_SUBSCRIPTION("SUB_ID");

ALTER TABLE FACT_SUBTYPES
ADD CONSTRAINT PERSON_FK
FOREIGN KEY ("PERSON_ID")
REFERENCES DIM_CUSTOMER("PERSON_ID");

-- STAR SCHEME 3

CREATE TABLE DIM_SALARY (
  "SALARY_ID" NUMBER(6,0) PRIMARY KEY,
  "AMOUNT" NUMBER(10,2)
);

CREATE TABLE DIM_EMPLOYEE (
  PERSON_ID NUMBER(6,0) PRIMARY KEY,
  POSITION_TYPE CHAR(1)
);

CREATE TABLE FACT_SALARYPAID (
  "PERSON_ID" NUMBER(6,0),
  "SALARY_ID" NUMBER(6,0),
  "TIME_ID" DATE,
  CONSTRAINT SALARYPAID_PK
  PRIMARY KEY("PERSON_ID", "SALARY_ID", "TIME_ID")
);

ALTER TABLE FACT_SALARYPAID
ADD CONSTRAINT EMPLOYEE_FK
FOREIGN KEY ("PERSON_ID")
REFERENCES DIM_EMPLOYEE("PERSON_ID");

ALTER TABLE FACT_SALARYPAID
ADD CONSTRAINT SALARYPAID_FK
FOREIGN KEY("SALARY_ID")
REFERENCES DIM_SALARY("SALARY_ID");

ALTER TABLE FACT_SALARYPAID
ADD CONSTRAINT TIME_SALARY_FK
FOREIGN KEY("TIME_ID")
REFERENCES DIM_TIME("TIME_ID");