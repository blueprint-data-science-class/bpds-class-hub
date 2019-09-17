library(tidyverse)



# BIND ROWS ---------------------------------------------------------------

# if you have the same information about different sets of rows, bind them!

fship <- tribble(
                         ~Film,    ~Race, ~Female, ~Male,
  "The Fellowship Of The Ring",    "Elf",    1229,   971,
  "The Fellowship Of The Ring", "Hobbit",      14,  3644,
  "The Fellowship Of The Ring",    "Man",       0,  1995
)

rking <- tribble(
                     ~Film,    ~Race, ~Female, ~Male,
  "The Return Of The King",    "Elf",     183,   510,
  "The Return Of The King", "Hobbit",       2,  2673,
  "The Return Of The King",    "Man",     268,  2459
)

ttow <- tribble(
             ~Film,    ~Race, ~Female, ~Male,
  "The Two Towers",    "Elf",     331,   513,
  "The Two Towers", "Hobbit",       0,  2463,
  "The Two Towers",    "Man",     401,  3589
)

lotr <- bind_rows(
  fship,
  rking,
  ttow
)

lotr


# BIND COLS ---------------------------------------------------------------

# just kidding, don't do it.
# instead of binding columns, look to the more robust joins

# JOINS -------------------------------------------------------------------

# When you want to add more information about the same observations, go ahead and join!
# Why we're only talking about left_join, not right_join, inner_join, and full_join

library(nycflights13)

# details about each flight
flights

# details about each airline
airlines

# details about each airport
airports


# TASK: find the median departure delay for flights by timezone of origin
#       for the five busiest airlines

# STEPS:
# - summarize the five busiest airlines
# - use left_join to get all the flights they ran
# - select the airport codes and timezones
# - left_join the timezone data into the filtered flights


# Find the 5 busiest airlines

top_five_carriers <- flights %>%

  # Fpr each carrier
  group_by(carrier) %>%

  # Calculate n_flights as the number of rows
  summarize(n_flights = n()) %>%

  # Order by n_flights descending
  arrange(desc(n_flights)) %>%

  # take the first 5 rows
  slice(1:5)

top_five_carriers

# LEFT JOIN the whole flights table into top_five_carriers to keep only
# the flights from the top five carriers

# here, we're using it as a kind of filter
top_five_flights <- top_five_carriers %>%

  # left join
  left_join(

    # flights into top_five_carriers
    flights,

    # using the key variable "carrier", named the same thing in both tables
    by = "carrier"
  )

top_five_flights

# select just the faa code and timezone data from the airport table
airport_timezones <- airports %>%

  select(
    faa,
    tzone
  )


# LEFT JOIN destination airport timezones into the flights table
top_five_flights <- top_five_flights %>%

  # left join
  left_join(

    # airport_timezones into top_five flights
    airport_timezones,

    # here, the variables have different names
    by = c("dest" = "faa")
  ) %>%

  rename(
    # now tzone means something different
    destination_timezone = tzone
  )

# Quick aside: losing data

# - 7602 flights don't have destinations in the airport table
# - this is a nice illustration of a common problem
# - irl, we would look for a detailed explanation for their missingness
# - common options:
#   + typos in identifiers
#   + data entry gaps
#   + time-specific data system updates
# - for this example, we're just going to cut them out
# - we're also missing a bunch of timing data, to which the same thinking applies

top_five_flights <- top_five_flights %>%

  filter(
    !is.na(destination_timezone),
    !is.na(dep_delay),
    !is.na(arr_delay)
  )


departure_delay_by_tz <- top_five_flights %>%

  group_by(
    destination_timezone
  ) %>%

  summarize(
    mean_departure_delay = mean(dep_delay),
    on_time_pct = mean(dep_delay < 0)
  )


departure_delay_by_tz

# make a bar chart :)

departure_delay_by_tz %>%

  ggplot(aes(destination_timezone, mean_departure_delay)) +

  geom_col() +

  coord_flip()



# how does departure_delay relate to arrival delay?

top_five_flights %>%

  sample_n(5000) %>%

  ggplot(aes(dep_delay, arr_delay)) +

  geom_point() +

  geom_smooth(method = "lm", se = FALSE) +

  coord_fixed()










