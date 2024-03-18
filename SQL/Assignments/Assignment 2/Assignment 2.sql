create database SQL_Assignment2;

SELECT * FROM PETOWNERS LIMIT 5;
SELECT * FROM PETS LIMIT 5;
SELECT * FROM PROCEDURESDETAILS LIMIT 5;
SELECT * FROM PROCEDURESHISTORY LIMIT 5;

-- 1. List the names of all pet owners along with the names of their pets. 

SELECT PETOWNERS.NAME AS OWENER_NAME, PETS.NAME AS PET_NAME FROM PETOWNERS JOIN PETS ON PETOWNERS.OWNERID = PETS.OWNERID;

-- 2. List all pets and their owner names, including pets that don't have recorded owners.

SELECT PETOWNERS.NAME AS OWENER_NAME, PETS.NAME AS PET_NAME FROM PETS LEFT JOIN PETOWNERS ON PETOWNERS.OWNERID = PETS.OWNERID; 

-- 3. Combine the information of pets and their owners, including those pets without owners and owners without pets. 

SELECT PETOWNERS.NAME AS OWENER_NAME, PETS.NAME AS PET_NAME FROM PETS LEFT JOIN PETOWNERS ON PETOWNERS.OWNERID = PETS.OWNERID UNION SELECT PETOWNERS.NAME AS OWENER_NAME, PETS.NAME AS PET_NAME FROM PETS RIGHT JOIN PETOWNERS ON PETOWNERS.OWNERID = PETS.OWNERID;

-- 4. List all pet owners and the number of dogs they own.

SELECT PETOWNERS.NAME AS OWENER_NAME, COUNT(PETS.PETID) AS NUMBER_OF_PETS FROM PETOWNERS LEFT JOIN PETS ON PETOWNERS.OWNERID = PETS.OWNERID GROUP BY PETOWNERS.OWNERID , PETOWNERS.NAME;

-- 5. Identify pets that have not had any procedures.

SELECT PETS.NAME AS PET_NAME FROM PETS JOIN PROCEDURESHISTORY ON PETS.PETID = PROCEDURESHISTORY.PETID;

-- Find the name of the oldest pet.

SELECT NAME , AGE FROM PETS ORDER BY AGE DESC LIMIT 1;

-- 7. Find the details of procedures performed on 'Cuddles'.

SELECT PETS.NAME, PROCEDURESDETAILS.DESCRIPTION FROM PETS JOIN PROCEDURESHISTORY ON PETS.PETID = PROCEDURESHISTORY.PETID JOIN PROCEDURESDETAILS ON PROCEDURESDETAILS.PROCEDURESUBCODE = PROCEDURESHISTORY.PROCEDURESUBCODE WHERE PETS.NAME = 'Cuddles';

-- .8 List the pets who have undergone a procedure called 'VACCINATIONS'.

SELECT PETS.PETID, PETS.NAME ,PROCEDURESHISTORY.PROCEDURETYPE FROM PETS JOIN PROCEDURESHISTORY ON PETS.PETID = PROCEDURESHISTORY.PETID WHERE PROCEDURETYPE = "VACCINATIONS";

-- 9.  the number of pets of each kind.

SELECT KIND , COUNT(*) AS NUMBER_OF_PETS  FROM PETS GROUP BY KIND;

-- 10 Group pets by their kind and gender and count the number of pets in each group. 

SELECT KIND , GENDER ,  COUNT(*) AS NUMBER_OF_PETS  FROM PETS GROUP BY KIND , GENDER;

-- 11. Show the average age of pets for each kind, but only for kinds that have more than 5 pets.

SELECT KIND , GENDER ,  AVG(AGE) AS AVERAGE_AGE_OF_PETS  FROM PETS GROUP BY KIND , GENDER HAVING COUNT(*) > 5;

-- 12. Find the types of procedures that have an average cost greater than $50

SELECT PROCEDURETYPE ,AVG(PRICE) AS AVERGAE_COST FROM PROCEDURESDETAILS GROUP BY PROCEDURETYPE HAVING AVG(PRICE) > 50 ;

-- 13.Classify pets as 'Young', 'Adult', or 'Senior' based on their age. Age less then 3 Young, Age between 3and 8 Adult, else Senior. 

SELECT 
    Name AS Pet_Name,
    CASE
        WHEN Age < 3 THEN 'Young'
        WHEN Age BETWEEN 3 AND 8 THEN 'Adult'
        ELSE 'Senior'
    END AS AgeCategory
FROM 
    PETS;
    
-- 14. Show the gender of pets with a custom label ('Boy' for male, 'Girl' for female).
SELECT 
    Name AS Pet_Name,
    GENDER,
    CASE
        WHEN GENDER = 'male' THEN 'Boy'
        ELSE 'Girl'
    END AS CUSTOM_LABEL
FROM 
    PETS;
    
-- 15.For each pet, display the pet's name, the number of procedures they've had, and a
-- status label: 'Regular' for pets with 1 to 3 procedures, 'Frequent' for 4 to 7
-- procedures, and 'Super User' for more than 7 procedures.

SELECT 
    PETS.Name AS Pet_Name,
    COUNT(PROCEDURESHISTORY.PetID) AS NUMBER_OF_PROCEDURES,
    CASE
        WHEN COUNT(PROCEDURESHISTORY.PetID) BETWEEN 1 AND 3 THEN 'Regular'
        WHEN COUNT(PROCEDURESHISTORY.PetID) BETWEEN 4 AND 7 THEN 'Frequent'
        ELSE 'Super User'
    END AS STATUS_LABLEL
FROM 
    PETS 
JOIN 
    PROCEDURESHISTORY  ON PETS.PetID = PROCEDURESHISTORY.PetID
GROUP BY 
    PETS.PetID, PETS.Name; 




