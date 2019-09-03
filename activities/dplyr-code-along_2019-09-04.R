
# LOAD THE DATA -----------------------------------------------------------

## Install the packages you need (if you haven't already)

install.packages("gapminder")
install.packages("skimr")
install.packages("dplyr")

## Load the packages

library(gapminder)
library(dplyr)
library(skimr)

## Look at the data with skimr

skim(gapminder)

gapminder %>% count(continent)


# THE VIPS ----------------------------------------------------------------

## filter for the rows you want

gapminder %>% 
  
  # Get all the observations for African countries
  filter(
    continent == "Africa"
  ) 

gapminder %>% 
  
  # Get all the observations for Asian countries before 1980
  filter(
    continent == "Asia", 
    year < 1980
  )

## Select the columns you care about

gapminder %>% 

  # Select positively
  select(
    country, 
    continent, 
    year, 
    lifeExp
  )

## arrange rows in the right order

gapminder %>% 
  
  # Sort the oldest observations with the highest populations to the top
  arrange(
    year, 
    desc(pop)
  )

## mutate the data frame to add or change columns

gapminder %>% 
  
  # Calculate each country-year pair's total gdp
  mutate(
    gdp = gdpPercap * pop
  )


## summarize to execute aggregate calculations

gapminder %>% 
  
  summarize(
    median_gdp_percap = median(gdpPercap), 
    median_population = median(pop)
  )


# PLAN THE PARTY HOW YOU LIKE ---------------------------------------------

## just grouping the data doesn't change its contents at all
## It changes the way that subsequent functions are applied to it
gapminder %>% 
  
  group_by(continent)

## The old stand-by: group, then summarize

gapminder %>% 
  
  # For each continent
  group_by(continent) %>% 
  
  # get the median gdp per capita and the median population
  summarize(
    median_gdp_percap = median(gdpPercap), 
    median_population = median(pop)
  )

## Group, mutate, ungroup

gapminder %>% 
  
  # For each continent, for each year
  group_by(
    continent, 
    year
  ) %>% 
  
  # Add columns to the data frame representing
  mutate(
    # The continental median life expectancy
    life_exp_continental_median = median(lifeExp),
    
    # Each country's difference from that median
    life_exp_relative_to_continental_median = lifeExp - life_exp_continental_median
  ) %>% 
  
  # unlike summarize, mutate does not discard groups
  ungroup()


# NOW YOU DO IT -----------------------------------------------------------

## Use filter %>% group_by %>% summarize to get the median lifeExp by continent in 1952

### Which continent has the highest median lifeExp ? 

## Use group_by %>% mutate to get the median population for each continent year,
## and the difference from that median population for each row





