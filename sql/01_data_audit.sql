# i am giving queries that i thought are right for these steps. correct me if i am wrong or do i need to add anything else. this way i can also practice my sql query writing. 1. select employeeid, count(status_year) from employee_raw group by employeeid having count(status_year); this query is showing that not every employeeid has count(status_year) 10. there are records like 3, 4, 5 as well for some of them. 2. select count(recorddate_key) from employee_raw where terminationdate_key < recorddate_key; there are 45000+ records select count(employeeID) from employee_raw where STATUS not like 'ACTIVE'; THERE are 1485 records. 3. select count(termincationdate_key) from employee_raw where terminationdate_key is null; there are 0 records. so i did not checked it against 'where status like 'active'' select count(terminationdate_key) from employee_raw where terminationdate_key like '%1900' and STATUS like 'ACTIVE'; there are 42450 employees with terminationdate_key is 1/1/1900. so basically it should have been null, that is those employees are not terminated. SELECT termination_reason from ( select * from employee_raw where termincationdate_key not like '%1900' and status not like 'active');

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

SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT EmployeeID) AS unique_employees,
  COUNT(DISTINCT EmployeeID || recorddate_key) AS unique_employee_years
FROM employee_raw;


SELECT DISTINCT termreason_desc 
FROM employee_raw;

SELECT DISTINCT termtype_desc
FROM employee_raw;

SELECT DISTINCT orighiredate_key
FROM employee_raw;

SELECT DISTINCT BUSINESS_UNIT 
FROM employee_raw;

select COUNT(EmployeeID) from employee_raw where STATUS NOT LIKE 'ACTIVE';

select count(terminationdate_key) from employee_raw where terminationdate_key is null;

select count(terminationdate_key) from employee_raw where terminationdate_key like '%1900' and STATUS like 'ACTIVE';

SELECT termreason_desc from employee_raw where termreason_desc like (
select termreason_desc from employee_raw where terminationdate_key not like '%1900' and status not like 'active');

select * from employee_raw where terminationdate_key not like '%1900' and status not like 'active';