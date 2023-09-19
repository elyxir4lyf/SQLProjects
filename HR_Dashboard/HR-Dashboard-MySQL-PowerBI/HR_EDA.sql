-- Creating the database
CREATE DATABASE HR_Project;

-- ensuring the database is in use
USE HR_Project;

-- exploring the databse (EDA)
SELECT * FROM hr;

-- confirming the datatypes in the table
SELECT column_name, data_type 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_schema = 'HR_Project' and table_name = 'hr';

-- all our columns are text columns and they need to be converted into their various formats
 
-- Renaming the ï»¿id column
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- descrribing the hr table
DESCRIBE hr;

-- Checking the birthdate column
SELECT birthdate FROM hr;

-- This turns safe update off
SET sql_safe_updates = 0; -- This should be turned back to 1 one the cleaning is done for security reasons

-- updating birthdate column
UPDATE hr
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Changing the datatype of the birthdate columnn and renaming to birth_date for consistency
ALTER TABLE hr
CHANGE COLUMN birthdate birth_date DATE NULL;

-- updating hire_date column
UPDATE hr
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Changing the datatype of the birthdate columnn and renaming to birth_date for consistency
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;