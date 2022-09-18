--SELECT *
--FROM Case_Study_#1.dbo.Covid_Deaths$
--Order By 3,4

-- Becomes this when we're trying to remove the null continent information. 

SELECT *
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE continent is not null
Order By 3,4



/* comment
SELECT *
FROM Case_Study_#1.dbo.Covid_Vaccinations$
Order By 3,4

comment
*/ 

/* Another comment!
Select the data that we're going to be using 
*/


SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM Case_Study_#1.dbo.Covid_Deaths$
ORDER By 1,2

--SELECT *
--FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'Japan'

--SELECT *
--FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'United States'



/* 
Next we will be looking at total cases vs total deaths 
Show likelihood of dying if you contract covid in your country
*/



SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) 
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'United States'
OR
location = 'Japan'
ORDER By 1,2


/* 
For the above query, I wanted to see a comparision between the two. However, when you run the above line, it's all in one 
chart. I wanted to see it in two comparative charts. Therefore... this next segment of code will be a comparison in two charts.

Could use the bottom two chunks for my capstone. 
*/


--SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
--FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'United States'

--SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
--FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'Japan'

/* 
In the youtube video, Alex used 
Where location like '%states%' instead of using 
WHERE location = 'United States'

I like my example more for syntax and likelihood of using it in real life examples. 
*/




--First block of code becomes the second block of code 
--SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)
--FROM Case_Study_#1.dbo.Covid_Deaths$
--ORDER By 1,2

--SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
--FROM Case_Study_#1.dbo.Covid_Deaths$
--ORDER By 1,2

/* 
Show likelihood of dying if you contract covid in US and Japan
SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'United States'
ORDER By 1,2 

SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'Japan'
ORDER By 1,2 

*/


SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'United States'
ORDER By 1,2 

SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'Japan'
ORDER By 1,2 


--Looking at Total_Cases vs Population
--Shows what percentage of the population has gotten covid

/*
SELECT Location, date, total_cases, new_cases, population, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage, (total_cases/population) * 100 as Population_Had_Covid
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'United States'
ORDER By 1,2 

SELECT Location, date, total_cases, new_cases, population, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage, (total_cases/population) * 100 as Population_Had_Covid
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'Japan'
ORDER By 1,2 
*/




SELECT Location, date, total_cases, new_cases, population, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage, (total_cases/population) * 100 as Population_Had_Covid
FROM Case_Study_#1.dbo.Covid_Deaths$
ORDER By 1,2 

--Next we will look at Countries with the highest infection rate compared to the population. 
SELECT Location, population, MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/population)) * 100 as Percent_Population_Had_Covid
FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'United States'
GROUP By Location, population
ORDER By Percent_Population_Had_Covid desc



--Showing countries with the highest death rate per population--
SELECT Location, MAX(Cast(Total_deaths as int)) as total_death_count --total_deaths is nvarchar type. Converting it to an integer
FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'United States'
WHERE continent is not null -- This is necessary otherwise we would have other geographic data compromising our data. Try running without this and see what appears
GROUP By Location
ORDER By total_death_count desc 


--Lets break things down by continent-- --Showing the continents with the highest death count-- 
SELECT continent, MAX(Cast(Total_deaths as int)) as total_death_count --total_deaths is nvarchar type. Converting it to an integer
FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'United States'
WHERE continent is not null -- This is necessary otherwise we would have other geographic data compromising our data. Try running without this and see what appears
GROUP By continent
ORDER By total_death_count desc 



--Global Numbers-- When you try running the Query below this, it returns an error. "Invalid in the select list because it is not contained in either an aggregate function
--or the group by clause... So we need to make it an aggregate function. Which is what the second Query will showcase. 

SELECT date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
--WHERE location = 'United States'
WHERE continent is not null
GROUP By date 
Order By 1,2



SELECT date, SUM(new_cases)-- total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE continent is not null
GROUP By date
ORDER By 1,2


-- Added new_deaths to this and tried to sum it. However, new_deaths is an nvarchar so we will have to cast it.
SELECT date, SUM(new_cases) as Global_Cases, SUM(CAST(new_deaths as int)) as Global_Deaths-- total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE continent is not null
GROUP By date
ORDER By 1,2


-- Next we will show the global death percentage using the code above and making additions.
SELECT date, SUM(new_cases) as Global_Cases, SUM(CAST(new_deaths as int)) as Global_Deaths, SUM(Cast(new_deaths as int))/SUM(new_cases) * 100 as Death_Percentage-- total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE continent is not null
GROUP By date
ORDER By 1,2

--If we remove date in the SELECT line and remove Group BY. Then run the Query, it will give us total cases, total deaths, and the death percentage from covid globally.
SELECT SUM(new_cases) as Global_Cases, SUM(CAST(new_deaths as int)) as Global_Deaths, SUM(Cast(new_deaths as int))/SUM(new_cases) * 100 as Death_Percentage-- total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE continent is not null
--GROUP By date
ORDER By 1,2




