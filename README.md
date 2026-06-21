# COVID-19 Data Exploration with SQL

## Project Overview

This project explores global COVID-19 cases, deaths, and vaccination trends using SQL. The analysis is based on publicly available data from Our World in Data, covering approximately 190 countries between January 22, 2020 and April 30, 2021.

The goal of the project is to practice data cleaning, transformation, aggregation, and exploratory data analysis (EDA) using SQL while extracting meaningful insights from real-world pandemic data.

## Dataset

The dataset contains daily records for countries worldwide, including:

* Date
* Country and Continent
* Population
* New and Total COVID-19 Cases
* New and Total Deaths
* New Vaccinations

Source:
Our World in Data COVID-19 Dataset

## Skills Demonstrated

* Data Cleaning
* Data Type Conversion
* Aggregate Functions
* Joins
* Common Table Expressions (CTEs)
* Window Functions
* Data Exploration
* Percentage Calculations
* Trend Analysis

## Analysis Performed

### Data Preparation

* Converted date fields into DATE format.
* Converted vaccination-related columns from text to numeric data types.
* Handled null and missing values.

### COVID-19 Death Analysis

* Identified countries with the highest and lowest reported deaths.
* Calculated death rates relative to population size.
* Compared COVID-19 mortality across continents.

### Global Trend Analysis

* Aggregated worldwide daily cases and deaths.
* Calculated daily death percentages.
* Examined how the pandemic evolved over time.

### Vaccination Analysis

* Identified the earliest reported vaccination records.
* Calculated cumulative vaccinations by country.
* Measured vaccination coverage as a percentage of population.
* Compared vaccination progress across countries.

## Key Findings

* The United States recorded the highest absolute number of reported deaths during the analyzed period.
* Hungary experienced the highest death rate relative to population size.
* Europe recorded the largest number of reported deaths among continents.
* South America had the highest death rate relative to population.
* Mexico reported some of the earliest vaccination records in the dataset.
* India administered the highest number of vaccine doses.
* Bhutan achieved the highest vaccination coverage, reaching approximately 62% of its population.

## Technologies Used
* MySQL Workbench
