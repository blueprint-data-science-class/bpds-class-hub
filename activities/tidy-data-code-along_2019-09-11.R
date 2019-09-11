
library(tidyverse)
library(janitor)


load_lotr_data <- function() {
  
  movie_slugs <- c("The_Fellowship_Of_The_Ring", "The_Two_Towers", "The_Return_Of_The_King")

  urls <- glue::glue("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/{movie_slugs}.csv")
  
  raw <- urls %>% map(curl::curl_fetch_memory)
  
  chr <- raw %>% map("content") %>% map(rawToChar)
  
  dat <- chr %>% map(read_csv)
  
  res <- dat %>% bind_rows() %>% 
    
    mutate(
      Film = fct_relevel(Film, "The Fellowship Of The Ring", "The Two Towers", "The Return Of The King")
    )
  
  res
  
}


untidy_lotr_data <- load_lotr_data()

untidy_lotr_data


# Aside: clean_names
untidy_lotr_data <- untidy_lotr_data %>% janitor::clean_names()

untidy_lotr_data


# Use gather to tidy it up!
tidy_lotr_data <- untidy_lotr_data %>% 
  
  gather(
    
    # The key is the name of the column that will contain the names of the gathered columns
    key = gender, 
    
    # The value is the name of the column that will contain the values in the gathered columns
    value = words_spoken, 
    
    # After specifying the names of the new columns, specify the names of the columns to be gathered
    male, 
    female
  )



# make the data set too long, 
# - one column reps multiple variables
# - each observation is spread over multiple rows
too_tidy_lotr_data <- tidy_lotr_data %>% 
  
  gather(
    key = variable, 
    value = value, 
    
    gender, 
    race
  )

too_tidy_lotr_data


# spread it out wide again

tidy_again_lotr_data <- too_tidy_lotr_data %>% 
  
  spread(
    variable, 
    value
  )

all.equal(tidy_lotr_data, tidy_again_lotr_data)


# Tidy data unlocks the power of ggplot2

bar_sideways <- tidy_lotr_data %>% 
  
  
  ggplot(aes(x = film, y = words_spoken)) + 
  
  geom_col(aes(fill = gender), position = "dodge") + 
  
  coord_flip()

bar_sideways


facets <- bar_sideways + 
  
  facet_wrap(~ race, ncol = 1) 
  

facets

# Untidy data has its uses though...

# like calculating ratios, or other stats where you're changing the unit of analysis

fm_words_ratio <- untidy_lotr_data %>% 
  
  mutate(
    female_words_to_male_words = female / male
  )

fm_words_ratio


# or calculating a bunch of univariate summaries at once

gender_and_race_counts <- too_tidy_lotr_data %>% 
  
  group_by(
    variable, 
    value
  ) %>% 
  
  summarize(
    words_spoken = sum(words_spoken)
  )

gender_and_race_counts
