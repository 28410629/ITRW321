# ITRW321-Semester_Project

This is the repository for our final DB project!

## Setup Dev Environment

* Run `ITRW321-Semester_Project/Create_Database/01-create-db.sql` to create the operation database from the previous semester.
* Run `ITRW321-Semester_Project/Create_Database/02-star_create.sql` to create the star schemes for the DSS.
* Run `ITRW321-Semester_Project/Create_Database/03-update-populate-stars.sql` to execute the ETL (extract, transform and load) for the DSS system.

## Work Allocation

**Morne**
- [x] Initial DB setup.
- [x] Combine group member work for ETL.
- [ ] Generate view for *Temperature per station*.
- [ ] Generate view for *Temperature per location*.
- [ ] Generate view for *Employee Salary*.

**Eon** 
- [x] Populate fact table: *FACT_SALARYPAID*.
- [x] Populate fact table: *FACT_SUBTYPES*.
- [x] Generate view for *Air Pressure per station*.
- [x] Generate view for *Air Pressure per location*.
- [ ] Generate view for *Age of Customer per Subscription*.

**Coenraad**
- [x] Populate fact table: *FACT_READINGS*.
- [x] Generate view for *Humidity per station*.
- [x] Generate view for *Humidity per location*.

**Rainard**
- [ ] Generate view for *Ambient light per station*.
- [ ] Generate view for *Ambient light per location*.

## Some Useful Resources

- Our google drive folder for the project.
- https://www.techonthenet.com/oracle/subqueries.php
- https://www.essentialsql.com/get-ready-to-learn-sql-server-20-using-subqueries-in-the-select-statement/
- https://www.oracletutorial.com/oracle-basics/oracle-subquery/
- https://www.webucator.com/tutorial/advanced-oracle-sql-queries/using-subqueries.cfm
- http://www.java2s.com/Code/Oracle/PL-SQL/RETURNINGINTOclause.htm
- https://oracle-base.com/articles/misc/dml-returning-into-clause
- https://www.webucator.com/tutorial/oracle-pl-sql/declaring-variables.cfm
- https://docs.oracle.com/cd/B28359_01/server.111/b28286/functions052.htm#SQLRF00639
- https://blogs.oracle.com/oraclemagazine/working-with-dates-in-plsql
- https://www.oracletutorial.com/oracle-date-functions/
- https://www.oracletutorial.com/oracle-date-functions/oracle-extract/
