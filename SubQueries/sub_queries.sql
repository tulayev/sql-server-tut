USE SAMPLEDB
GO


-- Self-contained Subquery
/*
Return the following product details for the cheapest product(s) in the oes.products table:
*/

SELECT 
	product_id,
	product_name,
	list_price,
	category_id
FROM oes.products
WHERE list_price = (SELECT 
						MIN(list_price)
					FROM oes.products);


-- Correlated Subquery
/*
Use a correlated subquery to return the following product details for the cheapest product(s) in each product category
as given by the category_id column:
*/

SELECT 
	product_id,
	product_name,
	list_price,
	category_id
FROM oes.products p1
WHERE list_price IN (SELECT  
						MIN(list_price)
					FROM oes.products p2
					WHERE p2.category_id = p1.category_id);


-- Correlated Subquery (using JOIN)
/*
Use a correlated subquery to return the following product details for the cheapest product(s) in each product category
as given by the category_id column:
*/

SELECT 
	p1.product_id,
	p1.product_name,
	p1.list_price,
	p1.category_id
FROM oes.products p1
INNER JOIN (SELECT 
				category_id,
				MIN(list_price) AS min_price
			FROM oes.products
			GROUP BY category_id) p2
ON p1.category_id = p2.category_id
AND p1.list_price = p2.min_price;


-- CTE style (CTE syntax)
/*
Return the same result as above i.e. the cheapest product(s) in each product category except this
time by using a common table expression.
*/

WITH cte
AS
(
SELECT product_id, product_name, list_price, category_id,
	RANK() OVER (PARTITION BY category_id ORDER BY list_price) AS rnk -- RANK() Window function
FROM oes.products
)
SELECT cte.product_id, cte.product_name, cte.list_price, cte.category_id, cte.rnk
FROM cte
WHERE cte.rnk = 1;


-- CTE style
/*
Repeat challenge the example above, except this time include the product category name as given in the oes.product_categories table.
*/

WITH cte
AS
(
SELECT product_id, product_name, list_price, category_id,
	RANK() OVER (PARTITION BY category_id ORDER BY list_price) AS rnk -- RANK() Window function
FROM oes.products
)
SELECT cte.product_id, cte.product_name, cte.list_price, cte.category_id, cte.rnk, pc.category_name
FROM cte
JOIN oes.product_categories pc
ON pc.category_id = cte.category_id
WHERE cte.rnk = 1;


-- NOT IN usage
/*
Use the NOT IN operator to return all employees who have never been the
salesperson for any customer order. Include the following columns from hcm.employees:
The problem is that not in returns empty rows if employee_id is null*
*/

SELECT 
	employee_id,
	first_name,
	last_name
FROM hcm.employees
WHERE employee_id NOT IN (SELECT 
							employee_id 
						  FROM oes.orders
						  WHERE employee_id IS NOT NULL);


-- NOT EXISTS usage
/*
Return the same result as above, except use WHERE NOT EXISTS
*/

SELECT 
	employee_id,
	first_name,
	last_name
FROM hcm.employees e
WHERE NOT EXISTS (SELECT * 
				  FROM oes.orders o
				  WHERE e.employee_id = o.employee_id);


-- Self-contained Subquery
/*
Return unique customers who have ordered the 'PBX Smart Watch 4’.
*/

SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
	c.email
FROM oes.customers c
JOIN oes.orders o
ON o.customer_id = c.customer_id
JOIN oes.order_items oi
ON oi.order_id = o.order_id
JOIN oes.products p
ON oi.product_id = p.product_id
WHERE c.customer_id IN (SELECT o.customer_id
					    FROM oes.orders o
					    JOIN oes.order_items oi
					    ON oi.order_id = o.order_id
						JOIN oes.products p
						ON oi.product_id = p.product_id
						WHERE p.product_name = 'PBX Smart Watch 4');
-- To see check the result is correct run the following script:
/*
SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
	c.email,
	p.product_name
FROM oes.customers c
JOIN oes.orders o
ON o.customer_id = c.customer_id
JOIN oes.order_items oi
ON oi.order_id = o.order_id
JOIN oes.products p
ON oi.product_id = p.product_id
WHERE p.product_name = 'PBX Smart Watch 4';
*/