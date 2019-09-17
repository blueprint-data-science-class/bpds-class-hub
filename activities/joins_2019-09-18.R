library(tidyverse)

library(tidyverse) ## dplyr provides the join functions  

superheroes <- tibble::tribble(
	~name, ~alignment,  ~gender,          ~publisher,    
    "Magneto",      "bad",   "male",            "Marvel",      
      "Storm",     "good", "female",            "Marvel",   
   "Mystique",      "bad", "female",            "Marvel",     "
      Batman",     "good",   "male",                "DC",      
      "Joker",      "bad",   "male",                "DC",   
   "Catwoman",      "bad", "female",                "DC",    
    "Hellboy",     "good",   "male", "Dark Horse Comics"   
)  

publishers <- tibble::tribble( 
	~publisher, ~yr_founded,         
	      "DC",       1934L,     
	  "Marvel",       1939L,      
	   "Image",       1992L   
)


