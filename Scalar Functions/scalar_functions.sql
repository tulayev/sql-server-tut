USE SAMPLEDB
GO


-- CONCAT function
/*
Concatenate the first name and last name of each employee. Include a single space between the first and last name. 
Name the new expression employee_name.
*/

SELECT 
	employee_id,
	first_name,
	last_name,
	CONCAT(first_name, ' ', last_name) AS employee_name
FROM hcm.employees;


-- CONCAT function
/*
Concatenate the first name, middle name, and last name of each employee. Include a single space between each of the names. 
Name the new expression employee_name.
*/

SELECT 
	employee_id,
	first_name,
	last_name,
	CONCAT(first_name, ' ' + middle_name, ' ', last_name) AS employee_name
FROM hcm.employees;


-- LEFT and CHARINDEX functions
/*
Extract the genus name from the scientific_name as given in the bird.antarctic_species table.
*/

SELECT 
	scientific_name,
	LEFT(scientific_name, CHARINDEX(' ', scientific_name)) AS genus_name
FROM bird.antarctic_species;


-- DATEDIFF function
/*
Return the age in years for all employees. Name this expression as employee_age.
*/

SELECT 
	employee_id,
	first_name,
	last_name,
	birth_date,
	DATEDIFF(year, birth_date, CURRENT_TIMESTAMP) AS employee_age
FROM hcm.employees;


-- DATEADD function
/*
Assuming an estimated shipping date of 7 days after the order date, add a column expression called
estimated_shipping_date for all unshipped orders.
*/

SELECT
	order_id,
	order_date,
	DATEADD(day, 7, order_date) AS estimated_shipping_date
FROM oes.orders; 


-- DATEDIFF function
/*
Calculate the average number of days it takes each shipping company to ship an order. Call this expression
avg_shipping_days
*/

SELECT
	sh.company_name,
	AVG(DATEDIFF(day, o.order_date, o.shipped_date)) AS avg_shipping_days
FROM oes.orders o
JOIN oes.shippers sh
ON o.shipper_id = sh.shipper_id
GROUP BY sh.company_name;


-- CASE expression
/*
Select the following columns from the oes.products table:
	• product_id
	• product_name
	• discontinued
Include a CASE expression in the SELECT statement called discontinued_description. Give this expression the string ‘No’ when
the discontinued column equals 0 and a string of ‘Yes’ when the discontinued column equals 1. In all other cases give the expression
the string of ‘unknown’
*/

SELECT 
	product_id,
	product_name,
	CASE discontinued
		WHEN 1 THEN 'Yes'
		WHEN 0 THEN 'No'
		ELSE 'unknown'
	END AS discontinued_description
FROM oes.products;


-- CASE expression
/*
Select the following columns from the oes.products table:
	• product_id
	• product_name
	• list_price
• Include a CASE expression in the SELECT statement called price_grade. For this expression..
• If list_price is less than 50 then give the string ‘Low’.
• If list_price is greater than or equal to 50 and list_price is less than 250 then give the string ‘Medium’.
• If list_price is greater than or equal to 250 then give the string ‘High’.
• In all other cases, give the expression the string of ‘unknown’.
*/

SELECT 
	product_id,
	product_name,
	list_price,
	CASE 
		WHEN list_price < 50 THEN 'Low'
		WHEN list_price >= 50 AND list_price < 250 THEN 'Medium'
		WHEN list_price >= 250 THEN 'High'
		ELSE 'unknown'
	END AS price_grade
FROM oes.products;


-- CASE expression
/*
Select the following columns from the oes.orders table:
	• order_id
	• order_date
	• shipped_date
• Include a CASE expression called shipping_status which determines the difference in days between the order_date and the shipped_date. 
  When this difference is less than or equal to 7 then give the string value ‘Shipped within one week’.
• If the difference is greater than 7 days, then give the string ‘Shipped over a week later’.
• If shipped_date is null then give the string ‘Not yet shipped’.
*/

SELECT
	order_id,
	order_date,
	shipped_date,
	CASE 
		WHEN DATEDIFF(day, order_date, shipped_date) <= 7 THEN 'Shipped within one week'
		WHEN DATEDIFF(day, order_date, shipped_date) > 7 THEN 'Shipped over a week later'
		WHEN shipped_date IS NULL THEN 'Not yet shipped'
	END AS shipping_status
FROM oes.orders;


-- CASE expression
/*
Repeat the example above to derive the shipping_status expression, but this time get the count of orders by the
shipping_status expression.
*/

SELECT
	s.shipping_status,
	COUNT(*) AS count_of_orders
FROM (
	  SELECT
		  CASE 
			WHEN DATEDIFF(day, order_date, shipped_date) <= 7 THEN 'Shipped within one week'
			WHEN DATEDIFF(day, order_date, shipped_date) > 7 THEN 'Shipped over a week later'
		    ELSE 'Not yet shipped' END AS shipping_status
	  FROM oes.orders	
	  ) s
GROUP BY s.shipping_status;
