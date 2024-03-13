/*
Create a table called  employees with the following columns and datatypes:

ID - INT autoincrement
last_name - VARCHAR of size 50 should not be null
first_name - VARCHAR of size 50 should not be null
age - INT
job_title - VARCHAR of size 100
date_of_birth - DATE
phone_number - INT
insurance_id - VARCHAR of size 15

SET ID AS PRIMARY KEY DURING TABLE CREATION

*/

CREATE DATABASE sqlAssignment_1;

CREATE TABLE EMPLOYEES(ID INT AUTO_INCREMENT PRIMARY KEY,
					   FIRST_NAME VARCHAR(50),
					   LAST_NAME VARCHAR(50),
                       AGE INT,
                       JOB_TITLE VARCHAR(100),
                       DATE_OF_BIRTH DATE,
                       PHONE_NUMBER INT,
                       INSURANCE_ID VARCHAR(15)
);

-- While inserting the above data, you might get error because of Phone number column.
-- As phone_number is INT right now. Change the datatype of phone_number to make them strings of FIXED LENGTH of 10 characters.
-- Do some research on which datatype you need to use for this.

ALTER TABLE EMPLOYEES 
MODIFY COLUMN PHONE_NUMBER VARCHAR(10);

/*
Add the following data to this table in a SINGLE query:

Smith | John | 32 | Manager | 1989-05-12 | 5551234567 | INS736 |
Johnson | Sarah | 28 | Analyst | 1993-09-20 | 5559876543 | INS832 |
Davis | David | 45 | HR | 1976-02-03 | 5550555995 | INS007 |
Brown | Emily | 37 | Lawyer | 1984-11-15 | 5551112022 | INS035 |
Wilson | Michael | 41 | Accountant | 1980-07-28 | 5554403003 | INS943 |
Anderson | Lisa | 22 | Intern | 1999-03-10 | 5556667777 | INS332 |
Thompson | Alex | 29 | Sales Representative| 5552120111 | 555-888-9999 | INS433 |

*/

INSERT INTO EMPLOYEES (LAST_NAME , FIRST_NAME , AGE , JOB_TITLE , DATE_OF_BIRTH , PHONE_NUMBER , INSURANCE_ID)
VALUES('Smith',		'John',		32, 'Manager',		'1989-05-12' , '5551234567' , 'INS736'),
	  ('Johnson',	'Sarah',	28, 'Analyst',		'1993-09-20' , '5559876543' , 'INS832'),
	  ('Davis',		'David',	45, 'HR',			'1976-02-03' , '5550555995' , 'INS007'),
	  ('Brown',		'Emily',	37, 'Lawyer',		'1984-11-15' , '5551112022' , 'INS035'),
	  ('Wilson',	'Michael',	41, 'Accountant',	'1980-07-28' , '5554403003' , 'INS943'),
	  ('Anderson',	'Lisa',		22, 'Intern',		'1999-03-10' , '5556667777' , 'INS332'),
	  ('Thompson',	'Alex',		29, 'Sales Representative', NULL , '5552120111' , 'INS433');
      
-- Explore unique job titles
      
SELECT DISTINCT JOB_TITLE AS UNIQUE_JOB_TITLE FROM EMPLOYEES;    

-- Name the top three youngest employees

SELECT FIRST_NAME AS TOP_THREE_YOUNGEST_EMPLOYEE FROM EMPLOYEES ORDER BY AGE ASC LIMIT 3; 

-- Update date of birth for Alex Thompson as it is 1992-06-24

UPDATE EMPLOYEES 
SET DATE_OF_BIRTH = '1992-06-24'
WHERE FIRST_NAME = 'Alex';

-- Delete the data of employees with age greater than 30

DELETE FROM EMPLOYEES 
WHERE AGE > 30;

-- Concatenating First name and Last name:

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME FROM EMPLOYEES;

/*-- Create a table called employee_insurance with the following columns and datatypes:

insurance_id VARCHAR of size 15
insurance_info VARCHAR of size 100

Make insurance_id the primary key of this table
							
*/

CREATE TABLE EMPLOYEE_INSURANCE(INSURANCE_ID VARCHAR(15)  PRIMARY KEY ,
								INSURANCE_INFO VARCHAR(100)
                                );
/*
Insert the following values into employee_insurance:

"INS736", "unavailable"
"INS832", "unavailable"
"INS007", "unavailable"
"INS035", "unavailable"
"INS943", "unavailable"
"INS332", "unavailable"
"INS433", "unavailable"

*/

INSERT INTO EMPLOYEE_INSURANCE
VALUES
("INS736", "unavailable"),
("INS832", "unavailable"),
("INS007", "unavailable"),
("INS035", "unavailable"),
("INS943", "unavailable"),
("INS332", "unavailable"),
("INS433", "unavailable");

-- Add a column called email to the employees table. Remember to set an appropriate datatype

ALTER TABLE EMPLOYEE_INSURANCE 
ADD EMAIL VARCHAR(255);

-- Add the value "unavailable" for all records in email in a SINGLE query
UPDATE EMPLOYEE_INSURANCE
SET EMAIL = 'unavailable';



 

				