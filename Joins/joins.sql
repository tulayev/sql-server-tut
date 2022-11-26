USE SAMPLEDB
GO


-- INNER JOIN
-- Write a query to return the following attributes for employees who belong to a department:

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	e.salary, 
	d.department_name 
FROM hcm.employees e
JOIN hcm.departments d 
ON d.department_id = e.department_id;


-- LEFT JOIN 
-- Write a query to return the following attributes for all employees, including employees who do not belong to a department:

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	e.salary, 
	d.department_name 
FROM hcm.employees e
LEFT JOIN hcm.departments d 
ON d.department_id = e.department_id;


-- LEFT JOIN
-- Write a query to return the total number of employees in each department. Include the department_name in the 
-- query result. Also, include employees who have not been assigned to a department

SELECT 
	d.department_name,
	COUNT(e.employee_id) AS employees_count_per_department -- or COUNT(*) AS  employees_count_per_department
FROM hcm.employees e
LEFT JOIN hcm.departments d 
ON d.department_id = e.department_id
GROUP BY d.department_name;


-- Self referencing JOIN
-- Write a query to return employee details for all employees as well as the first and last name of each employee's manager. Include the following columns:

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	m.first_name AS manager_first_name, 
	m.last_name AS manager_last_name
FROM hcm.employees e
LEFT JOIN hcm.employees m
ON e.manager_id = m.employee_id;


-- Multiple tables JOIN
-- Write a query to return all the products at each warehouse. Include the following attributes:

SELECT 
	p.product_id, 
	p.product_name, 
	w.warehouse_id, 
	w.warehouse_name, 
	i.quantity_on_hand
FROM oes.products p
JOIN oes.inventories i
ON i.product_id = p.product_id
JOIN oes.warehouses w
ON i.warehouse_id = w.warehouse_id;


-- Multiple tables JOIN
-- Write a query to return the following attributes for all employees from Australia.

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	d.department_name, 
	j.job_title, 
	e.state_province, 
	c.country_name
FROM hcm.employees e
LEFT JOIN hcm.departments d
ON e.department_id = d.department_id
JOIN hcm.jobs j
ON e.job_id = j.job_id
JOIN hcm.countries c
ON e.country_id = c.country_id
WHERE c.country_name = 'Australia';


-- Return the total quantity ordered of each product in each category. Do not include products which have never been
-- ordered. Include the product name and category name in the query. Order the results by category name from A to Z and
-- then within each category name order by product name from A to Z.

SELECT 
	p.product_name, 
	c.category_name, 
	SUM(oi.quantity) AS total_ordered
FROM oes.products p
JOIN oes.order_items oi
ON oi.product_id = p.product_id
JOIN oes.product_categories c
ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY c.category_name, p.product_name;



-- Return the total quantity ordered of each product in each category. Include products which have never been ordered and
-- give these a total quantity ordered of 0. Include the product name and category name in the query. Order the results by category
-- name from A to Z and then within each category name order by product name from A to Z.

SELECT 
	p.product_name, 
	c.category_name, 
	SUM(ISNULL(oi.quantity, 0)) AS total_ordered -- or COALESCE(SUM(oi.quantity), 0) AS total_ordered
FROM oes.products p
LEFT JOIN oes.order_items oi
ON oi.product_id = p.product_id
JOIN oes.product_categories c
ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY c.category_name, p.product_name;