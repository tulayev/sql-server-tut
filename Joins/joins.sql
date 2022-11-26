USE SAMPLEDB
GO


-- INNER JOIN --

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	e.salary, 
	d.department_name 
FROM hcm.employees e
JOIN hcm.departments d 
ON d.department_id = e.department_id;


-- LEFT JOIN --

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	e.salary, 
	d.department_name 
FROM hcm.employees e
LEFT JOIN hcm.departments d 
ON d.department_id = e.department_id;


-- Get the total number of employees per department (LEFT JOIN) --

SELECT 
	d.department_name,
	COUNT(e.employee_id) AS employees_count_per_department -- or COUNT(*) AS  employees_count_per_department
FROM hcm.employees e
LEFT JOIN hcm.departments d 
ON d.department_id = e.department_id
GROUP BY d.department_name;


-- Select employees with their corresponding managers (Self referencing JOIN) --

SELECT 
	e.employee_id, 
	e.first_name, 
	e.last_name, 
	m.first_name AS manager_first_name, 
	m.last_name AS manager_last_name
FROM hcm.employees e
LEFT JOIN hcm.employees m
ON e.manager_id = m.employee_id;


-- All products at each warehouse (Multiple tables JOIN) --

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


-- All employees with job, country and department data from Australia (Multiple tables JOIN) --

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


-- The total quantity ordered of each product in each category --

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


-- The total quantity ordered of each product (include products which have never been ordered) in each category --

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