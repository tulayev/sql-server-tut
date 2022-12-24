USE SAMPLEDB
GO


-- CREATE statement
/*
Create a table called dept in the dbo schema. Specify the following columns:
- dept_id INT
- dept_name VARCHAR(50)
Give the IDENTITY property to the dept_id column. Also, put a primary key constraint on the dept_id column. Put a NOT NULL
constraint on the dept_name column.
*/

CREATE TABLE dbo.dept
(
	dept_id INT IDENTITY(1, 1),
	dept_name VARCHAR(50) NOT NULL,
	CONSTRAINT PK_dept_dept_id PRIMARY KEY (dept_id)
);


-- INSERT statement
/*
Write an insert statement to insert the following row into the dbo.dept table:
*/

INSERT INTO dbo.dept 
	(dept_name)
VALUES 
	('Business Intelligence');


-- INSERT statement
/*
Populate the dbo.dept table with more rows: Insert all department names from the hcm.departments table.
*/

INSERT INTO dbo.dept (dept_name)
SELECT 
	department_name 
FROM hcm.departments;


-- CREATE statement
/*
Create a table called emp in the dbo schema. Specify the following columns:
- emp_id INT
- first_name VARCHAR(50)
- last_name VARCHAR(50)
- hire_date DATE
- dept_id INT
Give the IDENTITY property to the emp_id column. Also, put a primary key constraint on the emp_id column. Put NOT NULL constraints on any 
columns you think need them. Put a foreign key constraint on the dept_id column whichreferences back to the dept_id column from the 
dbo.dept table.
*/

CREATE TABLE dbo.emp 
(
	emp_id INT IDENTITY(1, 1),
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	hire_date DATE,
	dept_id INT NOT NULL,
	CONSTRAINT PK_emp_emp_id PRIMARY KEY (emp_id),
	CONSTRAINT FK_dept_dept_id FOREIGN KEY (dept_id) REFERENCES dept (dept_id)
);


-- INSERT statement
/*
Populate the dbo.emp table with the following two employees:
*/

INSERT INTO dbo.emp 
	(first_name, last_name, hire_date, dept_id)
VALUES 
	('Scott', 'Davis', '2020-12-11', 1),
	('Miriam', 'Yardley', '2020-12-05', 1);


-- UPDATE statement
/*
Update Miriams last name from Yardley to Greenbank
*/

UPDATE dbo.emp
SET last_name = 'Greenbank'
WHERE emp_id = 2;


-- DELETE statement
/*
Delete employe Scott Davis from dbo.emp table
*/

DELETE FROM dbo.emp
WHERE emp_id = 1;


-- DROP statement
/*
Delete the dbo.dept table
*/

DROP TABLE IF EXISTS SAMPLEDB.dbo.dept;
GO

-- ALTER statement
/*
The command above throws an error that it cannot drop the specified table, because of foreign key constraint from dbo.emp table.
So we can either drop the dbo.emp table or drop the foreign key constraint.
*/

ALTER TABLE SAMPLEDB.dbo.emp
DROP FK_dept_dept_id
GO