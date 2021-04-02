
-- Create a View called “forestation” by joining all three tables - forest_area, land_area and regions in the workspace.
DROP VIEW IF EXISTS forestation;

CREATE VIEW forestation AS
SELECT f.country_code country_code,
       f.country_name country_name,
       f.year "year",
       f.forest_area_sqkm forest_area_sqkm,
       l.total_area_sq_mi total_area_sq_mi,
       r.region region,
       r.income_group income_group,
       (f.forest_area_sqkm/(l.total_area_sq_mi*2.59))*100 percentage_forest
FROM forest_area f
JOIN land_area l
ON f.country_code = l.country_code AND f.year = l.year
JOIN regions r
ON l.country_code = r.country_code;

SELECT * FROM forestation;

======================= 1. GLOBAL SITUATION =======================
-- Instructions:
--
-- Answering these questions will help you add information into the template.
-- Use these questions as guides to write SQL queries.
-- Use the output from the query to answer these questions.

-- a. What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record denoted as “World" in the region table.

SELECT year, region, forest_area_sqkm
FROM forestation
WHERE region = 'World' AND year = 1990;

-- year	region	forest_area_sqkm
-- 1990	World	41282694.9

-- b. What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.”
SELECT year, region, forest_area_sqkm
FROM forestation
WHERE region = 'World' AND year = 2016;

-- year	region	forest_area_sqkm
-- 2016	World	39958245.9

-- c. What was the change (in sq km) in the forest area of the world from 1990 to 2016?
WITH t_2016 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 2016),
t_1990 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 1990)
SELECT t_2016.forest_area_sqkm - t_1990.forest_area_sqkm forest_area_change_sqkm
FROM t_1990, t_2016;

-- forest_area_change_sqkm
-- -1324449

-- d. What was the percent change in forest area of the world between 1990 and 2016?
WITH t_2016 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 2016),
t_1990 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 1990)
SELECT (t_2016.forest_area_sqkm - t_1990.forest_area_sqkm)/t_1990.forest_area_sqkm *100 forest_area__pct_change_sqkm
FROM t_1990, t_2016;

-- forest_area__pct_change_sqkm
-- -3.20824258980244

-- e. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
WITH t_2016 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 2016),
t_1990 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 1990)
SELECT f.country_name, ABS(f.total_area_sq_mi * 2.59  - ( t_1990.forest_area_sqkm - t_2016.forest_area_sqkm)) diff_area
FROM forestation f, t_1990, t_2016
ORDER BY diff_area
LIMIT 1;

-- country_name	diff_area
-- Peru	44449.0109000001

======================= 2. REGIONAL OUTLOOK =======================
-- Instructions:
--
-- Answering these questions will help you add information into the template.
-- Use these questions as guides to write SQL queries.
-- Use the output from the query to answer these questions.
--
-- Create a table that shows the Regions and their percent forest area (sum of forest area divided by sum of land area) in 1990 and 2016. (Note that 1 sq mi = 2.59 sq km).
-- Based on the table you created, ....
--
-- a. What was the percent forest of the entire world in 2016? Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?
--
-- b. What was the percent forest of the entire world in 1990? Which region had the HIGHEST percent forest in 1990, and which had the LOWEST, to 2 decimal places?
--
-- c. Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?





