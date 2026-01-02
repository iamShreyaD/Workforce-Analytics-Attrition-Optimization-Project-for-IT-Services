CREATE TABLE employee_analytics AS
SELECT
  EmployeeID,
  STATUS_YEAR,
  STATUS,
  BUSINESS_UNIT,
  department_name,
  job_title,
  city_name,
  store_name,
  gender_short AS gender,

  /* Cleaned termination date */
  CASE
    WHEN terminationdate_key = '1/1/1900' THEN NULL
    ELSE STR_TO_DATE(terminationdate_key, '%c/%e/%Y')
  END AS termination_date,
  STR_TO_DATE(orighiredate_key, '%c/%e/%Y') AS hire_date,
  STR_TO_DATE(birthdate_key, '%c/%e/%Y') AS birth_date,
  age,
  length_of_service,
  termreason_desc,
  termtype_desc
FROM employee_raw;

SELECT COUNT(*) FROM employee_analytics;

SELECT COUNT(*)
FROM employee_analytics
WHERE termination_date IS NULL;

