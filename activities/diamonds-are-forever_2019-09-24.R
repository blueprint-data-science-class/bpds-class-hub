library(tidyverse)
library(ggbeeswarm)


# GGPLOT

dat <- diamonds %>% sample_frac(0.1)

# set ggplot theme
theme_set(theme_minimal())

# BAR CHARTS --------------------------------------------------------------

# summarize data for chart
cut_color_count <- dat %>% count(cut, color)

# Use geom_col to produce a basic bar chart
cut_color_count %>% 
  
  # ggplot object
  ggplot(
    # global mapping
    mapping = aes(x = cut, y = n)
  ) + 
  
  # geometry layer
  # geom_col() will stack all y values
  geom_col()

# Use geometry-specific mapping to fill by diamond colour
cut_color_count %>% 
  
  # ggplot object
  ggplot(
    # global mapping
    mapping = aes(cut, n)
  ) + 
  
  # geometry layer
  geom_col(
    # geometry-specific mapping
    mapping = aes(fill = color)
  )



# SCATTER PLOTS -----------------------------------------------------------


# basic scatter plot
dat %>% 
  
  # ggplot object
  ggplot(
    # global mapping
    mapping = aes(x = carat, y = price)
  ) + 
  
  # geom_point draws a point for each row in the data
  geom_point(
    # static parameters can be passed directly into the geom
    shape = 21, 
    size = 2, 
    alpha = 0.8, 
    fill = "darkred"
  )


# facet to produce small multiples
dat %>% 
  
  ggplot(
    mapping = aes(x = carat, y = price)
  ) + 
  
  geom_point(
    shape = 21, 
    size = 2, 
    alpha = 0.8, 
    fill = "tomato"
  ) + 
  
  facet_wrap(vars(clarity))



# LAYERING MULTIPLE GEOMS -------------------------------------------------


# distributions with ggbeeswarm
dat %>% 
  
  ggplot(
    aes(
      # first two arguments are always x and y
      cut, 
      price
    )
  ) + 
  
  geom_bar(
    stat = "summary", 
    fun.y = "mean", 
    alpha = 0.2
  ) + 
  
  geom_quasirandom(
    # geom_quasirandom plots every point and takes the same parameters as geom_point
    shape = 21, 
    fill = "tomato",
    alpha = 0.7
  )
  
