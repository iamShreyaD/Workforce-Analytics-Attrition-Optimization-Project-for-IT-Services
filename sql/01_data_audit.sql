
# This data audit focuses on completeness, logical consistency ,and business validity.

# complete data
SELECT * 
FROM employee_raw;

# to find null values
SELECT
	count(*) total_count,
    SUM(CASE WHEN EmployeeID IS NULL THEN 1 ELSE 0 END) EmployeeId_null,
	SUM(CASE WHEN recorddate_key IS NULL THEN 1 ELSE 0 END) recorddate_key_null,
    SUM(CASE WHEN birthdate_key IS NULL THEN 1 ELSE 0 END) birthdate_key_null,
    SUM(CASE WHEN orighiredate_key IS NULL THEN 1 ELSE 0 END) orighiredate_key_null,
	SUM(CASE WHEN terminationdate_key IS NULL THEN 1 ELSE 0 END) terminationdate_key_null,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) age_null,
    SUM(CASE WHEN length_of_service IS NULL THEN 1 ELSE 0 END) length_of_service_null,
	SUM(CASE WHEN city_name IS NULL THEN 1 ELSE 0 END) city_name_null,
    SUM(CASE WHEN department_name IS NULL THEN 1 ELSE 0 END) department_name_null,
    SUM(CASE WHEN job_title IS NULL THEN 1 ELSE 0 END) job_title_null,
	SUM(CASE WHEN store_name IS NULL THEN 1 ELSE 0 END) store_name_null,
    SUM(CASE WHEN gender_short IS NULL THEN 1 ELSE 0 END) gender_short_null,
    SUM(CASE WHEN gender_full IS NULL THEN 1 ELSE 0 END) gender_full_null,
	SUM(CASE WHEN termreason_desc IS NULL THEN 1 ELSE 0 END) termreason_desc_null,
    SUM(CASE WHEN termtype_desc IS NULL THEN 1 ELSE 0 END) termtype_desc_null,
    SUM(CASE WHEN STATUS_YEAR IS NULL THEN 1 ELSE 0 END) STATUS_YEAR_null,
	SUM(CASE WHEN STATUS IS NULL THEN 1 ELSE 0 END) STATUS_null,
    SUM(CASE WHEN BUSINESS_UNIT IS NULL THEN 1 ELSE 0 END) BUSINESS_UNIT_null
FROM employee_raw;

# Termination date missing or placeholder for terminated employees
SELECT COUNT(*)
FROM employee_raw
WHERE STATUS LIKE 'Terminated' AND terminationdate_key = '1/1/1900';
			
# Employee status is Active but termination date is populated 
SELECT COUNT(*) 
FROM employee_raw 
WHERE STATUS LIKE 'ACTIVE' AND terminationdate_key NOT LIKE '1/1/1900'; 

#Employee status is Terminated but termination reason is missing 
SELECT employeeID 
FROM employee_raw 
WHERE STATUS LIKE 'Terminated' AND termreason_desc LIKE 'Not Applicable'; 

#Termination type present for an active employee 
SELECT employeeID 
FROM employee_raw 
WHERE STATUS LIKE 'ACTIVE' AND termtype_desc NOT LIKE 'Not Applicable';

#Birth date occurring after hire date 
SELECT EmployeeID
FROM employee_raw
WHERE birthdate_key > orighiredate_key;

#Termination date earlier than hire date 
SELECT EmployeeID
FROM employee_raw
WHERE orighiredate_key > terminationdate_key;

#Future dates in historical records
SELECT EmployeeID
FROM employee_raw
WHERE YEAR(orighiredate_key) > 2015 OR YEAR(birthdate_key) > 2015 OR YEAR(terminationdate_key) > 2015 OR YEAR(recorddate_key) > 2015;

#Year in record date not aligning with employee status year
SELECT EmployeeID
FROM employee_raw
WHERE YEAR(recorddate_key) <> STATUS_YEAR;

#Age and length of service consistency
SELECT EmployeeID
FROM employee_raw
WHERE age < 14 OR length_of_service < 0;

