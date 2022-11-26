USE SAMPLEDB
GO



-- UNION ALL
-- Return all rows from both the bird.california_sightings table and the bird.arizona_sightings table. Use column
-- names from the bird.california_sightings table.

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
-- Return all unique species - as identified by the scientific_name column � for species which have been
-- sighted in either California or Arizona. Use column names from the bird.california_sightings table.

SELECT
	scientific_name
FROM bird.california_sightings
UNION 
SELECT
	scientific_name
FROM bird.arizona_sightings;


-- UNION
-- Return all unique combinations of species (scientific_name) and state name. The state_name will
-- need to be added on as a new expression which gives the applicable state name. Use column names from the
-- bird.california_sightings table. Order by state_name and then by scientific_name in ascending order.
-- the bird.california_sightings table.
	common_name,
	scientific_name,
	location_of_sighting,
	sighting_date
	common_name,
	scientific_name,
	sighting_location,
	sighting_date
	NULL AS common_name,
	scientific_name,
	locality,
	CAST(sighting_datetime AS DATE)