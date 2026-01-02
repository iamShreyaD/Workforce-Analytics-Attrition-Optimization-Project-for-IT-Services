# number of records
SELECT COUNT(*)
FROM employee_raw;

# creating new table and storing the data from employee_raw in it
CREATE TABLE employee_clean
LIKE employee_raw;

INSERT employee_clean
SELECT *
FROM employee_raw;

# check for new table's data
SELECT *
FROM employee_clean;

