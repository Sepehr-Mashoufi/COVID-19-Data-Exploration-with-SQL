-- Note:
-- The analysis is based on COVID-19 cases, deaths, and vaccination data
-- Reported between January 22, 2020 and April 30, 2021.
-- The dataset was downloaded from Our World in Data and includes
-- Data for approximately 190 countries across multiple continents.

USE Portfolio_Covid;

-- First, convert the date column from text format to DATE data type.
UPDATE COVIDDEATHS
SET `date` = DATE_FORMAT(STR_TO_DATE(`date`, '%c/%e/%y'),'%Y-%m-%d');
ALTER TABLE COVIDDEATHS
MODIFY COLUMN `date` DATE;
UPDATE COVIDVACCINATIONS
SET `date` = DATE_FORMAT(STR_TO_DATE(`date`, '%c/%e/%y'),'%Y-%m-%d');
ALTER TABLE COVIDVACCINATIONS
MODIFY COLUMN `date` DATE;

-- Identify the countries with the highest and lowest COVID-19 death rates relative to their populations.
SELECT 
location, 
population, 
MAX(CAST(total_deaths AS SIGNED)) AS Total_Deaths, 
MAX(CAST(total_deaths AS SIGNED)/population)*100 AS Total_Densed_Deaths
FROM COVIDDEATHS
WHERE continent IS NOT NULL AND continent != ''
GROUP BY location, population
ORDER BY 3 DESC;
-- The highest reported number of COVID-19 deaths was recorded in the United States, with 576,232 deaths,
-- while several countries, including Vatican City, reported no deaths during the analyzed period.
-- However, comparing absolute death counts can be misleading due to significant differences in population sizes.
-- A more meaningful metric is the death rate relative to the population.
-- Based on deaths as a percentage of population, Hungary recorded the highest death rate at approximately 0.29%,
-- while Vatican City remained among the countries with the lowest reported death rate.

###

-- Now, perform the same analysis at the continent level.
WITH CTE_CONTINENT_DEATH AS
(
SELECT 
continent, 
location, 
population, 
MAX(CAST(total_deaths AS SIGNED)) AS Total_Death
FROM COVIDDEATHS
WHERE continent IS NOT NULL AND continent != ''
GROUP BY continent, location, population
ORDER BY 1
)
SELECT 
Continent, 
SUM(Population) AS Population_Continent,
SUM(Total_Death) AS Total_Death_Continent, 
SUM(Total_Death)/ SUM(Population) * 100 AS Densed_Death_Continent
FROM CTE_CONTINENT_DEATH
GROUP BY Continent
ORDER BY 3 DESC;
-- At the continent level, Europe recorded the highest number of COVID-19 deaths, with more than 1,016,750 reported fatalities,
-- while Oceania recorded the lowest number, with 1,046 deaths during the analyzed period.
-- However, absolute figures do not account for differences in population size.
-- When deaths are normalized by population, Oceania still has the lowest death rate at approximately 0.0025%,
-- whereas South America records the highest death rate at approximately 0.16%.

###

-- We can also aggregate the data by date to examine the global progression of the pandemic.
-- This allows us to track daily reported cases and deaths worldwide, calculate the corresponding death rate,
-- and observe how the impact of COVID-19 evolved over time.
SELECT date, 
SUM(CAST(new_deaths AS SIGNED)) AS Total_Death_on_this_date, 
SUM(new_cases) AS Infected_on_this_date,
SUM(CAST(new_deaths AS SIGNED))/SUM(new_cases) * 100 AS Death_Percentage_on_this_date
FROM COVIDDEATHS
WHERE continent IS NOT NULL AND continent!=''
GROUP BY date;

-- Convert the new_vaccinations column from text to an integer data type.
UPDATE COVIDVACCINATIONS
SET NEW_VACCINATIONS = NULL
WHERE TRIM(NEW_VACCINATIONS) = '';
ALTER TABLE COVIDVACCINATIONS
MODIFY COLUMN NEW_VACCINATIONS INT;

-- Identify when each country first started administering COVID-19 vaccinations.
SELECT 
cd.continent, 
cd.location, 
cd.date, 
cv.new_vaccinations
FROM COVIDDEATHS cd
INNER JOIN COVIDVACCINATIONS cv
ON cd.date = cv.date AND cd.location = cv.location
WHERE new_vaccinations > 0
ORDER BY date ASC;
-- Based on the available data, Mexico reported the first recorded COVID-19 vaccinations on December 28, 2020,
-- administering 2,755 doses on that date.
-- By the end of the analyzed period, the cumulative number of vaccinations in Mexico had reached 15,365,049.

###

-- Calculate the percentage of each country's population that had been vaccinated by the end of the analyzed period.
UPDATE COVIDVACCINATIONS
SET NEW_VACCINATIONS = NULL
WHERE TRIM(NEW_VACCINATIONS) = '';

SELECT 
cd.location, 
cd.population, 
SUM(cv.NEW_VACCINATIONS) AS Total_Vaccination, 
SUM(cv.NEW_VACCINATIONS)/cd.population * 100 AS Vaccinated_Percentage
FROM COVIDDEATHS cd
INNER JOIN COVIDVACCINATIONS cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent IS NOT NULL AND cd.continent !=''
GROUP BY cd.location, cd.population
ORDER BY 4 DESC
-- India recorded the highest number of administered vaccine doses during the analyzed period, reaching 142,586,233 vaccinations.
-- Several countries, however, reported no vaccinations during the same period.
-- Absolute vaccination counts can be misleading due to large differences in population size across countries.
-- Therefore, vaccination coverage was also evaluated as a percentage of each country's population.
-- Based on vaccination coverage, Bhutan recorded the highest percentage of vaccinated people, with approximately 62% of its population having received vaccinations.
-- Countries that reported no vaccinations remained at 0% vaccination coverage, representing the lowest level of vaccine uptake in the dataset.