#Same employee appearing multiple times in the same year
SELECT COUNT(DISTINCT EmployeeID)
FROM employee_raw
GROUP BY STATUS_YEAR
HAVING COUNT(EmployeeID) > 1;

#Employee switching from Terminated back to Active in later years
SELECT EmployeeID
FROM employee_raw
GROUP BY EmployeeID
HAVING
	MAX(CASE WHEN STATUS = 'TERMINATED' THEN STATUS_YEAR END) <
    MAX(CASE WHEN STATUS = 'ACTIVE' THEN STATUS_YEAR END);

#Missing years in an employee’s timeline
SELECT EmployeeID
FROM employee_raw
GROUP BY EmployeeID
HAVING MAX(STATUS_YEAR) - MIN(STATUS_YEAR) + 1 <> COUNT(DISTINCT STATUS_YEAR);

#Gender represented as both M/F and Male/Female
SELECT EmployeeID, gender_full, gender_short
FROM employee_raw
WHERE 
	(gender_full = "Male" AND gender_short <> 'M') OR
    (gender_full = "Female" AND gender_short <> 'F');

#Multiple spellings of department names
SELECT DISTINCT department_name
FROM employee_raw;

#Mixed casing in status values
SELECT DISTINCT STATUS
FROM employee_raw;

#Same employee appearing multiple times for the same year
SELECT EmployeeID, STATUS_YEAR, COUNT(*)
FROM employee_raw
GROUP BY EmployeeID, STATUS_YEAR
HAVING COUNT(*) > 1; 

#Duplicate rows with identical attributes
SELECT 
	EmployeeID, 
	recorddate_key, 
	birthdate_key, 
	orighiredate_key,
	terminationdate_key, 
	age,
	length_of_service,
	city_name,
	department_name,
	job_title,
	store_name,
	gender_short,
	gender_full,
	termreason_desc,
	termtype_desc,
	STATUS_YEAR,
	STATUS,
	BUSINESS_UNIT,
    COUNT(*)
FROM employee_raw
GROUP BY 
	EmployeeID, 
	recorddate_key, 
	birthdate_key, 
	orighiredate_key,
	terminationdate_key, 
	age,
	length_of_service,
	city_name,
	department_name,
	job_title,
	store_name,
	gender_short,
	gender_full,
	termreason_desc,
	termtype_desc,
	STATUS_YEAR,
	STATUS,
	BUSINESS_UNIT
HAVING COUNT(*) > 1;

#Age not matching birth date and record year
SELECT EmployeeID, STATUS_YEAR
FROM employee_raw
WHERE age <> (STATUS_YEAR - YEAR(birthdate_key));

#Length of service not aligning with hire date
SELECT EmployeeID
FROM employee_raw
WHERE length_of_service <> (YEAR(COALESCE(terminationdate_key, recorddate_key)) - YEAR(orighiredate_key));

#Store employees classified as head office
SELECT EmployeeID
FROM employee_raw
WHERE 
	store_name IS NULL AND
    BUSINESS_UNIT = 'STORES';

#Termination reasons applied to active employees
SELECT EmployeeID
FROM employee_raw
WHERE termreason_desc <> 'Not Applicable' AND STATUS = 'ACTIVE';

#Business unit mismatches with job titles
SELECT EmployeeID
FROM employee_raw
WHERE 
	(job_title LIKE 'Director%' OR
    job_title LIKE 'CEO' OR
    job_title LIKE 'VP%' OR
    job_title LIKE 'Legal%' OR
    job_title LIKE 'Exec%' OR
    job_title LIKE 'CHief%' OR
    job_title LIKE 'Corporate%' OR
    job_title LIKE '%Analyst' OR
    job_title LIKE 'Recruiter%' OR
    job_title LIKE '%Admin' OR
    job_title LIKE '%Clerk' OR
    job_title LIKE 'Auditor%') AND 
    BUSINESS_UNIT <> 'HEADOFFICE';

