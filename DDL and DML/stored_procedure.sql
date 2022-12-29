USE SAMPLEDB
GO


-- Return all employees from the 'Finance' department:

SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name 
	FROM hcm.employees e INNER JOIN hcm.departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';


GO

CREATE PROCEDURE hcm.getEmployeesByDepartment (@department_name VARCHAR(50))
AS
SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name 
	FROM hcm.employees e INNER JOIN hcm.departments d
ON e.department_id = d.department_id
WHERE d.department_name = @department_name;

GO

--execute hcm.getEmployeesByDepartment stored procedure to get 
-- all employees in the 'Finance' department:
EXECUTE hcm.getEmployeesByDepartment @department_name = 'Finance';

--or:
EXECUTE hcm.getEmployeesByDepartment 'Finance';


--execute hcm.getEmployeesByDepartment stored procedure to get 
-- all employees in the 'Sales' department:
EXECUTE hcm.getEmployeesByDepartment @department_name = 'Sales';

