# Parch-and-Posey-Database
This project contains data about Parch and Posey, a fictional paper-selling company. The company has 50 sales reps across four regions in the United States.

This database contains the following tables (provided here as both parch and posey database - queried in PostgreSQL 14 - and CSV file for each table.

## Table Description
The tables in the database are:

- **Accounts:** which contains all the accounts from Parch and Posey.
- **Orders:** which contains all the orders made from 2014-12-03 to 2017-01-01.
- **Regions:** which contains the 4 regions in the United States where Parch and Posey operates.
- **Sales_reps**: which contains the information on Parch and Posey's sales reps.
- **Web_events:** which contains all web event data for Parch and Posey's accounts.

For this datebase, i have answered more than 60 queries from all of the tables in the database.

## Restoring the Database

**Instructions to load database**

1. Download [PostgreSQL](https://www.postgresql.org/).
2. Windows users need to add path of /bin and /lib
3. This PC -> Properties -> Environment Variable -> Select _**Path**_ -> New
4. Add <code> C:\Program Files\PostgreSQL\14\bin</code> **AND** <code> C:\Program Files\PostgreSQL\12\lib to path</code>
5. Go to download location of *parch_and_posey_db*
6. Open **CMD**
7. Run <code> pg_restore --create --dbname=postgres --username=postgres parch_and_posey_db </code>
8. Run **pgAdmin4** and look up *Parch & Posey Database*


**NOTE: The data dump file and the above commands works well with PostgreSQL (may or may not work with MySQL and others).**


## Database Schema
The schema for this database is visualized below:

![alt text](schema.png)