SELECT SUM(new_cases) as Global_Cases, SUM(CAST(new_deaths as int)) as Global_Deaths, SUM(Cast(new_deaths as int))/SUM(new_cases) * 100 as Death_Percentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'United States'
ORDER By 1,2 

SELECT SUM(new_cases) as Global_Cases, SUM(CAST(new_deaths as int)) as Global_Deaths, SUM(Cast(new_deaths as int))/SUM(new_cases) * 100 as Death_Percentage
FROM Case_Study_#1.dbo.Covid_Deaths$
WHERE location = 'Japan'
ORDER By 1,2 



-- Joined the tables together to lineup the death data with vaccination data.
--Looking at Total Population vs Vaccinations
SELECT *
FROM Case_Study_#1.dbo.Covid_Deaths$ dea -- dea is the abbreviation
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac -- vac is the abbreviation
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common


--Let's make it more specific--
--Looking at Total Population vs Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM Case_Study_#1.dbo.Covid_Deaths$ dea 
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common
WHERE dea.continent is not null 
ORDER By 2,3

--We want to create a rolling count in the table. As the vacc number increases, we want to add it on the side. 
--Using partition by and a windows function.
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as bigint)) OVER (Partition by dea.location)-- int wasn't working here. Got error for arithmetic overflow error converting to int. Used bigint instead and it works
FROM Case_Study_#1.dbo.Covid_Deaths$ dea 
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common
WHERE dea.continent is not null 
ORDER By 2,3



-- Partitioned on the location, but the vaccinated population isn't tallying so we need to add items to the above Query
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as bigint)) OVER (Partition by dea.location)-- int wasn't working here. Got error for arithmetic overflow error converting to int. Used bigint instead and it works
FROM Case_Study_#1.dbo.Covid_Deaths$ dea 
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common
WHERE dea.continent is not null 
ORDER By 2,3

-- Since we're partitioning on albania but we need to partition by the date too for the vaccination tally. 
-- With the below Query you will see that the vaccination tally is increasing with new vaccinations.
--However we need to make a CTE or temp table as Rolling_People_Vaccinated can't be used since it was just created
--and then reference it in the Query
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date)
AS Rolling_People_Vaccinated,
(Rolling_People_Vaccinated/population) * 100-- int wasn't working here. Got error for arithmetic overflow error converting to int. Used bigint instead and it works
FROM Case_Study_#1.dbo.Covid_Deaths$ dea 
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common
WHERE dea.continent is not null 
ORDER By 2,3


---Next we will look at the total populations vs vaccinations. We want to use Rolling_People_Vaccinated above
--since the bottom per country is the max number. 
--We want to use that number and divide it by the population to know how many people in that country are vaccinated.
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Rolling_People_Vaccinated)
AS (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date)
AS Rolling_People_Vaccinated
--(Rolling_People_Vaccinated/population) * 100-- int wasn't working here. Got error for arithmetic overflow error converting to int. Used bigint instead and it works
FROM Case_Study_#1.dbo.Covid_Deaths$ dea 
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common
WHERE dea.continent is not null 
--ORDER By 2,3
) 
SELECT *, (Rolling_People_Vaccinated/Population) * 100
FROM PopvsVac 


-- Temp Table--
Create Table #Percent_Population_Vaccinated
(
Continent nvarchar(255),
Location nvarchar(255), 
Date datetime,
Population numeric,
New_vaccinations numeric, 
Rolling_People_Vaccinated numeric)


Insert Into #Percent_Population_Vaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date)
AS Rolling_People_Vaccinated
--(Rolling_People_Vaccinated/population) * 100-- int wasn't working here. Got error for arithmetic overflow error converting to int. Used bigint instead and it works
FROM Case_Study_#1.dbo.Covid_Deaths$ dea 
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common
WHERE dea.continent is not null 
--ORDER By 2,3
SELECT *, (Rolling_People_Vaccinated/Population) * 100
FROM #Percent_Population_Vaccinated


--Creating View to store data for later visualization

Create View PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date)
AS Rolling_People_Vaccinated
--(Rolling_People_Vaccinated/population) * 100-- int wasn't working here. Got error for arithmetic overflow error converting to int. Used bigint instead and it works
FROM Case_Study_#1.dbo.Covid_Deaths$ dea 
JOIN Case_Study_#1.dbo.Covid_Vaccinations$ vac
	ON dea.location = vac.location -- Joining on the location as the two tables have these values in common
	and dea.date = vac.date -- Joining on the date as the two tables have these values in common
WHERE dea.continent is not null 
--ORDER By 2,3 -- Can't have order by when making views. 

