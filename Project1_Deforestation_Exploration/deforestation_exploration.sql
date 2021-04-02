
-- Create a View called “forestation” by joining all three tables - forest_area, land_area and regions in the workspace.
DROP VIEW IF EXISTS forestation;

CREATE VIEW forestation AS
SELECT f.country_code country_code,
       f.country_name country_name,
       f.year "year",
       f.forest_area_sqkm forest_area_sqkm,
       l.total_area_sq_mi total_area_sq_mi,
       l.total_area_sq_mi * 2.59 total_area_sqkm,
       r.region region,
       r.income_group income_group,

       (f.forest_area_sqkm/(l.total_area_sq_mi*2.59))*100 pct_forest
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

DROP VIEW IF EXISTS global_situation;

CREATE VIEW global_situation AS
WITH t_2016 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 2016),
t_1990 AS (
    SELECT year, region, forest_area_sqkm
    FROM forestation
    WHERE region = 'World' AND year = 1990)
SELECT t_1990.region,
       t_1990.forest_area_sqkm forest_area_sqkm_1990,
       t_2016.forest_area_sqkm forest_area_sqkm_2016
FROM t_1990, t_2016;

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

SELECT forest_area_sqkm_2016 - forest_area_sqkm_1990 forest_area_change_sqkm
FROM global_situation;

-- forest_area_change_sqkm
-- -1324449

-- d. What was the percent change in forest area of the world between 1990 and 2016?

SELECT (forest_area_sqkm_2016 - forest_area_sqkm_1990)/forest_area_sqkm_1990 *100 forest_area_pct_change_sqkm
FROM global_situation;

-- forest_area_pct_change_sqkm
-- -3.20824258980244

-- e. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
SELECT f.country_name,
       ABS(f.total_area_sqkm - ( g.forest_area_sqkm_1990 - g.forest_area_sqkm_2016)) diff_area
FROM forestation f, global_situation g
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

DROP VIEW IF EXISTS regional_outlook;

CREATE VIEW regional_outlook AS
WITH t_2016 AS (
    SELECT  region, ROUND(CAST(SUM(forest_area_sqkm)/SUM(total_area_sqkm)*100 AS NUMERIC), 2) pct_forest_area_2016
    FROM forestation
    WHERE year = 2016
    GROUP BY region),
t_1990 AS (
    SELECT  region, ROUND(CAST(SUM(forest_area_sqkm)/SUM(total_area_sqkm)*100 AS NUMERIC), 2) pct_forest_area_1990
    FROM forestation
    WHERE year = 1990
    GROUP BY region)
SELECT t_1990.region, t_1990.pct_forest_area_1990, t_2016.pct_forest_area_2016
FROM t_1990
JOIN t_2016
ON t_1990.region = t_2016.region;

SELECT * FROM regional_outlook;

-- region	pct_forest_area_1990	pct_forest_area_2016
-- Latin America & Caribbean	51.03	46.16
-- Sub-Saharan Africa	30.67	28.79
-- Europe & Central Asia	37.28	38.04
-- East Asia & Pacific	25.78	26.36
-- South Asia	16.51	17.51
-- Middle East & North Africa	1.78	2.07
-- World	32.42	31.38
-- North America	35.65	36.04

-- a. What was the percent forest of the entire world in 2016? Which region had the HIGHEST percent forest in 2016, and which had the LOWEST, to 2 decimal places?

SELECT region, pct_forest_area_2016
FROM regional_outlook
WHERE region = 'World';

-- region	pct_forest_area_2016
-- World	31.38

SELECT region, pct_forest_area_2016
FROM regional_outlook
WHERE region != 'World'
ORDER BY pct_forest_area_2016 DESC
LIMIT 1;

-- region	pct_forest_area_2016
-- Latin America & Caribbean	46.16

SELECT region, pct_forest_area_2016
FROM regional_outlook
WHERE region != 'World'
ORDER BY pct_forest_area_2016
LIMIT 1;

-- region	pct_forest_area_2016
-- Middle East & North Africa	2.07

