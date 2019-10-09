-----------------------------------------------------------------------
--Drop Tables
-----------------------------------------------------------------------
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE FORECAST CASCADE CONSTRAINTS;
DROP TABLE LOCATION CASCADE CONSTRAINTS;
DROP TABLE PERSON CASCADE CONSTRAINTS;
DROP TABLE REPAIRLOG CASCADE CONSTRAINTS;
DROP TABLE SALARY CASCADE CONSTRAINTS;
DROP TABLE STATION CASCADE CONSTRAINTS;
DROP TABLE STATIONREADING CASCADE CONSTRAINTS;
DROP TABLE STATION_HIST CASCADE CONSTRAINTS;
DROP TABLE SUBSCRIPTION CASCADE CONSTRAINTS;
DROP TABLE TECHNICIAN CASCADE CONSTRAINTS;
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--Drop Sequences
-----------------------------------------------------------------------
DROP SEQUENCE FORECAST_SEQ;
DROP SEQUENCE LOCATION_SEQ;
DROP SEQUENCE PERSON_SEQ;
DROP SEQUENCE REPAIRLOG_SEQ;
DROP SEQUENCE SALARY_SEQ;
DROP SEQUENCE STATIONREADING_SEQ;
DROP SEQUENCE STATION_HIST_SEQ;
DROP SEQUENCE STATION_SEQ;
-----------------------------------------------------------------------
--------------------------------------------------------
--  Table PERSON
--------------------------------------------------------
CREATE TABLE "PERSON"
   (
    "PERSONID" NUMBER(6,0),
    "IDNUMBER" VARCHAR2(15 BYTE),
    "FIRSTNAME" VARCHAR2(25 BYTE),
    "LASTNAME" VARCHAR2(25 BYTE),
    "PHONENUMBER" VARCHAR2(10 BYTE),
    "EMAIL" VARCHAR2(55 BYTE),
    "PERSONTYPE" CHAR(1 BYTE),
    "USERNAME" VARCHAR2(55 BYTE),
    "PASSWORD" VARCHAR2(55 BYTE),
    "ACTIVE_USER" NUMBER(1,0) DEFAULT 1, --1 yes, 0 no,
    "BIRTH_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------
--------------------------------------------------------
--  Table EMPLOYEE
--------------------------------------------------------
CREATE TABLE "EMPLOYEE"
   (
    "PERSONID" NUMBER(6,0),
    "POSITIONTITLE" VARCHAR2(25 BYTE),
    "POSITIONTYPE" CHAR(1 BYTE), --T or ''
    "VATNUMBER" VARCHAR2(20 BYTE),
    "PERSONTYPE" CHAR(1 BYTE) DEFAULT 'E'
   ) SEGMENT CREATION IMMEDIATE ;
--------------------------------------------------------
--------------------------------------------------------
--  Table CUSTOMER
--------------------------------------------------------
CREATE TABLE "CUSTOMER"
   (
    "PERSONID" NUMBER(6,0),
    "SUBSCRIPTION_TYPE" NUMBER(5,0),
    "PERSONTYPE" CHAR(1 BYTE) DEFAULT 'C'
   ) SEGMENT CREATION IMMEDIATE ;
--------------------------------------------------------
--------------------------------------------------------
--  Table SUBSCRIPTION
--------------------------------------------------------
CREATE TABLE "SUBSCRIPTION"
   (
    "SUBSCRIPTION_TYPE" NUMBER(6,0),
    "MONTHLY_PRICE" NUMBER(6,2),
    "NAME" VARCHAR2(12 BYTE),
    "INTERVAL_TIME" NUMBER(6,0) --interval of forecasts received
   ) SEGMENT CREATION IMMEDIATE ;
--------------------------------------------------------

--------------------------------------------------------
--  Table SALARY
--------------------------------------------------------
CREATE TABLE "SALARY"
   (
      "SALARYID" NUMBER(6,0),
	"PERSONID" NUMBER(6,0),
	"AMOUNT" NUMBER(10,2),
	"DATEPAID" DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------
--------------------------------------------------------
--  Table TECHNICIAN
--------------------------------------------------------
  CREATE TABLE "TECHNICIAN"
   (
      "PERSONID" NUMBER(6,0),
	"HARDWARE_YES" NUMBER(1,0), --1 yes, 0 no
	"SOFTWARE_YES" NUMBER(1,0), --1 yes, 0 no
      "POSITIONTYPE" CHAR(1 BYTE) DEFAULT 'T'
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------
--------------------------------------------------------
--  Table REPAIRLOG
--------------------------------------------------------
  CREATE TABLE "REPAIRLOG"
   (
      "REPAIRID" NUMBER(10,0),
	"PERSONID" NUMBER(6,0),
	"STATIONID" NUMBER(6,0),
	"DATE_OF" DATE,
	"DESCRIPTION" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------
--------------------------------------------------------
--  Table STATION
--------------------------------------------------------
  CREATE TABLE "STATION"
   (
      "STATIONID" NUMBER(6,0),
	"STATUS" VARCHAR2(55 BYTE),
	"LOCATIONID" NUMBER(6,0),
	"COORDINATES" VARCHAR2(255 BYTE),
	"ISACTIVE" NUMBER(1,0) DEFAULT 1 --1 yes, 0 no
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------

--------------------------------------------------------
--  Table STATION_HIST
--------------------------------------------------------
CREATE TABLE "STATION_HIST"
   (
    "HIST_ID" NUMBER(6,0),
    "LOCATIONID" NUMBER(6,0),
    "COORDINATES" VARCHAR2(255 BYTE),
    "STATIONID" NUMBER(6,0)
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------
--------------------------------------------------------
--  Table LOCATION
--------------------------------------------------------
CREATE TABLE "LOCATION"
   (
      "LOCATIONID" NUMBER(6,0),
	"LOCATIONNAME" VARCHAR2(25 BYTE),
	"PROVINCE" VARCHAR2(25 BYTE)
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------
--------------------------------------------------------
--  Table STATIONREADING
--------------------------------------------------------
CREATE TABLE "STATIONREADING"
   (
    "READING_ID" NUMBER(16,0),
    "STATIONID" NUMBER(6,0),
    "READINGLOCATION" NUMBER(6,0),
    "READING_DATE" DATE DEFAULT sysdate,
    "TEMPERATURE" NUMBER(8,2),
    "AIR_PRESSURE" NUMBER(8,2),
    "AMBIENT_LIGHT" NUMBER(8,2),
    "HUMIDITY" NUMBER(8,2),
    "ALTITUDE" NUMBER(8,2)
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------
--------------------------------------------------------
--  Table FORECAST
--------------------------------------------------------
CREATE TABLE "FORECAST"
   (
    "FORECAST_ID" NUMBER(16, 0),
    "FORECASTDATE" DATE,
    "LOCATIONID" NUMBER(6,0),
    "TEMPERATURE" NUMBER(8,2),
    "AIR_PRESSURE" NUMBER(8,2),
    "HUMIDITY" NUMBER(8,2),
    "AMBIENT_LIGHT" NUMBER(8,2)
   ) SEGMENT CREATION IMMEDIATE;
--------------------------------------------------------

--------------------------------------------------------
--  Constraints for Table PERSON
--------------------------------------------------------
ALTER TABLE "PERSON" ADD CONSTRAINT "UNIQ_PERSON_TYPE" UNIQUE ("PERSONID", "PERSONTYPE");
ALTER TABLE "PERSON" ADD CONSTRAINT "PERSON_CHECK_C_OR_E" CHECK (PERSONTYPE IN ('E', 'C')) ENABLE;
ALTER TABLE "PERSON" MODIFY ("PERSONID" NOT NULL ENABLE);
ALTER TABLE "PERSON" MODIFY ("EMAIL" NOT NULL ENABLE);
ALTER TABLE "PERSON" MODIFY ("ACTIVE_USER" NOT NULL ENABLE);
ALTER TABLE "PERSON" ADD CONSTRAINT "PERSON_PK" PRIMARY KEY ("PERSONID");
ALTER TABLE "PERSON" ADD CONSTRAINT "EMAIL_UK" UNIQUE ("EMAIL");
ALTER TABLE "PERSON" ADD CONSTRAINT "UNIQ_ID_NUM" UNIQUE ("IDNUMBER");
ALTER TABLE "PERSON" ADD CONSTRAINT "UNIQ_USERNAME" UNIQUE ("USERNAME");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table EMPLOYEE
--------------------------------------------------------
ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "UNIQ_EMPL_TYPE" UNIQUE ("PERSONID", "POSITIONTYPE");
ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "PERSON_CHECK_E" CHECK (PERSONTYPE IN ('E')) ENABLE;
ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "CHECK_EMP_TYPE" CHECK (POSITIONTYPE      IN ('T', '')) ENABLE;
ALTER TABLE "EMPLOYEE" MODIFY ("PERSONID" NOT NULL ENABLE);
ALTER TABLE "EMPLOYEE" MODIFY ("POSITIONTYPE" NOT NULL ENABLE);
ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "EMPLOYEE_PK" PRIMARY KEY ("PERSONID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table SALARY
--------------------------------------------------------
ALTER TABLE "SALARY" MODIFY ("SALARYID" NOT NULL ENABLE);
ALTER TABLE "SALARY" MODIFY ("DATEPAID" NOT NULL ENABLE);
ALTER TABLE "SALARY" ADD CONSTRAINT "SALARY_PK" PRIMARY KEY ("SALARYID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table CUSTOMER
--------------------------------------------------------
ALTER TABLE "CUSTOMER" MODIFY ("PERSONID" NOT NULL ENABLE);
ALTER TABLE "CUSTOMER" ADD CONSTRAINT "PERSON_CHECK_C" CHECK (PERSONTYPE IN ('C')) ENABLE;
ALTER TABLE "CUSTOMER" ADD CONSTRAINT "CUSTOMER_PK" PRIMARY KEY ("PERSONID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table SUBSCRIPTION
--------------------------------------------------------
ALTER TABLE "SUBSCRIPTION" MODIFY ("SUBSCRIPTION_TYPE" NOT NULL ENABLE);
ALTER TABLE "SUBSCRIPTION" ADD CONSTRAINT "SUBSCRIPTION_PK" PRIMARY KEY ("SUBSCRIPTION_TYPE");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table TECHNICIAN
--------------------------------------------------------
ALTER TABLE "TECHNICIAN" MODIFY ("PERSONID" NOT NULL ENABLE);
ALTER TABLE "TECHNICIAN" ADD CONSTRAINT "TECHNICIAN_PK" PRIMARY KEY ("PERSONID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table REPAIRLOG
--------------------------------------------------------
ALTER TABLE "REPAIRLOG" MODIFY ("REPAIRID" NOT NULL ENABLE);
ALTER TABLE "REPAIRLOG" MODIFY ("PERSONID" NOT NULL ENABLE);
ALTER TABLE "REPAIRLOG" MODIFY ("STATIONID" NOT NULL ENABLE);
ALTER TABLE "REPAIRLOG" ADD CONSTRAINT "REPAIRLOG_PK" PRIMARY KEY ("REPAIRID", "PERSONID", "STATIONID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table STATION
--------------------------------------------------------
ALTER TABLE "STATION" MODIFY ("STATIONID" NOT NULL ENABLE);
ALTER TABLE "STATION" ADD CONSTRAINT "STATION_PK" PRIMARY KEY ("STATIONID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table STATION_HIST
--------------------------------------------------------
ALTER TABLE "STATION_HIST" MODIFY ("HIST_ID" NOT NULL ENABLE);
ALTER TABLE "STATION_HIST" ADD CONSTRAINT "STATION_HIST_PK" PRIMARY KEY ("HIST_ID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table LOCATION
--------------------------------------------------------
ALTER TABLE "LOCATION" MODIFY ("LOCATIONID" NOT NULL ENABLE);
ALTER TABLE "LOCATION" ADD CONSTRAINT "UNIQ_NAME" UNIQUE ("LOCATIONNAME");
ALTER TABLE "LOCATION" ADD CONSTRAINT "LOCATION_PK" PRIMARY KEY ("LOCATIONID");
--------------------------------------------------------
--------------------------------------------------------
--  Constraints for Table STATIONREADING
--------------------------------------------------------
ALTER TABLE "STATIONREADING" MODIFY ("READING_ID" NOT NULL ENABLE);
ALTER TABLE "STATIONREADING" ADD CONSTRAINT "STATIONREADING_PK" PRIMARY KEY ("READING_ID");
--------------------------------------------------------
--------------------------------------------------------
 -- Constraints for Table FORECAST
 --------------------------------------------------------
ALTER TABLE "FORECAST" MODIFY ("FORECAST_ID" NOT NULL ENABLE);
ALTER TABLE "FORECAST" ADD CONSTRAINT "FORECAST_PK" PRIMARY KEY ("FORECAST_ID");
--------------------------------------------------------


--------------------------------------------------------
--  Reference Constraints for Table CUSTOMER
--------------------------------------------------------
ALTER TABLE "CUSTOMER" ADD CONSTRAINT "CUSTOMER_FK" FOREIGN KEY ("SUBSCRIPTION_TYPE")
REFERENCES "SUBSCRIPTION" ("SUBSCRIPTION_TYPE") ENABLE;
ALTER TABLE "CUSTOMER" ADD CONSTRAINT "CUST_ISA_PERSON" FOREIGN KEY ("PERSONID", "PERSONTYPE")
REFERENCES "PERSON" ("PERSONID", "PERSONTYPE") ENABLE;
--------------------------------------------------------
--------------------------------------------------------
--  Reference Constraints for Table EMPLOYEE
--------------------------------------------------------
ALTER TABLE "EMPLOYEE" ADD CONSTRAINT "PERSON_ISA_EMPL" FOREIGN KEY ("PERSONID", "PERSONTYPE")
REFERENCES "PERSON" ("PERSONID", "PERSONTYPE") ENABLE;
--------------------------------------------------------

--------------------------------------------------------
--  Reference Constraints for Table SALARY
--------------------------------------------------------
ALTER TABLE "SALARY" ADD CONSTRAINT "SALARY_FK" FOREIGN KEY ("PERSONID")
REFERENCES "EMPLOYEE" ("PERSONID") ENABLE;
--------------------------------------------------------
--------------------------------------------------------
--  Reference Constraints for Table TECHNICIAN
--------------------------------------------------------
ALTER TABLE "TECHNICIAN" ADD CONSTRAINT "EMPL_ISA_TECH" FOREIGN KEY ("PERSONID", "POSITIONTYPE")
REFERENCES "EMPLOYEE" ("PERSONID", "POSITIONTYPE") ENABLE;
--------------------------------------------------------
--------------------------------------------------------
--  Reference Constraints for Table REPAIRLOG
--------------------------------------------------------
ALTER TABLE "REPAIRLOG" ADD CONSTRAINT "REPAIR_FK_STATION" FOREIGN KEY ("STATIONID")
REFERENCES "STATION" ("STATIONID") ENABLE;
ALTER TABLE "REPAIRLOG" ADD CONSTRAINT "REPAIR_FK_TECH" FOREIGN KEY ("PERSONID")
REFERENCES "TECHNICIAN" ("PERSONID") ENABLE;
--------------------------------------------------------
--------------------------------------------------------
--  Reference Constraints for Table STATION
--------------------------------------------------------
ALTER TABLE "STATION" ADD CONSTRAINT "STATION_LOC_FK" FOREIGN KEY ("LOCATIONID")
REFERENCES "LOCATION" ("LOCATIONID") ENABLE;
--------------------------------------------------------
--------------------------------------------------------
--  Reference Constraints for Table STATION_HIST
--------------------------------------------------------
ALTER TABLE "STATION_HIST" ADD CONSTRAINT "STATION_HIST_FK" FOREIGN KEY ("STATIONID")
REFERENCES "STATION" ("STATIONID") ENABLE;
--------------------------------------------------------
--------------------------------------------------------
--  Reference Constraints for Table STATIONREADING
--------------------------------------------------------
ALTER TABLE "STATIONREADING" ADD CONSTRAINT "READING_FK" FOREIGN KEY ("STATIONID")
REFERENCES "STATION" ("STATIONID") ENABLE;
--------------------------------------------------------
--------------------------------------------------------
--  Reference Constraints for Table FORECAST
--------------------------------------------------------
ALTER TABLE "FORECAST" ADD CONSTRAINT "FORECAST_FK" FOREIGN KEY ("LOCATIONID")
REFERENCES "LOCATION" ("LOCATIONID") ENABLE;
--------------------------------------------------------

--------------------------------------------------------
--  Sequence FORECAST_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "FORECAST_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  Sequence LOCATION_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "LOCATION_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  Sequence PERSON_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "PERSON_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 81 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  Sequence REPAIRLOG_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "REPAIRLOG_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  Sequence SALARY_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "SALARY_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  Sequence STATIONREADING_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "STATIONREADING_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  Sequence STATION_HIST_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "STATION_HIST_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  Sequence STATION_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "STATION_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--------------------------------------------------------
--  Index SALARY_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "SALARY_PK" ON "SALARY" ("SALARYID");
--------------------------------------------------------
--  Index EMAIL_UK
--------------------------------------------------------

CREATE UNIQUE INDEX "EMAIL_UK" ON "PERSON" ("EMAIL");
--------------------------------------------------------
--  Index CUSTOMER_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "CUSTOMER_PK" ON "CUSTOMER" ("PERSONID");
--------------------------------------------------------
--  Index SUBSCRIPTION_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "SUBSCRIPTION_PK" ON "SUBSCRIPTION" ("SUBSCRIPTION_TYPE");
--------------------------------------------------------
--  Index STATION_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "STATION_PK" ON "STATION" ("STATIONID");
--------------------------------------------------------
--  Index FORECAST_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "FORECAST_PK" ON "FORECAST" ("FORECAST_ID");
--------------------------------------------------------
--  Index EMPLOYEE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "EMPLOYEE_PK" ON "EMPLOYEE" ("PERSONID");
--------------------------------------------------------
--  Index PERSON_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "PERSON_PK" ON "PERSON" ("PERSONID");
--------------------------------------------------------
--  Index UNIQ_PERSON_TYPE
--------------------------------------------------------
CREATE UNIQUE INDEX "UNIQ_PERSON_TYPE" ON "PERSON" ("PERSONID", "PERSONTYPE");
--------------------------------------------------------
--  Index STATIONREADING_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "STATIONREADING_PK" ON "STATIONREADING" ("READING_ID");
--------------------------------------------------------
--  Index LOCATION_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "LOCATION_PK" ON "LOCATION" ("LOCATIONID");
--------------------------------------------------------
--  Index TECHNICIAN_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "TECHNICIAN_PK" ON "TECHNICIAN" ("PERSONID");
--------------------------------------------------------
--  Index REPAIRLOG_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "REPAIRLOG_PK" ON "REPAIRLOG" ("REPAIRID", "PERSONID", "STATIONID");

--------------------------------------------------------
--  Index STATION_HIST_PK
--------------------------------------------------------
CREATE UNIQUE INDEX "STATION_HIST_PK" ON "STATION_HIST" ("HIST_ID");
--------------------------------------------------------
--  Index UNIQ_EMPL_TYPE
--------------------------------------------------------
CREATE UNIQUE INDEX "UNIQ_EMPL_TYPE" ON "EMPLOYEE" ("PERSONID", "POSITIONTYPE");
--------------------------------------------------------
--------------------------------------------------------
--  Trigger FORECAST_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "FORECAST_TRG"
BEFORE INSERT ON FORECAST
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.FORECAST_ID IS NULL THEN
  	SELECT FORECAST_SEQ.NEXTVAL INTO :NEW.FORECAST_ID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "FORECAST_TRG" ENABLE;
--------------------------------------------------------
--  Trigger LOCATION_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "LOCATION_TRG"
BEFORE INSERT ON LOCATION
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.LOCATIONID IS NULL THEN
  	SELECT LOCATION_SEQ.NEXTVAL INTO :NEW.LOCATIONID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "LOCATION_TRG" ENABLE;
--------------------------------------------------------
--  Trigger PERSON_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "PERSON_TRG"
BEFORE INSERT ON PERSON
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.PERSONID IS NULL THEN
  	SELECT PERSON_SEQ.NEXTVAL INTO :NEW.PERSONID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "PERSON_TRG" ENABLE;
--------------------------------------------------------
--  Trigger REPAIRLOG_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "REPAIRLOG_TRG"
BEFORE INSERT ON REPAIRLOG
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.REPAIRID IS NULL THEN
  	SELECT REPAIRLOG_SEQ.NEXTVAL INTO :NEW.REPAIRID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "REPAIRLOG_TRG" ENABLE;


--------------------------------------------------------
--  Trigger SALARY_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "SALARY_TRG"
BEFORE INSERT ON SALARY
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.SALARYID IS NULL THEN
  	SELECT SALARY_SEQ.NEXTVAL INTO :NEW.SALARYID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "SALARY_TRG" ENABLE;
--------------------------------------------------------
--  Trigger STATIONREADING_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "STATIONREADING_TRG"
BEFORE INSERT ON STATIONREADING
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.READING_ID IS NULL THEN
  	SELECT STATIONREADING_SEQ.NEXTVAL INTO :NEW.READING_ID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "STATIONREADING_TRG" ENABLE;
--------------------------------------------------------
--  Trigger STATION_HIST_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "STATION_HIST_TRG"
BEFORE INSERT ON STATION_HIST
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.HIST_ID IS NULL THEN
  	SELECT STATION_HIST_SEQ.NEXTVAL INTO :NEW.HIST_ID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "STATION_HIST_TRG" ENABLE;
--------------------------------------------------------
--  Trigger STATION_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "STATION_TRG"
BEFORE INSERT ON STATION
FOR EACH ROW
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
	IF INSERTING AND :NEW.STATIONID IS NULL THEN
  	SELECT STATION_SEQ.NEXTVAL INTO :NEW.STATIONID FROM SYS.DUAL;
	END IF;
  END COLUMN_SEQUENCES;
END;

/
ALTER TRIGGER "STATION_TRG" ENABLE;

--######################################################
--------------------------------------------------------
--INIT DATA
--------------------------------------------------------
--######################################################
--Add PERSON--
INSERT INTO "PERSON" (PERSONID, IDNUMBER, FIRSTNAME, LASTNAME, PHONENUMBER, EMAIL, PERSONTYPE, USERNAME, PASSWORD, ACTIVE_USER, BIRTH_DATE)
  VALUES (1, '971245', 'Morne', 'Venter', '0715724319', 'morne@mail.com', 'E', 'morVen', 'pass123', 1, TO_DATE('1997-12-04', 'YYYY-MM-DD'));
INSERT INTO "PERSON" (PERSONID, IDNUMBER, FIRSTNAME, LASTNAME, PHONENUMBER, EMAIL, PERSONTYPE, USERNAME, PASSWORD, ACTIVE_USER, BIRTH_DATE)
  VALUES (2, '980704', 'Eon', 'Viljoen', '0123649821', 'eon@mail.com', 'C', 'eonBoy', 'secret123', 1, TO_DATE('1998-07-04', 'YYYY-MM-DD'));
INSERT INTO "PERSON" (PERSONID, IDNUMBER, FIRSTNAME, LASTNAME, PHONENUMBER, EMAIL, PERSONTYPE, USERNAME, PASSWORD, ACTIVE_USER, BIRTH_DATE)
  VALUES (3, '950510', 'Coenraad', 'Human', '0123592134', 'coen@mail.com', 'E', 'coenPenguin', 'megaSecret', 1, TO_DATE('1964-05-10', 'YYYY-MM-DD'));

--add SUBSCRIPTION--
INSERT INTO "SUBSCRIPTION" (SUBSCRIPTION_TYPE, MONTHLY_PRICE, NAME, INTERVAL_TIME) VALUES (1, 99.99, 'Gold', 15);
INSERT INTO "SUBSCRIPTION" (SUBSCRIPTION_TYPE, MONTHLY_PRICE, NAME, INTERVAL_TIME) VALUES (2, 59.99, 'Silver', 30);
INSERT INTO "SUBSCRIPTION" (SUBSCRIPTION_TYPE, MONTHLY_PRICE, NAME, INTERVAL_TIME) VALUES (3, 29.99, 'Bronze', 60);

--add CUSTOMER
INSERT INTO "CUSTOMER" (PERSONID, SUBSCRIPTION_TYPE, PERSONTYPE) VALUES (2, 2, 'C');

--add EMPLOYEE
INSERT INTO "EMPLOYEE" (PERSONID, POSITIONTITLE, POSITIONTYPE, VATNUMBER, PERSONTYPE) VALUES (1, 'Head Manager', 'M', '1515415', 'E');
INSERT INTO "EMPLOYEE" (PERSONID, POSITIONTITLE, POSITIONTYPE, VATNUMBER, PERSONTYPE) VALUES (3, 'Technician', 'T', '1541515', 'E');

--add TECHNICIAN
INSERT INTO "TECHNICIAN" (PERSONID, HARDWARE_YES, SOFTWARE_YES, POSITIONTYPE) VALUES (3, 1, 0, 'T');

--add SALARY
INSERT INTO "SALARY" (PERSONID, AMOUNT, DATEPAID) VALUES (1, 30000.50, TO_DATE('2018-01-14 00:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO "SALARY" (PERSONID, AMOUNT, DATEPAID) VALUES (3, 15000.40, TO_DATE('2019-05-14 17:23:30', 'YYYY-MM-DD HH24:MI:SS'));

--add  LOCATION
INSERT INTO "LOCATION" (LOCATIONID, LOCATIONNAME, PROVINCE) VALUES (1, 'Anatombi', 'North West');
INSERT INTO "LOCATION" (LOCATIONID, LOCATIONNAME, PROVINCE) VALUES (2, '7 Postma Street', 'North West');

--add STATION
INSERT INTO "STATION" (STATIONID, STATUS, LOCATIONID, COORDINATES, ISACTIVE) VALUES (1, 'Working', 1, 'x:4574,23232;y:347864,23', 1);
INSERT INTO "STATION" (STATIONID, STATUS, LOCATIONID, COORDINATES, ISACTIVE) VALUES (2, 'Offline', 1, 'x:4574,22;y:34764,23', 0);
INSERT INTO "STATION" (STATIONID, STATUS, LOCATIONID, COORDINATES, ISACTIVE) VALUES (3, 'Working', 2, 'x:34737,123;y:374,534', 1);



--add FORECAST
INSERT INTO "FORECAST" (FORECASTDATE, LOCATIONID, TEMPERATURE, AIR_PRESSURE, HUMIDITY, AMBIENT_LIGHT)
VALUES (TO_DATE('2019-05-21 17:52:08', 'YYYY-MM-DD HH24:MI:SS'), 2, 32, 874.6, 0.54, 0.08);

--REPAIRLOG
INSERT INTO "REPAIRLOG" (PERSONID, STATIONID, DATE_OF, DESCRIPTION) VALUES (3, 2, TO_DATE('2019-05-22 18:04:03', 'YYYY-MM-DD HH24:MI:SS'), 'Fixed light sensor.');
INSERT INTO "REPAIRLOG" (PERSONID, STATIONID, DATE_OF, DESCRIPTION) VALUES (3, 1, TO_DATE('2019-07-12 18:04:03', 'YYYY-MM-DD HH24:MI:SS'), 'Fixed faulty battery.');

--STATIONREADING
INSERT INTO "STATIONREADING" (STATIONID, READINGLOCATION, READING_DATE, TEMPERATURE, AIR_PRESSURE, AMBIENT_LIGHT, HUMIDITY, ALTITUDE) VALUES (1, 1,TO_DATE('2019-9-26 0:11:56', 'YYYY-MM-DD HH24:MI:SS'), 21.19, 871.76, 0.02, 0.32, 1305.23);
INSERT INTO "STATIONREADING" (STATIONID, READINGLOCATION, READING_DATE, TEMPERATURE, AIR_PRESSURE, AMBIENT_LIGHT, HUMIDITY, ALTITUDE) VALUES (1, 1,TO_DATE('2019-9-26 0:8:47', 'YYYY-MM-DD HH24:MI:SS'), 22.13, 871.71, 0.02, 0.32, 1305.68);
