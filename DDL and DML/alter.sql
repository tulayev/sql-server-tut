USE SAMPLEDB
GO


-- ALTER
/*
Add a new column called 'termination_date' onto the hcm.employees table. Give this new column a data type of DATE. Then drop the column.
*/

ALTER TABLE hcm.employees
ADD termination_date DATE;

ALTER TABLE hcm.employees
DROP COLUMN termination_date;


-- ALTER
/*
Write two SQL statements to change the data type of the first_name and last_name columns to NVARCHAR(60) in the oes.customers table.
*/

ALTER TABLE oes.customers
ALTER COLUMN first_name NVARCHAR(60);
ALTER TABLE oes.customers
ALTER COLUMN last_name NVARCHAR(60);


-- UNIQUE CONSTRAINT
/*
Use an ALTER TABLE statement to add a UNIQUE constraint to the department_name column in the hcm.departments table. But before check the
hcm.department table department_name column has the unique values only.
*/

SELECT COUNT(*) AS total_count, COUNT(DISTINCT(department_name)) AS unique_values_count
FROM hcm.departments;

ALTER TABLE hcm.departments
ADD CONSTRAINT uk_departments_department_name UNIQUE (department_name);


-- CHECK CONSTRAINT
/*
Use an ALTER TABLE statement to add a CHECK constraint on the salary column in the hcm.employees table to ensure that salary is greeater than
or equal to 0.
*/

SELECT salary
FROM hcm.employees;

ALTER TABLE hcm.employees
ADD CONSTRAINT chk_employees_salary CHECK (salary >= 0);


-- sp_rename
/*
Use sp_rename to rename the column name 'phone' to 'main_phone' in the oes.customers table. Note that this challenge does not use an 
ALTER TABLE statement.
*/

EXECUTE sp_rename 'oes.customers.phone', 'main_phone', 'COLUMN';