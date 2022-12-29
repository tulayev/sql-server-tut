USE SAMPLEDB
GO


-- Selecting all data from the hcm.employees table:

SELECT *
FROM hcm.employees;


-- How many employees are there in each department?

SELECT department_id, COUNT(*) AS employee_count
FROM hcm.employees
GROUP BY department_id;


-- What is the average salary in each department? Order by average salary from highest to lowest:

SELECT department_id, AVG(salary) AS avg_salary
FROM hcm.employees
GROUP BY department_id
ORDER BY avg_salary DESC;


-- Selecting all data from the oes.inventories table:

SELECT *
FROM oes.inventories;


-- Give the total number of products on hand at each warehouse. 
-- Limit the result to only warehouses which have greater than 5000 product items on hand:

SELECT warehouse_id, SUM(quantity_on_hand) as total_products_on_hand
FROM oes.inventories
GROUP BY warehouse_id
HAVING SUM(quantity_on_hand) > 5000;


-- Selecting all data from the bird.antarctic_populations table:

SELECT *
FROM bird.antarctic_populations;


-- What is the date for the most recent population count for each locality in the bird.anarctic_populations table?

SELECT 
	locality, 
	MAX(date_of_count) AS date_of_recent_pop_count
FROM bird.antarctic_populations
GROUP BY locality;


-- What is the date of the most recent population count for each species at each locality in the bird.anarctic_populations table?

SELECT 
	locality, 
	species_id,
	MAX(date_of_count) AS date_of_recent_pop_count
FROM bird.antarctic_populations
GROUP BY locality, species_id;







