USE SAMPLEDB
GO



-- UNION ALL
/*
Return all rows from both the bird.california_sightings table and the bird.arizona_sightings table. Use column
names from the bird.california_sightings table.
*/

SELECT
	sighting_id,
	common_name,
	scientific_name,
	location_of_sighting,
	sighting_date
FROM bird.california_sightings
UNION ALL
SELECT
	sighting_id,
	common_name,
	scientific_name,
	sighting_location,
	sighting_date
FROM bird.arizona_sightings;


-- UNION
/*
Return all unique species - as identified by the scientific_name column – for species which have been
sighted in either California or Arizona. Use column names from the bird.california_sightings table.
*/

SELECT
	scientific_name
FROM bird.california_sightings
UNION 
SELECT
	scientific_name
FROM bird.arizona_sightings;


-- UNION
/*
Return all unique combinations of species (scientific_name) and state name. The state_name will
need to be added on as a new expression which gives the applicable state name. Use column names from the
bird.california_sightings table. Order by state_name and then by scientific_name in ascending order.*/SELECT	scientific_name,	'California' AS state_nameFROM bird.california_sightingsUNIONSELECT 	scientific_name,	'Arizona'FROM bird.arizona_sightingsORDER BY state_name, scientific_name;-- UNION ALL/*
Return all rows from all the bird sightings tables i.e. Arizona, California and Florida. Use column names from
the bird.california_sightings table.*/SELECT	sighting_id,
	common_name,
	scientific_name,
	location_of_sighting,
	sighting_dateFROM bird.california_sightingsUNION ALLSELECT 	sighting_id,
	common_name,
	scientific_name,
	sighting_location,
	sighting_dateFROM bird.arizona_sightingsUNION ALLSELECT	observation_id,
	NULL AS common_name,
	scientific_name,
	locality,
	CAST(sighting_datetime AS DATE)FROM bird.florida_sightings;-- INTERSECT/*Return all unique customer ids for customers who have placed orders.*/SELECT	customer_idFROM oes.customersINTERSECTSELECT	customer_idFROM oes.orders;-- EXCEPT/*Return all unique product ids for products that are currently not in stock.*/SELECT	product_idFROM oes.productsEXCEPTSELECT	product_idFROM oes.inventories;