-- b. What was the percent forest of the entire world in 1990? Which region had the HIGHEST percent forest in 1990, and which had the LOWEST, to 2 decimal places?
SELECT region, pct_forest_area_1990
FROM regional_outlook
WHERE region = 'World'

-- region	pct_forest_area_1990
-- World	32.42

SELECT region, pct_forest_area_1990
FROM regional_outlook
WHERE region != 'World'
ORDER BY pct_forest_area_1990 DESC
LIMIT 1;

-- region	pct_forest_area_1990
-- Latin America & Caribbean	51.03

SELECT region, pct_forest_area_1990
FROM regional_outlook
WHERE region != 'World'
ORDER BY pct_forest_area_1990
LIMIT 1;

-- region	pct_forest_area_1990
-- Middle East & North Africa	1.78

-- c. Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?
SELECT region
FROM regional_outlook
WHERE region != 'World' AND pct_forest_area_1990 > pct_forest_area_2016;

-- region
-- Latin America & Caribbean
-- Sub-Saharan Africa

======================= 3. COUNTRY-LEVEL DETAIL=======================
-- Instructions:
--
-- Answering these questions will help you add information into the template.
-- Use these questions as guides to write SQL queries.
-- Use the output from the query to answer these questions.

DROP VIEW IF EXISTS country_detail;

CREATE VIEW country_detail AS
WITH t_2016 AS (
    SELECT country_name, forest_area_sqkm
    FROM forestation
    WHERE year = 2016 AND forest_area_sqkm IS NOT NULL),
t_1990 AS (
    SELECT country_name, forest_area_sqkm
    FROM forestation
    WHERE year = 1990 AND forest_area_sqkm IS NOT NULL)
SELECT t_1990.country_name,
       t_1990.forest_area_sqkm forest_area_sqkm_1990,
       t_2016.forest_area_sqkm forest_area_sqkm_2016
FROM t_1990
JOIN t_2016
ON t_1990.country_name = t_2016.country_name;

SELECT * FROM country_detail;

-- a. Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?
SELECT country_name, forest_area_sqkm_2016 - forest_area_sqkm_1990 diff_forest_area
FROM country_detail
WHERE country_name != 'World'
ORDER BY diff_forest_area
LIMIT 5;

-- b. Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? What was the percent change to 2 decimal places for each?
SELECT country_name,
       ROUND(CAST((forest_area_sqkm_2016 - forest_area_sqkm_1990) / forest_area_sqkm_1990 AS NUMERIC) * 100, 2) forest_area_pct_change
FROM country_detail
WHERE country_name != 'World'
ORDER BY forest_area_pct_change
LIMIT 5;

-- c. If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?
WITH t_quartile AS (
    SELECT country_name, CASE WHEN pct_forest <= 25 THEN '0-25%'
                              WHEN pct_forest <= 50 AND pct_forest> 25 THEN '25-50%'
                              WHEN pct_forest <= 75 AND pct_forest> 50 THEN '50-75%'
                              ELSE '75-100%'
                         END quartile
    FROM forestation
    WHERE pct_forest IS NOT NULL AND country_name != 'World' AND year = 2016)
SELECT quartile, COUNT(country_name)
FROM t_quartile
GROUP BY quartile;

-- quartile	count
-- 25-50%	72
-- 75-100%	9
-- 0-25%	85
-- 50-75%	38

-- d. List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016.

SELECT country_name, pct_forest
FROM forestation
WHERE pct_forest > 75 AND country_name != 'World' AND year = 2016;

-- country_name	pct_forest
-- American Samoa	87.5000875000875
-- Micronesia, Fed. Sts.	91.8572390715248
-- Gabon	90.0376418700565
-- Guyana	83.9014489110682
-- Lao PDR	82.1082317640861
-- Palau	87.6068085491204
-- Solomon Islands	77.8635177945066
-- Suriname	98.2576939676578
-- Seychelles	88.4111367385789

-- e. How many countries had a percent forestation higher than the United States in 2016?
SELECT COUNT(country_name) country_num
FROM forestation
WHERE pct_forest > (SELECT pct_forest FROM forestation
                    WHERE country_name = 'United States' AND year=2016)
      AND country_name != 'World'
      AND year = 2016;

-- country_num
-- 94
